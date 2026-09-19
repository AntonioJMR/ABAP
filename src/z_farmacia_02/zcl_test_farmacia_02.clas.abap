
** El enunciado esta apartir del final del codigo para
** poder ver antes este ya que es demssaido texto
** Esta aproximadamento sobre la linea 950

CLASS zcl_test_farmacia_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

ENDCLASS.


CLASS zcl_test_farmacia_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    TYPES:
      BEGIN OF ty_medicamento_datos,
        id                   TYPE i,
        nombre               TYPE string,
        laboratorio          TYPE string,
        precio               TYPE zdecimals2,
        stock                TYPE i,
        tipo                 TYPE c LENGTH 1,
        requiere_receta      TYPE abap_bool,
        principio_activo     TYPE string,
        coste_interno        TYPE zdecimals2,
        porcentaje_descuento TYPE i,
        nombre_comercial     TYPE string,
        recargo_marca        TYPE i,
      END OF ty_medicamento_datos.

    TYPES tt_medicamentos TYPE STANDARD TABLE OF ty_medicamento_datos
                          WITH EMPTY KEY.


    "============================================================
    " 1-9. CREAR TABLA DE MEDICAMENTOS
    "============================================================

    DATA(lt_medicamentos) = VALUE tt_medicamentos(

      ( id = 1
        nombre = 'Paracetamol'
        laboratorio = 'Cinfa'
        precio = '2.50'
        stock = 40
        tipo = 'G'
        requiere_receta = abap_false
        principio_activo = 'Paracetamol'
        coste_interno = '1.20'
        porcentaje_descuento = 10 )

      ( id = 2
        nombre = 'Ibuprofeno'
        laboratorio = 'Kern Pharma'
        precio = '3.80'
        stock = 15
        tipo = 'G'
        requiere_receta = abap_false
        principio_activo = 'Ibuprofeno'
        coste_interno = '1.80'
        porcentaje_descuento = 5 )

      ( id = 3
        nombre = 'Omeprazol'
        laboratorio = 'Cinfa'
        precio = '5.10'
        stock = 25
        tipo = 'G'
        requiere_receta = abap_false
        principio_activo = 'Omeprazol'
        coste_interno = '2.50'
        porcentaje_descuento = 20 )

      ( id = 4
        nombre = 'Amoxicilina'
        laboratorio = 'GSK'
        precio = '6.20'
        stock = 8
        tipo = 'M'
        requiere_receta = abap_true
        principio_activo = 'Amoxicilina + clavulánico'
        coste_interno = '3.10'
        nombre_comercial = 'Augmentine'
        recargo_marca = 10 )

      ( id = 5
        nombre = 'Acenocumarol'
        laboratorio = 'Viatris'
        precio = '4.90'
        stock = 3
        tipo = 'M'
        requiere_receta = abap_true
        principio_activo = 'Acenocumarol'
        coste_interno = '2.20'
        nombre_comercial = 'Sintrom'
        recargo_marca = 20 )

      ( id = 6
        nombre = 'Salbutamol'
        laboratorio = 'GSK'
        precio = '6.00'
        stock = 0
        tipo = 'M'
        requiere_receta = abap_true
        principio_activo = 'Salbutamol'
        coste_interno = '3.50'
        nombre_comercial = 'Ventolin'
        recargo_marca = 15 )
    ).


    out->write( '========================================' ).
    out->write( 'PRACTICA FARMACIA' ).
    out->write( '========================================' ).


    "============================================================
    " 10. COND - CATEGORIA DE STOCK
    "============================================================
    out->write(  '--- COND - CATEGORIA DE STOCK ---' ).


    DATA lv_categoria TYPE string.

    LOOP AT lt_medicamentos INTO DATA(ls_med).

      lv_categoria = COND string(
        WHEN ls_med-stock >= 30 THEN 'STOCK ALTO'
        WHEN ls_med-stock >= 10 THEN 'STOCK MEDIO'
        WHEN ls_med-stock >= 1  THEN 'STOCK BAJO'
        ELSE 'SIN STOCK'
      ).

      out->write(
        |ID { ls_med-id } - { lv_categoria }|
      ).

    ENDLOOP.


    "============================================================
    " 11. SWITCH - TIPO DE MEDICAMENTO
    "============================================================
    out->write(  ' --- SWITCH - TIPO DE MEDICAMENTO ---' ).


    DATA lv_tipo_descripcion TYPE string.

    LOOP AT lt_medicamentos INTO ls_med.

      lv_tipo_descripcion = SWITCH string(
        ls_med-tipo
        WHEN 'G' THEN 'GENÉRICO'
        WHEN 'M' THEN 'MARCA'
        WHEN 'H' THEN 'HOSPITALARIO'
        ELSE 'DESCONOCIDO'
      ).

      out->write(
        |ID { ls_med-id } - { lv_tipo_descripcion }|
      ).

    ENDLOOP.


    "============================================================
    " 12. XSDBOOL - DISPONIBILIDAD
    "============================================================
    out->write(  '--- XSDBOOL - DISPONIBILIDAD ---  ' ).

    DATA lv_disponible TYPE abap_bool.

    LOOP AT lt_medicamentos INTO ls_med.

      lv_disponible = xsdbool(
        ls_med-stock > 0
        AND ls_med-precio > 0
      ).

      out->write(
        |ID { ls_med-id } disponible: { lv_disponible }|
      ).

    ENDLOOP.


    "============================================================
    " 13. CONV
    "============================================================
    out->write(  '--- CONV ---  ' ).

    DATA lv_cantidad_texto TYPE string VALUE '12'.
    DATA lv_precio_texto   TYPE string VALUE '3.50'.

    DATA lv_cantidad TYPE i.
    DATA lv_precio   TYPE decfloat34.
    DATA lv_total    TYPE decfloat34.

    lv_cantidad = CONV i( lv_cantidad_texto ).
    lv_precio   = CONV decfloat34( lv_precio_texto ).

    lv_total = lv_cantidad * lv_precio.

    out->write( |CONV - Total: { lv_total }| ).


    "============================================================
    " 14. CONV ENTERO A DECIMAL
    "============================================================
    out->write(  '--- CONV - ENTERO A DECIMAL ---  ' ).

    DATA lv_entero TYPE i VALUE 25.
    DATA lv_decimal TYPE decfloat34.

    lv_decimal = CONV decfloat34( lv_entero ).

    out->write(
      |25 convertido a decimal: { lv_decimal }|
    ).


    "============================================================
    " 15. CONV DECIMAL A ENTERO
    "============================================================
    out->write(  '--- CONV - DECIMAL A ENTERO ---  ' ).

    DATA lv_decimal_2580 TYPE decfloat34 VALUE '25.80'.
    DATA lv_entero_2580 TYPE i.

    lv_entero_2580 = CONV i( lv_decimal_2580 ).

    out->write(
      |25.80 convertido a entero: { lv_entero_2580 }|
    ).


    "============================================================
    " 16. ROUND / TRUNC / CEIL / FLOOR
    "============================================================
    out->write(  '--- ROUND / TRUNC / CEIL / FLOOR ---  ' ).

    DATA lv_numero TYPE decfloat34 VALUE '25.80'.

    out->write(
      |ROUND: { round( val = lv_numero dec = 0 ) }|
    ).

    out->write(
      |TRUNC: { trunc( lv_numero  ) }|
    ).

    out->write(
      |CEIL: { ceil( lv_numero ) }|
    ).

    out->write(
      |FLOOR: { floor( lv_numero ) }|
    ).


    "============================================================
    " 17. EXACT - CONVERSION CORRECTA
    "============================================================
    out->write(  '--- EXACT - CONVERSION CORRECTA ---  ' ).

    DATA lv_exact_texto TYPE string VALUE '25.00'.
    DATA lv_exact_entero TYPE i.

    TRY.

        lv_exact_entero = EXACT i( lv_exact_texto ).

        out->write(
          |EXACT correcto: { lv_exact_entero }|
        ).

      CATCH cx_sy_conversion_error.

        out->write( 'Error en EXACT' ).

    ENDTRY.


    "============================================================
    " 18. EXACT - CONVERSION CON PERDIDA
    "============================================================
    out->write(  '--- EXACT - CONVERSION CON PERDIDA ---  ' ).

    lv_exact_texto = '25.75'.

    TRY.

        lv_exact_entero = EXACT i( lv_exact_texto ).

        out->write( lv_exact_entero ).

      CATCH cx_sy_conversion_error.

        out->write(
          'EXACT: no se puede convertir 25.75 a entero'
        ).

    ENDTRY.


    "============================================================
    " 19. EXPRESION DE TABLA
    "============================================================
    out->write(  '--- EXPRESION DE TABLA ---  ' ).

    DATA(ls_id_3) = lt_medicamentos[ id = 3 ].

    out->write(
      |ID 3: { ls_id_3-nombre }|
    ).


    "============================================================
    " 20. ACCESO DIRECTO A CAMPO
    "============================================================
    out->write(  '--- ACCESO DIRECTO A CAMPO ---' ).

    DATA(lv_nombre_4) =
      lt_medicamentos[ id = 4 ]-nombre.

    out->write( lv_nombre_4 ).


    "============================================================
    " 21. PRECIO DIRECTO
    "============================================================
    out->write(  '--- PRECIO DIRECTO ---' ).

    DATA(lv_precio_2) =
      lt_medicamentos[ id = 2 ]-precio.

    out->write( lv_precio_2 ).


    "============================================================
    " 22. ACCESO POR INDICE
    "============================================================
    out->write(  '--- ACCESO POR INDICE ---' ).

    DATA(ls_primero) =
      lt_medicamentos[ 1 ].

    out->write(
      |Primer medicamento: { ls_primero-nombre }|
    ).


    "============================================================
    " 23. TRY / CATCH
    "============================================================
    out->write(  '--- TRY / CATCH ---' ).

    TRY.

        DATA(ls_no_existe) =
          lt_medicamentos[ id = 99 ].

        out->write( ls_no_existe ).

      CATCH cx_sy_itab_line_not_found.

        out->write(
          'MEDICAMENTO NO ENCONTRADO'
        ).

    ENDTRY.


    "============================================================
    " 24. LINE_EXISTS
    "============================================================
    out->write(  '--- LINE_EXISTS ---' ).

    DATA lv_existe TYPE abap_bool.

    lv_existe = xsdbool(
      line_exists(
        lt_medicamentos[ id = 5 ]
      )
    ).

    out->write(
      |ID 5 existe: { lv_existe }|
    ).

    lv_existe = xsdbool(
      line_exists(
        lt_medicamentos[ id = 99 ]
      )
    ).

    out->write(
      |ID 99 existe: { lv_existe }|
    ).


    "============================================================
    " 25. OPTIONAL
    "============================================================
    out->write(  '--- OPTIONAL ---' ).

    DATA(ls_optional) =
      VALUE ty_medicamento_datos(
        lt_medicamentos[ id = 99 ] OPTIONAL
      ).

    out->write(
      |OPTIONAL ID: { ls_optional-id }|
    ).

    out->write(
      |OPTIONAL nombre: { ls_optional-nombre }|
    ).


    "============================================================
    " 26. DEFAULT
    "============================================================
    out->write(  '--- DEFAULT ---' ).

    DATA(ls_default) =
      VALUE ty_medicamento_datos(
        lt_medicamentos[ id = 99 ]
        DEFAULT VALUE ty_medicamento_datos(
          nombre = 'MEDICAMENTO NO ENCONTRADO'
        )
      ).

    out->write( ls_default-nombre ).


    "============================================================
    " 27. LINE_INDEX
    "============================================================
    out->write(  '--- LINE_INDEX ---' ).


    DATA lv_posicion TYPE i.

    lv_posicion =
      line_index(
        lt_medicamentos[ id = 3 ]
      ).

    out->write(
      |Posición ID 3: { lv_posicion }|
    ).

    lv_posicion =
      line_index(
        lt_medicamentos[ id = 99 ]
      ).

    out->write(
      |Posición ID 99: { lv_posicion }|
    ).


    "============================================================
    " 28. TIPO PUBLICO
    "============================================================
    out->write(  '--- TIPO PUBLICO ---' ).

    TYPES:
      BEGIN OF ty_medicamento_publico,
        id          TYPE i,
        nombre      TYPE string,
        laboratorio TYPE string,
        precio      TYPE zdecimals2,
        stock       TYPE i,
      END OF ty_medicamento_publico.

    TYPES tt_medicamentos_publicos
      TYPE STANDARD TABLE OF ty_medicamento_publico
      WITH EMPTY KEY.


    "============================================================
    " 29. CORRESPONDING
    "============================================================
    out->write(  '--- CORRESPONDING ---' ).


    DATA(lt_medicamentos_publicos) =
      CORRESPONDING tt_medicamentos_publicos(
        lt_medicamentos
      ).

    out->write(
      lt_medicamentos_publicos
    ).


    "============================================================
    " 30. MAPPING
    "============================================================
    out->write(  '--- MAPPING ---' ).

    TYPES:
      BEGIN OF ty_medicamento_externo,
        codigo      TYPE i,
        descripcion TYPE string,
        fabricante  TYPE string,
        precio      TYPE zdecimals2,
        unidades    TYPE i,
      END OF ty_medicamento_externo.

    TYPES tt_medicamentos_externos
      TYPE STANDARD TABLE OF ty_medicamento_externo
      WITH EMPTY KEY.


    DATA(lt_medicamentos_externos) =
      CORRESPONDING tt_medicamentos_externos(
        lt_medicamentos
        MAPPING
          codigo      = id
          descripcion = nombre
          fabricante  = laboratorio
          precio      = precio
          unidades    = stock
      ).

    out->write(
      lt_medicamentos_externos
    ).


    "============================================================
    " 31. EXCEPT
    "============================================================
    out->write(  '--- EXCEPT ---' ).

    TYPES:
      BEGIN OF ty_medicamento_auditoria,
        id            TYPE i,
        nombre        TYPE string,
        precio        TYPE zdecimals2,
        coste_interno TYPE zdecimals2,
      END OF ty_medicamento_auditoria.

    DATA(ls_auditoria) =
      CORRESPONDING ty_medicamento_auditoria(
        lt_medicamentos[ id = 1 ]
        EXCEPT coste_interno
      ).

    out->write( ls_auditoria ).


    "============================================================
    " 32. BASE
    "============================================================
    out->write(  '--- BASE ---' ).

    DATA(ls_original) =
      lt_medicamentos[ id = 2 ].

    DATA(ls_nuevo) =
      VALUE ty_medicamento_datos(
        BASE ls_original
        stock = 35
      ).

    out->write(
      |Stock original: { ls_original-stock }|
    ).

    out->write(
      |Stock nuevo: { ls_nuevo-stock }|
    ).


    "============================================================
    " 33. FOR
    "============================================================
    out->write(  '--- FOR ---' ).

    TYPES:
      BEGIN OF ty_resumen_medicamento,
        id     TYPE i,
        nombre TYPE string,
        precio TYPE zdecimals2,
        stock  TYPE i,
      END OF ty_resumen_medicamento.

    TYPES tt_resumen_medicamentos
      TYPE STANDARD TABLE OF ty_resumen_medicamento
      WITH EMPTY KEY.


    DATA(lt_resumen) =
      VALUE tt_resumen_medicamentos(

        FOR medicamento IN lt_medicamentos

        (
          id     = medicamento-id
          nombre = medicamento-nombre
          precio = medicamento-precio
          stock  = medicamento-stock
        )
      ).

    out->write( lt_resumen ).


    "============================================================
    " 34. FOR + CORRESPONDING
    "============================================================
    out->write(  '--- FOR + CORRESPONDING ---' ).

    DATA(lt_publicos_2) =
      VALUE tt_medicamentos_publicos(

        FOR medicamento IN lt_medicamentos

        (
          CORRESPONDING #(
            medicamento
          )
        )
      ).

    out->write( lt_publicos_2 ).


    "============================================================
    " 35. LET + FOR
    "============================================================
    out->write(  '--- LET + FOR ---' ).

    TYPES:
      BEGIN OF ty_valor_stock,
        id            TYPE i,
        nombre        TYPE string,
        subtotal      TYPE decfloat34, "no uso el Zdecimals2 pq me estaba dando problemas a no ser un standar
        iva           TYPE decfloat34,
        total_con_iva TYPE decfloat34,
      END OF ty_valor_stock.

    TYPES tt_valor_stock TYPE STANDARD TABLE OF ty_valor_stock
                         WITH EMPTY KEY.


    DATA(lt_valor_stock) =
      VALUE tt_valor_stock(

            FOR medicamento IN lt_medicamentos

            LET subtotal = CONV decfloat34( medicamento-precio ) * medicamento-stock
                iva = subtotal * '0.04'

            IN
            (
              id            = medicamento-id
              nombre        = medicamento-nombre
              subtotal      = subtotal
              iva           = iva
              total_con_iva = subtotal + iva
            )
      ).

    out->write( lt_valor_stock ).


    "============================================================
    " 36. SORTED TABLE POR STOCK
    "============================================================
    out->write(  '--- SORTED TABLE POR STOCK ---' ).

    TYPES tt_medicamentos_stock TYPE SORTED TABLE OF ty_medicamento_datos
                                WITH NON-UNIQUE KEY stock.

    DATA(lt_por_stock) = VALUE tt_medicamentos_stock(
      ( LINES OF lt_medicamentos )
    ).

    out->write( lt_por_stock ).


    "============================================================
    " 37. SORTED TABLE POR LABORATORIO + NOMBRE
    "============================================================
    out->write(  '--- SORTED TABLE POR LABORATORIO + NOMBRE ---' ).


    TYPES tt_medicamentos_laboratorio
      TYPE SORTED TABLE OF ty_medicamento_datos
      WITH NON-UNIQUE KEY laboratorio nombre.

    DATA(lt_por_laboratorio) = VALUE tt_medicamentos_laboratorio(
      ( LINES OF lt_medicamentos )
    ).

    out->write( lt_por_laboratorio ).


    "============================================================
    " 38. CLAVE SECUNDARIA
    "============================================================
    out->write(  '--- CLAVE SECUNDARIA ---' ).

    TYPES tt_con_clave_nombre
      TYPE STANDARD TABLE OF ty_medicamento_datos
      WITH EMPTY KEY
      WITH NON-UNIQUE SORTED KEY por_nombre
      COMPONENTS nombre.


    DATA(lt_clave_nombre) =
      VALUE tt_con_clave_nombre(
        ( LINES OF lt_medicamentos )
      ).

    DATA(ls_omeprazol) =
      lt_clave_nombre[
        KEY por_nombre
        nombre = 'Omeprazol'
      ].

    out->write(
      |Omeprazol ID: { ls_omeprazol-id }|
    ).


    "============================================================
    " 39. FILTER STOCK <= 10
    "============================================================
    out->write(  '--- FILTER STOCK <= 10 ---' ).

    DATA(lt_stock_bajo) =
      FILTER #(
        lt_por_stock
        WHERE stock <= 10
      ).

    out->write( lt_stock_bajo ).


    "============================================================
    " 40. FILTER STOCK > 10
    "============================================================
    out->write(  '--- FILTER STOCK > 10 ---' ).

    DATA(lt_stock_alto) =
      FILTER #(
        lt_por_stock
        WHERE stock > 10
      ).

    out->write( lt_stock_alto ).


    "============================================================
    " 41. REDUCE - TOTAL STOCK
    "============================================================
    out->write(  '--- REDUCE - TOTAL STOCK ---' ).

    DATA(lv_total_stock) =
      REDUCE i(
        INIT suma = 0

        FOR medicamento IN lt_medicamentos

        NEXT suma =
          suma + medicamento-stock
      ).

    out->write(
      |TOTAL STOCK: { lv_total_stock }|
    ).


    "============================================================
    " 42. REDUCE - VALOR INVENTARIO
    "============================================================
    out->write(  '--- REDUCE - VALOR INVENTARIO ---' ).

    DATA(lv_valor_inventario) =
      REDUCE decfloat34(
        INIT suma2 = CONV decfloat34( 0 )

        FOR medicamento IN lt_medicamentos

        NEXT suma2 = suma2 + CONV decfloat34( medicamento-precio * medicamento-stock )
      ).

    out->write(
      |VALOR INVENTARIO: { lv_valor_inventario }|
    ).


    "============================================================
    " 43. REDUCE + WHERE + FINAL
    "============================================================
    out->write(  '--- REDUCE + WHERE + FINAL ---' ).

    FINAL(lv_valor_stock_alto) =
      REDUCE decfloat34(
        INIT suma3 = CONV decfloat34( 0 )

        FOR medicamento IN lt_medicamentos

        WHERE ( stock > 10 )

        NEXT suma3 = suma3 + CONV decfloat34( medicamento-precio * medicamento-stock )
      ).

    out->write(
      |VALOR STOCK > 10: { lv_valor_stock_alto }|
    ).


    "============================================================
    " 44-50. NEW + HERENCIA + POLIMORFISMO
    "============================================================
    out->write(  '--- NEW + HERENCIA + POLIMORFISMO ---' ).

    DATA lo_medicamento TYPE REF TO zcl_medicamento_02.

    DATA lo_generico TYPE REF TO zcl_med_generico_02.

    DATA lo_marca TYPE REF TO zcl_med_marca_02.


    "------------------------------------------------------------
    " Crear medicamento genérico
    "------------------------------------------------------------

    lo_generico = NEW zcl_med_generico_02(
      lv_nombre           = 'Paracetamol'
      lv_precio           = '2.50'
      lv_stock            = 40
      lv_principio_activo = 'Paracetamol'
      lv_descuento        = 10
    ).


    "------------------------------------------------------------
    " Crear medicamento de marca
    "------------------------------------------------------------

    lo_marca = NEW zcl_med_marca_02(
      lv_nombre           = 'Amoxicilina'
      lv_precio           = '6.20'
      lv_stock            = 8
      lv_nombre_comercial = 'Augmentine'
      lv_recargo          = 10
    ).


    "------------------------------------------------------------
    " 50. POLIMORFISMO
    "------------------------------------------------------------

    lo_medicamento = lo_generico.

    DATA lv_precio_final TYPE zdecimals2.

    lv_precio_final =
      lo_medicamento->obtener_precio_final( ).

    out->write(
      |Paracetamol precio final: { lv_precio_final }|
    ).


    lo_medicamento = lo_marca.

    lv_precio_final =
      lo_medicamento->obtener_precio_final( ).

    out->write(
      |Amoxicilina precio final: { lv_precio_final }|
    ).


    "============================================================
    " 51. REF
    "============================================================
    out->write(  '--- REF ---' ).

    "Hacemos una copia para demostrar que REF modifica
    "el dato al que apunta la referencia.

    DATA(lt_medicamentos_ref) =
      lt_medicamentos.

    DATA lr_medicamento
      TYPE REF TO ty_medicamento_datos.


    "Obtener referencia al ID 2

    lr_medicamento =
      REF #( lt_medicamentos_ref[ id = 2 ] ).


    "Modificar mediante REF

    lr_medicamento->stock = 99.


    "Mostrar tabla modificada

    out->write( '========================================' ).

    out->write( 'REF - ID 2 MODIFICADO' ).

    out->write( '========================================' ).

    out->write( lt_medicamentos_ref ).


    "La tabla original NO cambia porque trabajamos
    "con una copia antes de obtener la referencia.

    out->write(
      'TABLA ORIGINAL'
    ).

    out->write(
      lt_medicamentos
    ).


    "============================================================
    " FIN
    "============================================================

    out->write( '========================================' ).

    out->write( 'FIN DE LA PRACTICA' ).

    out->write( '========================================' ).

  ENDMETHOD.

