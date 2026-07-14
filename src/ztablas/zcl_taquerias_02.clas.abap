CLASS zcl_taquerias_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_taquerias_02 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    out->write('INICIO').
    DELETE FROM ztaquerias_02. "BORRA LA BBDD ANTES

    " === DECLARACIÓN DE VARIABLES ===
    DATA: ls_taqueria  TYPE ztaquerias_02, "Estructura
          lt_taquerias TYPE TABLE OF ztaquerias_02, "Tabla
          lv_contador  TYPE i.


    " === 1. CREATE: Insertando taquerias ===
    CLEAR ls_taqueria.
    ls_taqueria-id_taqueria   = 'LCA00000001'.
    ls_taqueria-nombre        = 'El Pastor'.
    ls_taqueria-estado        = 'JA'.
    ls_taqueria-especialidad  = 'PA'.
    ls_taqueria-nivel_picante = 3.
    ls_taqueria-precio_taco   = '15.00'.
    ls_taqueria-moneda = 'EUR'.

    INSERT ztaquerias_02 FROM @ls_taqueria.
    IF sy-subrc = 0.
      out->write( |Taqueria TAQ001 insertada correctamente| ).
    ELSE.
      out->write( |Error al insertar TAQ001| ).
    ENDIF.

*    CLEAR ls_taqueria.
*    ls_taqueria-id_taqueria   = 'TAQ002A'.
*    ls_taqueria-nombre        = 'Taqueria Huelva'.
*    ls_taqueria-estado        = 'OX'.
*    ls_taqueria-especialidad  = 'BA'.
*    ls_taqueria-nivel_picante = 4.
*    ls_taqueria-precio_taco   = '20.00'.
*    ls_taqueria-moneda = 'EUR'.
*
*    INSERT ztaquerias_02 FROM @ls_taqueria.
*    IF sy-subrc = 0.
*      out->write( |Taqueria TAQ002 insertada correctamente| ).
*    ELSE.
*      out->write( |Error al insertar TAQ002| ).
*    ENDIF.
*
*    CLEAR ls_taqueria.
*    ls_taqueria-id_taqueria   = 'TAQ003'.
*    ls_taqueria-nombre        = 'Cochinita Pibil'.
*    ls_taqueria-estado        = 'YU'.
*    ls_taqueria-especialidad  = 'CO'.
*    ls_taqueria-nivel_picante = 2.
*    ls_taqueria-precio_taco   = '18.00'.
*    ls_taqueria-moneda = 'EUR'.
*
*    INSERT ztaquerias_02 FROM @ls_taqueria.
*    IF sy-subrc = 0.
*      out->write( |Taqueria TAQ003 insertada correctamente| ).
*    ELSE.
*      out->write( |Error al insertar TAQ003| ).
*    ENDIF.
*
*    out->write( '---------------------------------------' ).

*
*
*    " === 2. CREATE (ERROR): Clave duplicada ===
*    CLEAR ls_taqueria.
*    ls_taqueria-id_taqueria   = 'TAQ001'.
*    ls_taqueria-nombre        = 'Duplicado de prueba'.
*    ls_taqueria-estado        = 'PU'.
*    ls_taqueria-especialidad  = 'CA'.
*    ls_taqueria-nivel_picante = 1.
*    ls_taqueria-precio_taco   = '10.00'.
*    INSERT ztaquerias_00 FROM ls_taqueria.
*    IF sy-subrc = 0.
*      out->write( |Insercion duplicada correcta (no deberia pasar)| ).
*    ELSE.
*      out->write( |Error esperado: TAQ001 ya existe, sy-subrc = { sy-subrc }| ).
*    ENDIF.
*
*    out->write( '---------------------------------------' ).
*
*
*    " === 3. READ: Leer una taqueria por su ID ===
*    CLEAR ls_taqueria.
*    SELECT SINGLE * FROM ztaquerias_00
*      WHERE id_taqueria = 'TAQ001'
*      INTO CORRESPONDING FIELDS OF @ls_taqueria.
*
*    IF sy-subrc = 0.
*      out->write( |Taqueria encontrada: { ls_taqueria-nombre } - Estado: { ls_taqueria-estado } - Precio: { ls_taqueria-precio_taco }| ).
*    ELSE.
*      out->write( |No se ha encontrado la taqueria TAQ001| ).
*    ENDIF.
*
*    out->write( '---------------------------------------' ).
*
*
*    " === 4. READ (ERROR): Taqueria inexistente ===
*    CLEAR ls_taqueria.
*    SELECT SINGLE * FROM ztaquerias_00
*      WHERE id_taqueria = 'TAQ999'
*      INTO CORRESPONDING FIELDS OF @ls_taqueria.
*
*    IF sy-subrc = 0.
*      out->write( |Taqueria encontrada (no deberia pasar)| ).
*    ELSE.
*      out->write( |Error esperado: TAQ999 no existe, sy-subrc = { sy-subrc }| ).
*    ENDIF.
*
*    out->write( '---------------------------------------' ).
*
*
*    " === 5. READ: Listar taquerias por estado ===
*    CLEAR lt_taquerias.
*    SELECT * FROM ztaquerias_00
*      WHERE estado = 'JA'
*      INTO CORRESPONDING FIELDS OF TABLE @lt_taquerias.
*
*    out->write( |Numero de taquerias en Jalisco: { lines( lt_taquerias ) }| ).
*
*    LOOP AT lt_taquerias INTO ls_taqueria.
*      out->write( |- { ls_taqueria-id_taqueria } - { ls_taqueria-nombre }| ).
*    ENDLOOP.
*
*    out->write( '---------------------------------------' ).
*
*
*    " === 6. UPDATE: Actualizar precio ===
*    UPDATE ztaquerias_00
*      SET precio_taco = '17.50'
*      WHERE id_taqueria = 'TAQ001'.
*
*    IF sy-subrc = 0.
*      out->write( |Precio de TAQ001 actualizado correctamente| ).
*    ELSE.
*      out->write( |Error al actualizar el precio de TAQ001| ).
*    ENDIF.
*
*    out->write( '---------------------------------------' ).
*
*
*    " === 7. UPDATE (ERROR): Taqueria inexistente ===
*    UPDATE ztaquerias_00
*      SET precio_taco = '99.00'
*      WHERE id_taqueria = 'TAQ999'.
*
*    IF sy-subrc = 0.
*      out->write( |Actualizacion correcta (no deberia pasar)| ).
*    ELSE.
*      out->write( |Error esperado: no se puede actualizar TAQ999, sy-subrc = { sy-subrc }| ).
*    ENDIF.
*
*    out->write( '---------------------------------------' ).
*
*
*    " === 8. DELETE: Borrar taqueria ===
*    DELETE FROM ztaquerias_00 WHERE id_taqueria = 'TAQ003'.
*
*    IF sy-subrc = 0.
*      out->write( |Taqueria TAQ003 borrada correctamente| ).
*    ELSE.
*      out->write( |Error al borrar TAQ003| ).
*    ENDIF.
*
*    out->write( '---------------------------------------' ).
*
*
*    " === 9. READ final: Recuento ===
*    SELECT COUNT(*) FROM ztaquerias_00 INTO @lv_contador.
*
*    out->write( |Numero total de taquerias restantes: { lv_contador }| ).
*
*
*
  ENDMETHOD.
ENDCLASS.



