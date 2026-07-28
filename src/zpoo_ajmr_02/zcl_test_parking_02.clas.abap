CLASS zcl_test_parking_02 DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS zcl_test_parking_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(parking) = NEW zcl_parking_02( ).

    DATA: lv_precio_1  TYPE zdecimals2,
          lv_minutos_1 TYPE i.

    parking->calcular_tarifa(
      EXPORTING iv_horas_estacionado = 3
      IMPORTING ev_minutos_totales   = lv_minutos_1
      RECEIVING rv_precio            = lv_precio_1
    ).

    out->write( |3 horas -> Precio: { lv_precio_1 } - Minutos: { lv_minutos_1 }| ).

  ENDMETHOD.

ENDCLASS.
