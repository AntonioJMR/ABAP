CLASS zcl_ejercicio_busqueda_tryc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
ENDCLASS.

CLASS zcl_ejercicio_busqueda_tryc IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF ty_producto,
             id     TYPE i,
             nombre TYPE string,
             precio TYPE i,
             stock  TYPE i,
           END OF ty_producto,
           tt_productos TYPE STANDARD TABLE OF ty_producto WITH EMPTY KEY.


    DATA(lt_productos) = VALUE tt_productos(
      ( id = 1 nombre = 'Monitor' precio = 250 stock = 10 )
      ( id = 2 nombre = 'Teclado' precio = 50  stock = 20 )
      ( id = 3 nombre = 'Ratón'   precio = 25  stock = 30 )
      ( id = 4 nombre = 'Webcam'  precio = 80  stock = 15 )
    ).

    " ====================================================================
    "                   ERROR DE BÚSQUEDA - TRY-CATCH
    " ====================================================================

    out->write( '----- ERROR DE BÚSQUEDA - TRY-CATCH ----- ' ).

    TRY.
        " ERROR registro no existe
        DATA(ls_productoNA) = lt_productos[ id = 99 ].
        out->write( ls_productoNA ).

      CATCH cx_sy_itab_line_not_found INTO DATA(lx_error).
        " No hace DUMP Captura del error
        out->write( '¡Error capturado con éxito!' ).
        out->write( |Mensaje: { lx_error->get_text( ) }| ).
    ENDTRY.

  ENDMETHOD.
ENDCLASS.


