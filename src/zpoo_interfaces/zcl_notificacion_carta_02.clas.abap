CLASS zcl_notificacion_carta_02 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_notificable_02.

    METHODS constructor
      IMPORTING
        iv_direccion TYPE string.

  PRIVATE SECTION.
    DATA mv_direccion TYPE string.
    DATA: mo_out TYPE REF TO if_oo_adt_classrun_out.

ENDCLASS.



CLASS ZCL_NOTIFICACION_CARTA_02 IMPLEMENTATION.


  METHOD constructor.
    mv_direccion = iv_direccion.
  ENDMETHOD.


  METHOD zif_notificable_02~notificar.
    mo_out->write( |Carta a { mv_direccion }: { iv_mensaje }| ).
  ENDMETHOD.


  METHOD zif_notificable_02~consultar_coste_envio.
    rv_coste = '1.20'.
  ENDMETHOD.
ENDCLASS.
