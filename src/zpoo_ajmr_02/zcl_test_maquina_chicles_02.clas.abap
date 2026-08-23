CLASS zcl_test_maquina_chicles_02 DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.



CLASS ZCL_TEST_MAQUINA_CHICLES_02 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA(lo_maquina) = NEW zcl_maquina_chicles_02( 2 ).

    DATA(lv_cambio_1) = lo_maquina->vender_chicle( iv_moneda = 25 ).
    out->write( |Moneda 25: Cambio: { lv_cambio_1 } centimos - Stock maquinas de chicles:  { lo_maquina->consultar_stock( ) }| ).

    DATA(lv_cambio_2) = lo_maquina->vender_chicle( iv_moneda = 50 ).
    out->write( |Moneda 50: Cambio: { lv_cambio_2 } centimos - Stock maquinas de chicles:  { lo_maquina->consultar_stock( ) }| ).

    DATA(lv_cambio_3) = lo_maquina->vender_chicle( iv_moneda = 25 ).
    out->write( |Moneda 25 (sin stock): Cambio: { lv_cambio_3 } centimos - Stock maquinas de chicles:  { lo_maquina->consultar_stock( ) }| ).

    DATA(lv_cambio_4) = lo_maquina->vender_chicle( iv_moneda = 10 ).
    out->write( |Moneda 10 (insuficiente): Cambio: { lv_cambio_4 } centimos - Stock maquinas de chicles:  { lo_maquina->consultar_stock( ) }| ).

  ENDMETHOD.
ENDCLASS.
