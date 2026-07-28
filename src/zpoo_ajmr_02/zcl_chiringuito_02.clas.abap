CLASS zcl_chiringuito_02 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        iv_nombre TYPE string.

    METHODS vender
      IMPORTING
        iv_importe   TYPE decfloat34
      RETURNING
        VALUE(rv_ok) TYPE abap_bool.

    METHODS calcular_comision_ayuntamiento
      RETURNING
        VALUE(rv_comision) TYPE decfloat34.

    METHODS consultar_recaudacion
      RETURNING
        VALUE(rv_recaudacion) TYPE decfloat34.

  PROTECTED SECTION.
    DATA mv_nombre      TYPE string.
    DATA mv_recaudacion TYPE decfloat34.

ENDCLASS.


CLASS zcl_chiringuito_02 IMPLEMENTATION.

  METHOD constructor.
    mv_nombre      = iv_nombre.
    mv_recaudacion = 0.
  ENDMETHOD.

  METHOD vender.
    IF iv_importe > 0.
      mv_recaudacion = mv_recaudacion + iv_importe.
      rv_ok = abap_true.
    ELSE.
      rv_ok = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD calcular_comision_ayuntamiento.
    rv_comision = mv_recaudacion * '0.10'.
  ENDMETHOD.

  METHOD consultar_recaudacion.
    rv_recaudacion = mv_recaudacion.
  ENDMETHOD.

ENDCLASS.
