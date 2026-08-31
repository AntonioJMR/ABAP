CLASS zcl_ejercicio_busqueda DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
ENDCLASS.

CLASS zcl_ejercicio_busqueda IMPLEMENTATION.
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

    out->write( '=== BUSQUEDAS CON EXPRESIONES DE TABLA ===' ).

    "Obtén la estructura completa del producto con ID 2
    DATA(ls_producto_2) = lt_productos[ id = 2 ].
    out->write( 'Producto con ID 2 completo:' ).
    out->write( ls_producto_2 ).

    "Obtén directamente el nombre del producto con ID 3
    DATA(lv_nombre_3) = lt_productos[ id = 3 ]-nombre.
    out->write( |Nombre del producto con ID 3: { lv_nombre_3 }| ).
    out->write( |Nombre del producto con ID 3 'rapido': { lt_productos[ id = 3 ]-nombre }| ).

    "Obtén directamente el precio del producto con ID 1
    DATA(lv_precio_1) = lt_productos[ id = 1 ]-precio.
    out->write( |Precio del producto con ID 1: { lv_precio_1 }| ).

    "Obtén la cuarta fila utilizando su índice (posición numérica)
    DATA(ls_fila_4) = lt_productos[ 4 ].
    out->write( 'Cuarta fila obtenida por índice:' ).
    out->write( ls_fila_4 ).


    " ====================================================================
    " RETO: ¿QUÉ PASA SI EL REGISTRO NO EXISTE?
    " ====================================================================
    out->write( NEW string( ) ).
    out->write( '=== RETO: BUSCAR REGISTRO INEXISTENTE ===' ).

    " Nota para el profesor: Descomentar la línea de abajo provocará un
    " error en tiempo de ejecución (DUMP de tipo CX_SY_ITAB_LINE_NOT_FOUND).

*     DATA(ls_productoNA) = lt_productos[ id = 99 ].
*     out->write( ls_productoNA ).

*    out->write( 'Si descomentas la linea lt_productos[ id = 99 ], el programa lanzara un DUMP.' ).
*    out->write( 'Para evitarlo en ABAP moderno, se debe usar OPTIONAL o DEFAULT de esta manera:' ).
*
*    " Solución segura en ABAP moderno:
    DATA(ls_seguro) = VALUE #( lt_productos[ id = 99 ] OPTIONAL ).
*    DATA(ls_seguro) = VALUE ty_producto( lt_productos[ id = 99 ] OPTIONAL ). " Alternativa funciona colocando el tipo datos y que no lo deduzca con #
*    DATA(ls_seguro) = lt_productos[ id = 99 ] OPTIONAL. " NO funciona le falta VALUE

    out->write( 'Resultado usando OPTIONAL (devuelve estructura vacia sin romper el programa):' ).
    out->write( ls_seguro ).

  ENDMETHOD.
ENDCLASS.


