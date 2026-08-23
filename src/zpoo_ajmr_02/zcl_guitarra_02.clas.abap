CLASS zcl_guitarra_02 DEFINITION
PUBLIC
FINAL
CREATE PUBLIC
  INHERITING FROM zcl_instrumento_02.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        iv_marca          TYPE string
        iv_numero_cuerdas TYPE i.


    METHODS afinar_cuerda
      IMPORTING
        iv_numero_cuerda TYPE i
      RETURNING
        VALUE(resultado) TYPE abap_bool.

  PRIVATE SECTION.

    DATA mv_numero_cuerdas TYPE i.

ENDCLASS.



CLASS ZCL_GUITARRA_02 IMPLEMENTATION.


  METHOD constructor.
    super->constructor( iv_marca = iv_marca ).
    mv_numero_cuerdas = iv_numero_cuerdas.
  ENDMETHOD.


  METHOD afinar_cuerda.

    IF iv_numero_cuerda > 0 AND iv_numero_cuerda <= mv_numero_cuerdas.
      resultado = abap_true.
    ELSE.
      resultado = abap_false.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
