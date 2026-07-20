CLASS zcl_generar_datos_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_generar_datos_02 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    " Limpiar datos previos (por si se ejecuta varias veces)
*    DELETE FROM zcliente_02 WHERE client = @sy-mandt.
*    DELETE FROM zpedido_02 WHERE client = @sy-mandt.
    DELETE FROM zcliente_02 WHERE cliente_id LIKE '%'.
    DELETE FROM zpedido_02 WHERE pedido_id LIKE '%'.

    " ---------- CLIENTES ----------
    DATA lt_clientes TYPE TABLE OF zcliente_02.

    lt_clientes = VALUE #(
      ( client = sy-mandt cliente_id = '0001' nombre = 'Ana Garcia'      ciudad = 'Sevilla' )
      ( client = sy-mandt cliente_id = '0002' nombre = 'Luis Perez'      ciudad = 'Huelva' )
      ( client = sy-mandt cliente_id = '0003' nombre = 'Marta Ruiz'      ciudad = 'Cadiz' )
      ( client = sy-mandt cliente_id = '0004' nombre = 'Pedro Sanchez'   ciudad = 'Sevilla' )
      ( client = sy-mandt cliente_id = '0005' nombre = 'Lucia Fernandez' ciudad = 'Granada' )
      ( client = sy-mandt cliente_id = '0006' nombre = 'Javier Torres'   ciudad = 'Huelva' )
      ( client = sy-mandt cliente_id = '0007' nombre = 'Sara Jimenez'    ciudad = 'Malaga' )
      ( client = sy-mandt cliente_id = '0008' nombre = 'Diego Morales'   ciudad = 'Sevilla' )
    ).

    INSERT zcliente_02 FROM TABLE @lt_clientes.

    " ---------- PEDIDOS ----------
    DATA lt_pedidos TYPE TABLE OF zpedido_02.

    lt_pedidos = VALUE #(
      ( client = sy-mandt pedido_id = '0001' cliente_id = '0001' producto = 'Portatil'     importe = '899.00'  fecha = '20260115' )
      ( client = sy-mandt pedido_id = '0002' cliente_id = '0001' producto = 'Raton'         importe = '25.50'   fecha = '20260118' )
      ( client = sy-mandt pedido_id = '0003' cliente_id = '0002' producto = 'Monitor'       importe = '210.00'  fecha = '20260120' )
      ( client = sy-mandt pedido_id = '0004' cliente_id = '0002' producto = 'Teclado'       importe = '45.00'   fecha = '20260122' )
      ( client = sy-mandt pedido_id = '0005' cliente_id = '0003' producto = 'Auriculares'   importe = '60.00'   fecha = '20260125' )
      ( client = sy-mandt pedido_id = '0006' cliente_id = '0004' producto = 'Tablet'        importe = '320.00'  fecha = '20260128' )
      ( client = sy-mandt pedido_id = '0007' cliente_id = '0004' producto = 'Funda tablet'  importe = '18.00'   fecha = '20260130' )
      ( client = sy-mandt pedido_id = '0008' cliente_id = '0005' producto = 'Impresora'     importe = '150.00'  fecha = '20260201' )
      ( client = sy-mandt pedido_id = '0009' cliente_id = '0006' producto = 'Silla oficina' importe = '210.00'  fecha = '20260203' )
      ( client = sy-mandt pedido_id = '0010' cliente_id = '0007' producto = 'Portatil'      importe = '750.00'  fecha = '20260205' )
      ( client = sy-mandt pedido_id = '0011' cliente_id = '0007' producto = 'Mochila'       importe = '35.00'   fecha = '20260207' )
      ( client = sy-mandt pedido_id = '0012' cliente_id = '0008' producto = 'Monitor'       importe = '195.00'  fecha = '20260210' )
      ( client = sy-mandt pedido_id = '0013' cliente_id = '0001' producto = 'Webcam'        importe = '40.00'   fecha = '20260212' )
      ( client = sy-mandt pedido_id = '0014' cliente_id = '0003' producto = 'Portatil'      importe = '910.00'  fecha = '20260215' )
      ( client = sy-mandt pedido_id = '0015' cliente_id = '0005' producto = 'Raton'         importe = '22.00'   fecha = '20260218' )
    ).

    INSERT zpedido_02 FROM TABLE @lt_pedidos.

    out->write( |Insertados { lines( lt_clientes ) } clientes y { lines( lt_pedidos ) } pedidos.| ).


  ENDMETHOD.
ENDCLASS.
