CLASS zcl_gestion_pedidos_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .

    " 1. Definición de la estructura jerárquica de tipos
    TYPES: BEGIN OF ty_posicion,
             producto        TYPE string,
             cantidad        TYPE i,
             precio_unitario TYPE p LENGTH 8 DECIMALS 2,
           END OF ty_posicion.

    TYPES tt_posiciones TYPE STANDARD TABLE OF ty_posicion WITH DEFAULT KEY.

    TYPES: BEGIN OF ty_pedido,
             id_pedido  TYPE i,
             cliente    TYPE string,
             ciudad     TYPE string,
             urgente    TYPE abap_bool,
             posiciones TYPE tt_posiciones, " Tabla anidada
           END OF ty_pedido.

    TYPES tt_pedidos TYPE STANDARD TABLE OF ty_pedido WITH DEFAULT KEY.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_gestion_pedidos_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    "tablas nu
    DATA(lt_pedidos) = VALUE tt_pedidos(
        ( id_pedido = 1001 cliente = 'Empresa Norte' ciudad = 'Sevilla' urgente = abap_true
          posiciones = VALUE #( ( producto = 'Portátil' cantidad = 2  precio_unitario = '850.00' )
                                ( producto = 'Ratón'    cantidad = 5  precio_unitario = '25.00' )
                                ( producto = 'Monitor'  cantidad = 2  precio_unitario = '220.00' ) ) )

        ( id_pedido = 1002 cliente = 'Tecnología Sur' ciudad = 'Cádiz' urgente = abap_false
          posiciones = VALUE #( ( producto = 'Teclado'  cantidad = 10 precio_unitario = '45.00' )
                                ( producto = 'Webcam'   cantidad = 4  precio_unitario = '75.00' ) ) )

        ( id_pedido = 1003 cliente = 'Formación Digital' ciudad = 'Huelva' urgente = abap_true
          posiciones = VALUE #( ( producto = 'Tablet'     cantidad = 6  precio_unitario = '320.00' )
                                ( producto = 'Auriculares' cantidad = 8  precio_unitario = '60.00' )
                                ( producto = 'Adaptador USB-C' cantidad = 15 precio_unitario = '20.00' ) ) )
    ).

    "tabla jerárquica completa
    out->write( '--- TABLA DE PEDIDOS COMPLETA ---' ).
    out->write( lt_pedidos ).

    " Reto Adicional: Construir una única estructura estructurada
    DATA(ls_pedido_prueba) = VALUE ty_pedido(
        id_pedido = 2000
        cliente   = 'Cliente Prueba'
        ciudad    = 'Sevilla'
        urgente   = abap_false
        posiciones = VALUE #( ( producto = 'Componente A' cantidad = 1 precio_unitario = '10.50' )
                              ( producto = 'Componente B' cantidad = 3 precio_unitario = '50.00' ) )
    ).


    out->write( '--- RETO: ESTRUCTURA DE PRUEBA SUELTA ---' ).
    out->write( ls_pedido_prueba ).

  ENDMETHOD.
ENDCLASS.


