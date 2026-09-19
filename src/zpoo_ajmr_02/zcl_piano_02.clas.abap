CLASS zcl_piano_02 DEFINITION PUBLIC FINAL CREATE PUBLIC
  INHERITING FROM zcl_instrumento_02.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        iv_marca       TYPE string
        iv_es_electrico TYPE abap_bool.

    METHODS pedalear
      RETURNING VALUE(resultado) TYPE abap_bool.

  PRIVATE SECTION.

    DATA mv_es_electrico TYPE abap_bool.

ENDCLASS.



CLASS ZCL_PIANO_02 IMPLEMENTATION.


  METHOD constructor.
    super->constructor( iv_marca = iv_marca ).
    mv_es_electrico = iv_es_electrico.
  ENDMETHOD.


  METHOD pedalear.

    IF mv_horas_uso >= 1.
      resultado = abap_true.
    ELSE.
      resultado = abap_false.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