ENDCLASS.


**********************************************************************
**                  ENUNCIADO
**********************************************************************

**
**
**
**# PRÁCTICA FINAL DE ABAP MODERNO
**
**# Sistema de gestión de una farmacia
**
**## 1. Objetivo de la práctica
**
**Desarrollar en Eclipse/ADT una pequeña aplicación de gestión de una farmacia
**utilizando las principales construcciones de ABAP moderno vistas en clase.
**
**La práctica se realizará mediante clases.
**
**La clase ejecutable utilizará:
**
**`IF_OO_ADT_CLASSRUN`
**
**Todos los resultados se mostrarán mediante:
**
**`out->write( )`
**
**No se utilizará SAP GUI.
**
**---
**
**# 2. Elementos que vamos a crear
**
**Crear exactamente las siguientes clases:
**
**### Clase padre
**
**`ZCL_MEDICAMENTO_00`
**
**Representará cualquier medicamento de la farmacia.
**
**### Primera clase hija
**
**`ZCL_MED_GENERICO_00`
**
**Hereda de `ZCL_MEDICAMENTO_00`.
**
**Representará medicamentos genéricos.
**
**### Segunda clase hija
**
**`ZCL_MED_MARCA_00`
**
**Hereda de `ZCL_MEDICAMENTO_00`.
**
**Representará medicamentos de marca.
**
**### Clase ejecutable
**
**`ZCL_TEST_FARMACIA_00`
**
**Será la clase desde la que realizaremos todas las pruebas.
**
**---
**
**# 3. Tipo utilizado para importes
**
**Para todos los precios e importes utilizaremos:
**
**`ZDECIMALS2`
**
**Se asumirá que permite almacenar valores decimales con dos posiciones.
**
**---
**
**# 4. Clase padre ZCL_MEDICAMENTO_00
**
**Debe contener los siguientes atributos públicos:
**
*** `id` → entero
*** `nombre` → string
*** `laboratorio` → string
*** `precio` → ZDECIMALS2
*** `stock` → entero
*** `requiere_receta` → ABAP_BOOL
*** `principio_activo` → string
**
**Debe tener un constructor que permita informar todos esos datos.
**
**Debe tener además un método:
**
**`CALCULAR_PRECIO_FINAL`
**
**que devuelva un `ZDECIMALS2`.
**
**En la clase padre, el método devolverá simplemente el precio original.
**
**---
**
**# 5. Clase hija ZCL_MED_GENERICO_00
**
**Debe heredar de:
**
**`ZCL_MEDICAMENTO_00`
**
**Añadirá el atributo:
**
*** `porcentaje_descuento` → entero
**
**Debe redefinir:
**
**`CALCULAR_PRECIO_FINAL`
**
**El precio final de un medicamento genérico será:
**
**Precio original menos el porcentaje de descuento.
**
**---
**
**# 6. Clase hija ZCL_MED_MARCA_00
**
**Debe heredar de:
**
**`ZCL_MEDICAMENTO_00`
**
**Añadirá:
**
*** `nombre_comercial` → string
*** `recargo_marca` → entero
**
**Debe redefinir:
**
**`CALCULAR_PRECIO_FINAL`
**
**El precio final será:
**
**Precio original más el porcentaje indicado en `recargo_marca`.
**
**---
**
**# 7. Datos oficiales de la práctica
**
**Todos los alumnos utilizarán exactamente estos seis medicamentos.
**
**| ID | Nombre       | Laboratorio | Precio | Stock | Tipo | Receta | Principio activo          | Coste interno |
**| -: | ------------ | ----------- | -----: | ----: | ---- | ------ | ------------------------- | ------------: |
**|  1 | Paracetamol  | Cinfa       |   2,50 |    40 | G    | No     | Paracetamol               |          1,20 |
**|  2 | Ibuprofeno   | Kern Pharma |   3,80 |    15 | G    | No     | Ibuprofeno                |          1,80 |
**|  3 | Omeprazol    | Cinfa       |   5,10 |    25 | G    | No     | Omeprazol                 |          2,50 |
**|  4 | Amoxicilina  | GSK         |   6,20 |     8 | M    | Sí     | Amoxicilina + clavulánico |          3,10 |
**|  5 | Acenocumarol | Viatris     |   4,90 |     3 | M    | Sí     | Acenocumarol              |          2,20 |
**|  6 | Salbutamol   | GSK         |   6,00 |     0 | M    | Sí     | Salbutamol                |          3,50 |
**
**Datos específicos de los genéricos:
**
**| ID | Descuento |
**| -: | --------: |
**|  1 |      10 % |
**|  2 |       5 % |
**|  3 |      20 % |
**
**Datos específicos de los medicamentos de marca:
**
**| ID | Nombre comercial | Recargo |
**| -: | ---------------- | ------: |
**|  4 | Augmentine       |    10 % |
**|  5 | Sintrom          |    20 % |
**|  6 | Ventolin         |    15 % |
**
**---
**
**# FASE 1 — DATA, FINAL, VALUE y
**
**## 8. Crear los tipos de datos
**
**Dentro de `ZCL_TEST_FARMACIA_00` crear un tipo estructura:
**
**`TY_MEDICAMENTO_DATOS`
**
**Debe contener:
**
*** id
*** nombre
*** laboratorio
*** precio
*** stock
*** tipo
*** requiere_receta
*** principio_activo
*** coste_interno
*** porcentaje_descuento
*** nombre_comercial
*** recargo_marca
**
**Crear también:
**
**`TT_MEDICAMENTOS`
**
**como una `STANDARD TABLE` de `TY_MEDICAMENTO_DATOS`.
**
**---
**
**# 9. Crear la tabla inicial con VALUE
**
**Crear:
**
**`LT_MEDICAMENTOS`
**
**con los seis medicamentos oficiales.
**
**Es obligatorio utilizar:
**
*** `DATA(...)`
*** `VALUE`
**
**No se permite utilizar:
**
*** APPEND
*** INSERT
**
**para cargar los seis datos iniciales.
**
**Utilizar `#` siempre que ABAP pueda deducir claramente el tipo.
**
**## Comprobación
**
**La tabla debe contener exactamente:
**
**`6 filas`
**
**Y deben aparecer en este orden:
**
**1. Paracetamol
**2. Ibuprofeno
**3. Omeprazol
**4. Amoxicilina
**5. Acenocumarol
**6. Salbutamol
**
**---
**
**# FASE 2 — COND, SWITCH y XSDBOOL
**
**## 10. Categoría de stock con COND
**
**Para cada medicamento obtener una categoría:
**
*** Stock >= 30 → `STOCK ALTO`
*** Stock entre 10 y 29 → `STOCK MEDIO`
*** Stock entre 1 y 9 → `STOCK BAJO`
*** Stock = 0 → `SIN STOCK`
**
**Debe utilizarse obligatoriamente:
**
**`COND`
**
**No utilizar IF para calcular este texto.
**
**## Resultado esperado
**
**| ID | Resultado   |
**| -: | ----------- |
**|  1 | STOCK ALTO  |
**|  2 | STOCK MEDIO |
**|  3 | STOCK MEDIO |
**|  4 | STOCK BAJO  |
**|  5 | STOCK BAJO  |
**|  6 | SIN STOCK   |
**
**---
**
**# 11. Descripción del tipo con SWITCH
**
**Convertir el código:
**
*** G → `GENÉRICO`
*** M → `MARCA`
*** H → `HOSPITALARIO`
**
**Cualquier otro valor:
**
**`DESCONOCIDO`
**
**Debe utilizarse:
**
**`SWITCH`
**
**No utilizar:
**
*** CASE
*** COND
**
**## Resultado esperado
**
**IDs 1, 2 y 3:
**
**`GENÉRICO`
**
**IDs 4, 5 y 6:
**
**`MARCA`
**
**---
**
**# 12. Disponible con XSDBOOL
**
**Crear un valor booleano que indique si el medicamento está disponible.
**
**Un medicamento está disponible cuando:
**
*** stock > 0
*** Y precio > 0
**
**Debe utilizarse:
**
**`XSDBOOL`
**
**No utilizar IF para asignar el booleano.
**
**## Resultado esperado
**
**| ID | Disponible |
**| -: | ---------- |
**|  1 | TRUE       |
**|  2 | TRUE       |
**|  3 | TRUE       |
**|  4 | TRUE       |
**|  5 | TRUE       |
**|  6 | FALSE      |
**
**---
**
**# FASE 3 — CONV Y FUNCIONES NUMÉRICAS
**
**## 13. Conversión con CONV
**
**Simular una venta recibida desde un sistema externo.
**
**Los datos recibidos son textos:
**
*** Cantidad: `"12"`
*** Precio: `"3.50"`
**
**Convertir ambos datos a valores numéricos mediante:
**
**`CONV`
**
**Calcular:
**
**Cantidad × Precio
**
**## Resultado esperado
**
**`42,00`
**
**---
**
**## 14. Entero a decimal
**
**Convertir el entero:
**
**`25`
**
**a un tipo decimal.
**
**## Resultado esperado
**
**`25,00`
**
**---
**
**## 15. Decimal a entero
**
**Convertir:
**
**`25,80`
**
**a entero mediante `CONV`.
**
**## Resultado esperado
**
**`26`
**
**Recordar que `CONV` redondea al convertir a entero.
**
**---
**
**# 16. ROUND, TRUNC, CEIL y FLOOR
**
**Utilizar primero:
**
**`25,80`
**
**## Resultado esperado
**
**| Operación | Resultado |
**| --------- | --------: |
**| ROUND     |        26 |
**| TRUNC     |        25 |
**| CEIL      |        26 |
**| FLOOR     |        25 |
**
**Repetir después con:
**
**`-25,80`
**
**## Resultado esperado
**
**| Operación | Resultado |
**| --------- | --------: |
**| ROUND     |       -26 |
**| TRUNC     |       -25 |
**| CEIL      |       -25 |
**| FLOOR     |       -26 |
**
**---
**
**# FASE 4 — EXACT Y EXCEPCIONES
**
**## 17. EXACT correcto
**
**Intentar convertir:
**
**`25,00`
**
**a entero mediante:
**
**`EXACT`
**
**## Resultado esperado
**
**`25`
**
**No debe producirse ninguna excepción.
**
**---
**
**# 18. EXACT incorrecto
**
**Intentar convertir:
**
**`25,75`
**
**a entero mediante:
**
**`EXACT`
**
**Debe utilizarse:
**
**`TRY / CATCH`
**
**La conversión debe provocar una excepción por pérdida de información.
**
**## Resultado esperado
**
**Mostrar:
**
**`NO SE PUEDE CONVERTIR 25,75 SIN PERDER INFORMACIÓN`
**
**---
**
**# FASE 5 — EXPRESIONES DE TABLA
**
**Trabajar siempre sobre `LT_MEDICAMENTOS` manteniendo el orden inicial.
**
**---
**
**# 19. Buscar una fila
**
**Obtener mediante expresión de tabla:
**
**Medicamento con ID 3.
**
**## Resultado esperado
**
**`Omeprazol`
**
**---
**
**# 20. Acceder directamente a un campo
**
**Obtener directamente el nombre del medicamento con ID 4.
**
**## Resultado esperado
**
**`Amoxicilina`
**
**---
**
**# 21. Obtener directamente un precio
**
**Obtener directamente el precio del medicamento con ID 2.
**
**## Resultado esperado
**
**`3,80`
**
**---
**
**# 22. Acceso mediante índice
**
**Obtener la primera fila.
**
**## Resultado esperado
**
**`Paracetamol`
**
**---
**
**# 23. TRY / CATCH con una expresión de tabla
**
**Intentar obtener:
**
**ID = 99
**
**Debe capturarse:
**
**`CX_SY_ITAB_LINE_NOT_FOUND`
**
**## Resultado esperado
**
**`MEDICAMENTO NO ENCONTRADO`
**
**---
**
**# FASE 6 — line_exists, OPTIONAL, DEFAULT y line_index
**
**## 24. line_exists
**
**Comprobar:
**
**ID 5
**
**## Resultado
**
**Existe.
**
**Comprobar:
**
**ID 99
**
**## Resultado
**
**No existe.
**
**No utilizar:
**
*** READ TABLE
*** SY-SUBRC
**
**---
**
**# 25. OPTIONAL
**
**Intentar obtener:
**
**ID = 99
**
**utilizando `OPTIONAL`.
**
**## Resultado esperado
**
**Debe obtenerse una estructura inicial.
**
**Por tanto:
**
*** ID = 0
*** Nombre vacío
*** Precio = 0
*** Stock = 0
**
**No debe producirse excepción.
**
**---
**
**# 26. DEFAULT
**
**Volver a buscar:
**
**ID = 99
**
**Pero esta vez utilizar `DEFAULT`.
**
**Si no existe devolver:
**
*** ID = 0
*** Nombre = `MEDICAMENTO NO ENCONTRADO`
*** Precio = 0
*** Stock = 0
**
**## Resultado esperado
**
**El nombre debe ser:
**
**`MEDICAMENTO NO ENCONTRADO`
**
**---
**
**# 27. line_index
**
**Buscar la posición del medicamento:
**
**ID = 3
**
**## Resultado esperado
**
**`3`
**
**Buscar:
**
**ID = 99
**
**## Resultado esperado
**
**`0`
**
**No utilizar `SY-TABIX`.
**
**---
**
**# FASE 7 — CORRESPONDING, MAPPING Y EXCEPT
**
**## 28. Tipo TY_MEDICAMENTO_PUBLICO
**
**Crear una estructura con:
**
*** id
*** nombre
*** laboratorio
*** precio
*** stock
**
**Crear su correspondiente tipo tabla:
**
**`TT_MEDICAMENTOS_PUBLICOS`
**
**---
**
**# 29. CORRESPONDING entre tablas
**
**Convertir `LT_MEDICAMENTOS` en una tabla:
**
**`LT_MEDICAMENTOS_PUBLICOS`
**
**utilizando directamente `CORRESPONDING`.
**
**No copiar los campos manualmente.
**
**## Comprobación
**
**Debe haber:
**
**`6 filas`
**
**El primer registro debe contener:
**
*** ID = 1
*** Nombre = Paracetamol
*** Laboratorio = Cinfa
*** Precio = 2,50
*** Stock = 40
**
**---
**
**# 30. MAPPING
**
**Crear:
**
**`TY_MEDICAMENTO_EXTERNO`
**
**con:
**
*** codigo
*** descripcion
*** fabricante
*** precio
*** unidades
**
**Crear también:
**
**`TT_MEDICAMENTOS_EXTERNOS`
**
**Convertir los datos utilizando:
**
**`CORRESPONDING + MAPPING`
**
**Relaciones obligatorias:
**
*** codigo ← id
*** descripcion ← nombre
*** fabricante ← laboratorio
*** precio ← precio
*** unidades ← stock
**
**## Resultado esperado para la primera fila
**
*** Código = 1
*** Descripción = Paracetamol
*** Fabricante = Cinfa
*** Precio = 2,50
*** Unidades = 40
**
**---
**
**# 31. EXCEPT
**
**Crear:
**
**`TY_MEDICAMENTO_AUDITORIA`
**
**con:
**
*** id
*** nombre
*** precio
*** coste_interno
**
**Convertir desde `TY_MEDICAMENTO_DATOS` mediante `CORRESPONDING`.
**
**Pero utilizar:
**
**`EXCEPT`
**
**para impedir que `coste_interno` sea copiado.
**
**## Resultado esperado para Paracetamol
**
*** ID = 1
*** Nombre = Paracetamol
*** Precio = 2,50
*** Coste interno = 0,00
**
**Aunque el origen tenía:
**
**`1,20`
**
**---
**
**# FASE 8 — BASE
**
**## 32. Actualizar un medicamento sin modificar el original
**
**Tomar el medicamento:
**
**ID = 2, Ibuprofeno.
**
**Tiene inicialmente:
**
**`Stock = 15`
**
**Crear una segunda estructura mediante:
**
**`VALUE + BASE`
**
**Mantener todos sus datos excepto el stock.
**
**Nuevo stock:
**
**`35`
**
**## Comprobación
**
**Estructura original:
**
**`Stock = 15`
**
**Estructura nueva:
**
**`Stock = 35`
**
**No volver a escribir manualmente:
**
*** nombre
*** laboratorio
*** precio
*** tipo
*** principio activo
**
**---
**
**# FASE 9 — FOR
**
**## 33. Crear una tabla resumen
**
**Crear:
**
**`TY_RESUMEN_MEDICAMENTO`
**
**con:
**
*** id
*** nombre
*** precio
*** stock
**
**Crear:
**
**`TT_RESUMEN_MEDICAMENTOS`
**
**Construir la tabla utilizando:
**
*** VALUE
*** FOR ... IN
**
**No utilizar:
**
*** LOOP
*** APPEND
**
**## Resultado esperado
**
**Debe contener las 6 filas.
**
**La primera:
**
**`1 - Paracetamol - 2,50 - 40`
**
**La última:
**
**`6 - Salbutamol - 6,00 - 0`
**
**---
**
**# 34. FOR + CORRESPONDING
**
**Volver a construir una tabla equivalente a `TT_MEDICAMENTOS_PUBLICOS`.
**
**Esta vez es obligatorio utilizar conjuntamente:
**
*** VALUE
*** FOR
*** CORRESPONDING
**
**No realizar asignaciones campo a campo.
**
**## Comprobación
**
**El resultado debe ser idéntico al obtenido en el apartado 29.
**
**---
**
**# FASE 10 — LET ... IN
**
**## 35. Valor económico del stock por medicamento
**
**Crear:
**
**`TY_VALOR_STOCK`
**
**con:
**
*** id
*** nombre
*** subtotal
*** iva
*** total_con_iva
**
**Utilizar:
**
*** VALUE
*** FOR
*** LET ... IN
**
**El IVA utilizado en esta práctica será:
**
**`4 %`
**
**Dentro de `LET` calcular:
**
**Subtotal:
**
**`precio × stock`
**
**IVA:
**
**`subtotal × 4 %`
**
**Total:
**
**`subtotal + IVA`
**
**No declarar las variables auxiliares fuera de la expresión.
**
**## Resultados esperados
**
**| ID | Subtotal | IVA aprox. |  Total |
**| -: | -------: | ---------: | -----: |
**|  1 |   100,00 |       4,00 | 104,00 |
**|  2 |    57,00 |       2,28 |  59,28 |
**|  3 |   127,50 |       5,10 | 132,60 |
**|  4 |    49,60 |       1,98 |  51,58 |
**|  5 |    14,70 |       0,59 |  15,29 |
**|  6 |     0,00 |       0,00 |   0,00 |
**
**---
**
**# FASE 11 — SORTED TABLE Y CLAVES
**
**## 36. Tabla ordenada por stock
**
**Crear:
**
**`TT_MEDICAMENTOS_POR_STOCK`
**
**como una:
**
**`SORTED TABLE`
**
**Clave:
**
**`stock`
**
**Debe ser:
**
**`NON-UNIQUE`
**
**porque varios medicamentos podrían tener el mismo stock.
**
**## Orden esperado
**
**Los IDs deben aparecer:
**
**`6, 5, 4, 2, 3, 1`
**
**porque sus stocks son:
**
**`0, 3, 8, 15, 25, 40`
**
**---
**
**# 37. Clave compuesta
**
**Crear una tabla `SORTED TABLE` cuya clave sea:
**
**1. laboratorio
**2. nombre
**
**## Orden esperado
**
**Debe quedar conceptualmente:
**
**1. Cinfa - Omeprazol
**2. Cinfa - Paracetamol
**3. GSK - Amoxicilina
**4. GSK - Salbutamol
**5. Kern Pharma - Ibuprofeno
**6. Viatris - Acenocumarol
**
**---
**
**# 38. Clave secundaria
**
**Añadir una clave secundaria ordenada denominada:
**
**`POR_NOMBRE`
**
**basada en:
**
**`nombre`
**
**Utilizar explícitamente esta clave para buscar:
**
**`Omeprazol`
**
**## Resultado esperado
**
**ID:
**
**`3`
**
**---
**
**# FASE 12 — FILTER
**
**## 39. Medicamentos con stock bajo
**
**Utilizar la tabla ordenada por stock.
**
**Mediante `FILTER`, obtener los medicamentos con stock:
**
**`<= 10`
**
**## Resultado esperado
**
**Deben aparecer:
**
*** Salbutamol → 0
*** Acenocumarol → 3
*** Amoxicilina → 8
**
**Total:
**
**`3 medicamentos`
**
**---
**
**# 40. Medicamentos con stock superior a 10
**
**Crear otro filtro para:
**
**`stock > 10`
**
**## Resultado esperado
**
*** Ibuprofeno → 15
*** Omeprazol → 25
*** Paracetamol → 40
**
**Total:
**
**`3 medicamentos`
**
**---
**
**# FASE 13 — REDUCE
**
**## 41. Total de unidades almacenadas
**
**Utilizar exclusivamente:
**
**`REDUCE`
**
**No utilizar LOOP.
**
**Sumar todos los stocks.
**
**## Cálculo esperado
**
**40 + 15 + 25 + 8 + 3 + 0
**
**## Resultado
**
**`91 unidades`
**
**---
**
**# 42. Valor total del inventario
**
**Calcular:
**
**Precio × Stock
**
**para todos los medicamentos.
**
**Utilizar exclusivamente:
**
**`REDUCE`
**
**## Resultado esperado
**
**`348,80 €`
**
**---
**
**# 43. Valor de inventario con stock superior a 10
**
**Solo contar:
**
*** Paracetamol
*** Ibuprofeno
*** Omeprazol
**
**## Cálculo
**
**100,00 + 57,00 + 127,50
**
**## Resultado esperado
**
**`284,50 €`
**
**Guardar este resultado en una variable declarada mediante:
**
**`FINAL(...)`
**
**---
**
**# FASE 14 — NEW Y POLIMORFISMO
**
**## 44. Crear los seis objetos
**
**Crear mediante `NEW`:
**
**### Genéricos
**
**ID 1 → Paracetamol
**
**ID 2 → Ibuprofeno
**
**ID 3 → Omeprazol
**
**### Marca
**
**ID 4 → Amoxicilina / Augmentine
**
**ID 5 → Acenocumarol / Sintrom
**
**ID 6 → Salbutamol / Ventolin
**
**No utilizar:
**
**`CREATE OBJECT`
**
**---
**
**# 45. Tabla de referencias
**
**Crear:
**
**`TT_OBJ_MEDICAMENTOS`
**
**como una tabla de:
**
**`REF TO ZCL_MEDICAMENTO_00`
**
**Guardar dentro los seis objetos.
**
**Aunque unos sean genéricos y otros sean de marca, todos deben viajar mediante
**referencias a la clase padre.
**
**---
**
**# 46. Comprobar el UPCAST
**
**Al guardar un objeto `ZCL_MED_GENERICO_00` en una referencia:
**
**`REF TO ZCL_MEDICAMENTO_00`
**
**el upcast debe realizarse sin `CAST`.
**
**Comprobar que desde la referencia padre se pueden leer:
**
*** nombre
*** precio
**
**Pero NO directamente:
**
*** porcentaje_descuento
**
**---
**
**# FASE 15 — CAST
**
**## 47. Detectar un genérico
**
**Tomar el objeto ID 1.
**
**La referencia debe estar tipada como:
**
**`REF TO ZCL_MEDICAMENTO_00`
**
**Comprobar mediante:
**
**`IS INSTANCE OF`
**
**si realmente es:
**
**`ZCL_MED_GENERICO_00`
**
**Si lo es, hacer `CAST`.
**
**## Resultado esperado
**
**Después del CAST debe poder leerse:
**
**`porcentaje_descuento = 10`
**
**---
**
**# 48. Detectar un medicamento de marca
**
**Tomar ID 5.
**
**Comprobar su tipo real.
**
**Realizar CAST a:
**
**`ZCL_MED_MARCA_00`
**
**## Resultado esperado
**
**Debe poder accederse a:
**
**`nombre_comercial = Sintrom`
**
**y:
**
**`recargo_marca = 20`
**
**---
**
**# 49. CAST incorrecto entre clases hermanas
**
**Tomar el medicamento ID 1.
**
**El objeto real es:
**
**`ZCL_MED_GENERICO_00`
**
**Hacer primero upcast hacia:
**
**`ZCL_MEDICAMENTO_00`
**
**Después intentar hacer CAST hacia:
**
**`ZCL_MED_MARCA_00`
**
**Debe utilizarse:
**
**`TRY / CATCH`
**
**Capturar:
**
**`CX_SY_MOVE_CAST_ERROR`
**
**## Resultado esperado
**
**`NO SE PUEDE CONVERTIR UN GENÉRICO EN UN MEDICAMENTO DE MARCA`
**
**---
**
**# FASE 16 — POLIMORFISMO
**
**## 50. CALCULAR_PRECIO_FINAL
**
**Recorrer la tabla de referencias a `ZCL_MEDICAMENTO_00`.
**
**Llamar directamente:
**
**`CALCULAR_PRECIO_FINAL`
**
**No utilizar CAST.
**
**Debe ejecutarse automáticamente la redefinición correspondiente.
**
**## Resultados esperados
**
**### Paracetamol
**
**2,50 con 10 % de descuento:
**
**`2,25`
**
**### Ibuprofeno
**
**3,80 con 5 % de descuento:
**
**`3,61`
**
**### Omeprazol
**
**5,10 con 20 % de descuento:
**
**`4,08`
**
**### Amoxicilina
**
**6,20 con 10 % de recargo:
**
**`6,82`
**
**### Acenocumarol
**
**4,90 con 20 % de recargo:
**
**`5,88`
**
**### Salbutamol
**
**6,00 con 15 % de recargo:
**
**`6,90`
**
**El objetivo es demostrar que:
**
**`Polimorfismo ≠ CAST`
**
**No debemos realizar CAST cuando simplemente queremos ejecutar un método redefinido.
**
**---
**
**# FASE 17 — REF
**
**## 51. Referencia a una fila
**
**Para no alterar los resultados anteriores, crear primero una copia de la
**tabla inicial destinada exclusivamente a esta prueba.
**
**Sobre esa copia, obtener mediante:
**
**`REF`
**
**una referencia a la fila:
**
**ID = 2
**
**Stock inicial:
**
**`15`
**
**Modificar el stock mediante la referencia a:
**
**`99`
**
**## Resultado esperado
**
**Al volver a mostrar la tabla:
**
**Ibuprofeno debe tener:
**
**`Stock = 99`
**
**No se ha creado una copia del medicamento.
**
**Se ha modificado la fila original mediante una referencia.
**
**---
**
**# FASE 18 — COMPROBACIÓN FINAL
**
**Al terminar la práctica, el alumno deberá haber utilizado al menos una vez:
**
*** DATA(...)
*** FINAL(...)
*** VALUE
*** #
*** COND
*** SWITCH
*** XSDBOOL
*** CONV
*** ROUND
*** TRUNC
*** CEIL
*** FLOOR
*** EXACT
*** TRY / CATCH
*** expresiones `itab[...]`
*** line_exists
*** OPTIONAL
*** DEFAULT
*** line_index
*** CORRESPONDING
*** MAPPING
*** EXCEPT
*** BASE
*** FOR ... IN
*** FOR + CORRESPONDING
*** LET ... IN
*** SORTED TABLE
*** clave compuesta
*** clave secundaria
*** FILTER
*** REDUCE
*** NEW
*** REF
*** IS INSTANCE OF
*** CAST
*** polimorfismo
**
**---
**
**# Restricciones generales
**
**Durante la práctica:
**
*** No utilizar `CREATE OBJECT`; utilizar `NEW`.
*** No utilizar `READ TABLE` en los apartados de expresiones modernas.
*** No utilizar `SY-SUBRC` para `line_exists`.
*** No utilizar `SY-TABIX` para `line_index`.
*** No utilizar `LOOP + APPEND` cuando el apartado exija `FOR`.
*** No utilizar `IF` cuando el apartado exija `COND`.
*** No utilizar `CASE` cuando el apartado exija `SWITCH`.
*** No copiar manualmente los campos cuando el apartado exija `CORRESPONDING`.
*** No utilizar conversiones implícitas cuando el apartado exija `CONV`.
*** No utilizar `CAST` para sustituir al polimorfismo.
**
**---
**
**# Regla para saber si la práctica va correctamente
**
**Los datos iniciales NO deben modificarse durante los ejercicios, excepto cuando el
**apartado lo indique expresamente.
**
**Cuando una prueba pueda alterar los datos originales, como el ejercicio de `REF`,
**debe realizarse sobre una copia independiente.
**
**De esta forma, todos los resultados indicados en este enunciado serán reproducibles
**y todos los alumnos podrán comparar sus resultados con los mismos valores.
**

