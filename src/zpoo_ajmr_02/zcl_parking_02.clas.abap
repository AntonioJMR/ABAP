CLASS zcl_parking_02 DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS calcular_tarifa
      IMPORTING iv_horas_estacionado TYPE i
      EXPORTING ev_minutos_totales   TYPE i
*      RETURNING VALUE(rv_precio)     TYPE p LENGTH 8 DECIMALS 2.
*      RETURNING VALUE(rv_precio)   TYPE decfloat34.
      RETURNING VALUE(rv_precio)   TYPE zdecimals2.


ENDCLASS.


CLASS zcl_parking_02 IMPLEMENTATION.

  METHOD calcular_tarifa.

    ev_minutos_totales = iv_horas_estacionado * 60.
    rv_precio          = iv_horas_estacionado * '1.50'.

  ENDMETHOD.

ENDCLASS.
