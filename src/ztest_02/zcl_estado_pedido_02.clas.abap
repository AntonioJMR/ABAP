CLASS zcl_estado_pedido_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_estado_pedido_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.


    DATA(lv_estado) = 'E'.

    " SWITCH para Texto
    FINAL(lv_descripcion) = SWITCH string( lv_estado
      WHEN 'P' THEN 'Pendiente'
      WHEN 'E' THEN 'Enviado'
      WHEN 'R' THEN 'Recibido'
      WHEN 'C' THEN 'Cancelado'
      ELSE          'Estado desconocido'
    ).

    "
    out->write( |Código del estado:       { lv_estado }| ).
    out->write( |Descripción del estado:  { lv_descripcion }| ).
    out->write( |-------------------2º-------------------------| ).

    " 2º: SWITCH para obtener la prioridad (Entero)
    FINAL(lv_prioridad) = SWITCH i( lv_estado
      WHEN 'P' THEN 1
      WHEN 'E' THEN 2
      WHEN 'R' THEN 3
      WHEN 'C' THEN 4
      ELSE          0
    ).


    out->write( |Prioridad del pedido:    { lv_prioridad }| ).

  ENDMETHOD.
ENDCLASS.

