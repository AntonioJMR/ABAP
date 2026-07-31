CLASS zcl_notificacion_sms_02 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_notificable_02.
*    INTERFACES if_oo_adt_classrun.


    METHODS constructor
      IMPORTING
        iv_telefono TYPE string.

  PRIVATE SECTION.
    DATA mv_telefono TYPE string.
    DATA mo_out TYPE REF TO if_oo_adt_classrun_out.

ENDCLASS.


CLASS zcl_notificacion_sms_02 IMPLEMENTATION.

  METHOD constructor.
    mv_telefono = iv_telefono.
  ENDMETHOD.

  METHOD zif_notificable_02~notificar.
    mo_out->write( |SMS al { mv_telefono }: { iv_mensaje }| ).
  ENDMETHOD.

  METHOD zif_notificable_02~consultar_coste_envio.
    rv_coste = '0.10'.
  ENDMETHOD.

ENDCLASS.
