*----------------------------------------------------------------------*
* Enunciado B — Taller de bicicletas con base de datos (CRUD)
*----------------------------------------------------------------------*
*
* Este es distinto a todo lo anterior: en vez de guardar los datos solo
* en memoria (en atributos), esta vez se guardan de verdad en una tabla
* de base de datos, así que los datos sobreviven aunque el programa
* termine.
*
*----------------------------------------------------------------------*
* Contexto
*----------------------------------------------------------------------*
*
* Un taller de bicicletas registra las reparaciones que le entran. Cada
* reparación tiene un identificador, el nombre del cliente, una
* descripción de la avería, y un estado (pendiente / en curso / terminada).
*
*----------------------------------------------------------------------*
* Paso previo: crear la tabla
*----------------------------------------------------------------------*
*
* Antes de tocar ninguna clase, hay que crear una tabla de base de datos
* nueva (vía Data Definition en ADT), con estos campos orientativos:
*
* - client        (MANDT, campo obligatorio de todas las tablas)
* - id_reparacion (clave, tipo numérico, ej. NUMC de 10 posiciones)
* - cliente       (texto corto, ej. CHAR40)
* - averia        (texto, ej. CHAR100)
* - estado        (texto corto, ej. CHAR10, con valores como 'PENDIENTE',
*                  'EN CURSO', 'TERMINADA')
*
*----------------------------------------------------------------------*
* Comportamiento de la clase
*----------------------------------------------------------------------*
*
* Clase ZCL_TALLER_BICIS_XX, donde cada método hace una operación distinta
* contra la tabla (esto es justo lo que habéis practicado ya en clase
* con SQL sobre tablas custom, solo que ahora encapsulado dentro de
* métodos de una clase):
*
* - registrar_reparacion (el "Create"):
*     Recibe cliente y avería (IMPORTING), genera un nuevo id_reparacion
*     (puede ser tan simple como coger el máximo existente y sumarle 1),
*     inserta el registro en la tabla con estado 'PENDIENTE', y devuelve
*     (RETURNING) el id_reparacion generado.
*
* - consultar_reparacion (el "Read"):
*     Recibe un id_reparacion (IMPORTING), y devuelve (EXPORTING) el
*     cliente, la avería y el estado de esa reparación concreta.
*     Pensad qué debería pasar si el id_reparacion no existe en la tabla.
*
* - cambiar_estado (el "Update"):
*     Recibe id_reparacion y el nuevo estado (IMPORTING), y actualiza
*     esa fila en la tabla. Debe devolver (RETURNING) un abap_bool
*     indicando si la actualización se pudo hacer (por ejemplo, si el
*     id_reparacion no existía, no se puede actualizar).
*
* - eliminar_reparacion (el "Delete"):
*     Recibe id_reparacion (IMPORTING), borra esa fila de la tabla, y
*     devuelve (RETURNING) un abap_bool indicando si se pudo borrar.
*
* Clase de test ZCL_TEST_TALLER_BICIS_XX que:
* 1. Registre 2 reparaciones distintas y muestre los IDs generados.
* 2. Consulte una de ellas y muestre sus datos.
* 3. Cambie el estado de una a 'EN CURSO', y vuelva a consultarla para
*    comprobar que el cambio se ha guardado.
* 4. Elimine la otra reparación, e intente consultarla de nuevo
*    (debería indicar que ya no existe).
*
*----------------------------------------------------------------------*
* Pistas, ya que esta parte es nueva
*----------------------------------------------------------------------*
*
* - Para insertar, es la misma sentencia INSERT que ya habéis practicado
*   sobre tablas /DMO/, pero ahora sobre vuestra tabla nueva.
* - Para leer un único registro por clave, pensad en SELECT SINGLE,
*   igual que habéis hecho ya con /DMO/FLIGHT.
* - Para saber si algo existe o no tras una consulta, fijaos en cómo
*   comprobabais el resultado de sy-subrc después de un SELECT en los
*   ejercicios de clase.
* - Para actualizar, buscad la sentencia que modifica filas ya existentes
*   de una tabla (la habéis visto, aunque menos que INSERT y SELECT).
* - Para borrar, es una sentencia con nombre muy descriptivo — pensad en
*   su equivalente en inglés de "eliminar".
*
* Esta es la primera vez que unimos POO con acceso a base de datos real,
* así que si os atascáis con la sintaxis exacta de alguna sentencia SQL,
* preguntadlo — la lógica de los métodos (parámetros, RETURNING, IMPORTING)
* ya la dominamos, lo nuevo es solo el contenido de dentro de cada método.
*----------------------------------------------------------------------*
CLASS zcl_test_taller_bicis_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

