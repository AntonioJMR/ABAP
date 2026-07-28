CLASS zcl_test_caja_fuerte_02 DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS zcl_test_caja_fuerte_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(lv_cajaFuerte) = NEW zcl_caja_fuerte_02( '2407' ).

    " Intento 0: codigo Correcto
    DATA(lv_resultado_0) = lv_cajaFuerte->abrir( iv_codigo_intento = '2407' ).
    out->write( |Intento 0 (2407): Caja Abierta = { lv_resultado_0 } - Bloqueada = { lv_cajaFuerte->esta_bloqueada( ) }| ).


    " Intento 1: codigo incorrecto
    DATA(lv_resultado_1) = lv_cajaFuerte->abrir( iv_codigo_intento = '0000' ).
    out->write( |Intento 1 (0000): Caja Abierta = { lv_resultado_1 } - Bloqueada = { lv_cajaFuerte->esta_bloqueada( ) }| ).

    " Intento 2: codigo incorrecto
    DATA(lv_resultado_2) = lv_cajaFuerte->abrir( iv_codigo_intento = '1111' ).
    out->write( |Intento 2 (1111): Caja Abierta = { lv_resultado_2 } - Bloqueada = { lv_cajaFuerte->esta_bloqueada( ) }| ).

    " Intento 3: codigo incorrecto -> deberia bloquearse
    DATA(lv_resultado_3) = lv_cajaFuerte->abrir( iv_codigo_intento = '2222' ).
    out->write( |Intento 3 (2222): Caja Abierta = { lv_resultado_3 } - Bloqueada = { lv_cajaFuerte->esta_bloqueada( ) }| ).

    " Intento 4: codigo correcto, pero ya deberia estar bloqueada
    DATA(lv_resultado_4) = lv_cajaFuerte->abrir( iv_codigo_intento = '1234' ).
    out->write( |Intento 4 (1234, correcto): Caja Abierta = { lv_resultado_4 } - Bloqueada = { lv_cajaFuerte->esta_bloqueada( ) }| ).

    " Consulta final del estado de bloqueo
    out->write( |Estado final de la caja - { lv_cajaFuerte->esta_bloqueada( ) }| ).


    """""""""""""""""""""""""""""""2nd objeto""""""""""""""""""""""""""""""""""
    DATA(lv_cajaFuerte1) = NEW zcl_caja_fuerte_02( '2407' ).

    " Consulta final del estado de bloqueo
    out->write( |Estado final de la caja - { lv_cajaFuerte1->esta_bloqueada( ) }| ).


  ENDMETHOD.

ENDCLASS.
