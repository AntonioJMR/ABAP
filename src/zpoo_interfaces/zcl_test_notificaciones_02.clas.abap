CLASS zcl_test_notificaciones_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

ENDCLASS.



CLASS ZCL_TEST_NOTIFICACIONES_02 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: lo_sms1   TYPE REF TO zcl_notificacion_sms_02,
          lo_sms2   TYPE REF TO zcl_notificacion_sms_02,
          lo_carta1 TYPE REF TO zcl_notificacion_carta_02,
          lo_carta2 TYPE REF TO zcl_notificacion_carta_02,
          lv_coste  TYPE zdecimals2.

    "=======================1================================

    lo_sms1   = NEW zcl_notificacion_sms_02( iv_telefono = '600111222' ).
    lo_carta1 = NEW zcl_notificacion_carta_02( iv_direccion = 'Calle Mayor 1' ).

    lo_sms1->zif_notificable_02~notificar( iv_mensaje = 'Su saldo ha cambiado' ).
    lo_carta1->zif_notificable_02~notificar( iv_mensaje = 'Su saldo ha cambiado' ).
*    lo_sms1->notificar( iv_mensaje = 'Su saldo ha cambiado' ).
*    lo_carta1->notificar( iv_mensaje = 'Su saldo ha cambiado' ).


    lv_coste = lo_sms1->zif_notificable_02~consultar_coste_envio( ).
    out->write( |Coste envío SMS: { lv_coste } € | ).

    lv_coste = lo_carta1->zif_notificable_02~consultar_coste_envio( ).
    out->write( |Coste envío carta: { lv_coste } € | ).

    "==============================2=========================
out->write( |==============================2=========================| ).


    DATA lt_notificaciones TYPE TABLE OF REF TO zif_notificable_02.


    lo_sms2   = NEW zcl_notificacion_sms_02( iv_telefono = '600333444' ).
    lo_carta2 = NEW zcl_notificacion_carta_02( iv_direccion = 'Avenida Sur 25' ).

    APPEND lo_sms1   TO lt_notificaciones.
    APPEND lo_carta1 TO lt_notificaciones.
    APPEND lo_sms2   TO lt_notificaciones.
    APPEND lo_carta2 TO lt_notificaciones.


    DATA lv_coste_total TYPE decfloat34 VALUE 0.

    LOOP AT lt_notificaciones INTO DATA(lo_notificacion).

*      lo_notificacion->zif_notificable_02~notificar( iv_mensaje = 'Su nómina ha sido ingresada' ).
      lo_notificacion->notificar( iv_mensaje = 'Su nómina ha sido ingresada' ).

*      lv_coste = lo_notificacion->zif_notificable_02~consultar_coste_envio( ).
      lv_coste = lo_notificacion->consultar_coste_envio( ).
      out->write( |Coste de este envío: { lv_coste } € | ).

      lv_coste_total = lv_coste_total + lv_coste.

    ENDLOOP.

    out->write( |Coste TOTAL de todos los envíos: { lv_coste_total } € | ).

  ENDMETHOD.
ENDCLASS.