ENDCLASS.


CLASS zcl_test_taller_bicis_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(lo_taller) = NEW zcl_taller_bicis_02( ).

    " ---- 1. Registrar dos reparaciones (Inlining con DATA) ----
    DATA(lv_id1) =   lo_taller->registrar_reparacion(
                     iv_cliente = 'Juan Perez'
                     iv_averia  = 'Pinchazo rueda trasera' ).

    DATA(lv_id2) = lo_taller->registrar_reparacion(
                     iv_cliente = 'Maria Lopez'
                     iv_averia  = 'Frenos no funcionan' ).

    out->write( |Reparacion 1 registrada con ID: { lv_id1 }| ).
    out->write( |Reparacion 2 registrada con ID: { lv_id2 }| ).

    " ---- 2. Consultar la primera (Declaración inline de parámetros EXPORTING) ----
    lo_taller->consultar_reparacion(
      EXPORTING iv_id         = lv_id1
      IMPORTING ev_cliente    = DATA(lv_cliente)
                ev_averia     = DATA(lv_averia)
                ev_estado     = DATA(lv_estado)
                ev_encontrado = DATA(lv_encontrado) ).

    IF lv_encontrado = abap_true.
      out->write( |Consulta reparacion { lv_id1 }: { lv_cliente }, | &&
                  |{ lv_averia }, estado { lv_estado }| ).
    ENDIF.

    " ---- 3. Cambiar estado de la primera y comprobar ----
    DATA(lv_ok) = lo_taller->cambiar_estado(
                    iv_id     = lv_id1
                    iv_estado = 'EN CURSO' ).

    out->write( |Cambio de estado reparacion { lv_id1 }: { lv_ok }| ).

    " Reutilizamos las variables declaradas anteriormente para sobrescribir
    lo_taller->consultar_reparacion(
      EXPORTING iv_id         = lv_id1
      IMPORTING ev_cliente    = lv_cliente
                ev_averia     = lv_averia
                ev_estado     = lv_estado
                ev_encontrado = lv_encontrado ).

    out->write( |Estado actual de reparacion { lv_id1 }: { lv_estado }| ).

    " ---- 4. Eliminar la segunda e intentar consultarla ----
    lv_ok = lo_taller->eliminar_reparacion( iv_id = lv_id2 ).
    out->write( |Eliminacion de reparacion { lv_id2 }: { lv_ok }| ).

    lo_taller->consultar_reparacion(
      EXPORTING iv_id         = lv_id2
      IMPORTING ev_cliente    = lv_cliente
                ev_averia     = lv_averia
                ev_estado     = lv_estado
                ev_encontrado = lv_encontrado ).

    IF lv_encontrado = abap_false.
      out->write( |La reparacion { lv_id2 } ya no existe.| ).
    ELSE.
      out->write( |ERROR: la reparacion { lv_id2 } aun existe.| ).
    ENDIF.



""""""""""""""""""""""""""""""""""""""Borrar REGISTROS"""""""""""""""""""""""""""""""""""""""""""""""""""""
*    DELETE FROM zdb_tallebici_02.
*
*    IF sy-subrc = 0.
*      COMMIT WORK.
*      out->write( |Tabla reiniciada. Registros borrados: { sy-dbcnt }| ).
*    ELSE.
*      out->write( 'La tabla ya está vacía o no se pudo modificar.' ).
*    ENDIF.

  ENDMETHOD.

ENDCLASS.
