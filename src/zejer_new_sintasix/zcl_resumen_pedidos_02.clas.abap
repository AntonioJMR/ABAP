CLASS zcl_resumen_pedidos_02 DEFINITION


  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

ENDCLASS.


CLASS zcl_resumen_pedidos_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.


    " Tipo
    TYPES: BEGIN OF ty_producto,
             nombre   TYPE string,
             precio   TYPE decfloat34,
             cantidad TYPE i,
           END OF ty_producto.


    " Tabla
    TYPES tt_productos TYPE STANDARD TABLE OF ty_producto
                       WITH EMPTY KEY.


    " Crear
    DATA(lt_productos) = VALUE tt_productos(
      ( nombre = 'Monitor'  precio = '250' cantidad = 2 )
      ( nombre = 'Teclado'  precio = '50'  cantidad = 3 )
      ( nombre = 'Ratón'    precio = '25'  cantidad = 4 )
      ( nombre = 'Portátil' precio = '900' cantidad = 2 )
    ).

    "Tipo Destino
    TYPES: BEGIN OF ty_resumen,
             nombre      TYPE string,
             subtotal    TYPE decfloat34,
             descuento   TYPE decfloat34,
             total_final TYPE decfloat34,
           END OF ty_resumen.

    TYPES tt_resumen TYPE STANDARD TABLE OF ty_resumen
                     WITH EMPTY KEY.


    " USO del  VALUE + FOR + LET  (VALUE construye → FOR recorre → LET calcula auxiliares.)
    "------------------------------------------------------------
    DATA(lt_resumen) = VALUE tt_resumen(

      FOR producto IN lt_productos

      LET aux_subtotal  = producto-precio * producto-cantidad
          aux_descuento = aux_subtotal * '0.10'

      IN

      (
        nombre      = producto-nombre
        subtotal    = aux_subtotal
        descuento   = aux_descuento
        total_final = aux_subtotal - aux_descuento
      )

    ).

    out->write( 'RESUMEN DE PEDIDOS' ).
    out->write( lt_resumen ).

  ENDMETHOD.

ENDCLASS.
