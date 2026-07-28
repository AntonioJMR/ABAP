CLASS zcl_caja_fuerte_02 DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        iv_codigo TYPE string.     "El código de apertura (obligatorio) y

    METHODS abrir
      IMPORTING
        iv_codigo_intento TYPE string
      RETURNING
        VALUE(rv_estado_caja) TYPE abap_bool.

    METHODS esta_bloqueada
      EXPORTING
        rv_estado_caja_st TYPE string
      RETURNING VALUE(rv_estado_caja) TYPE abap_bool.


  PRIVATE SECTION.

    DATA mv_codigo              TYPE string.
    DATA mv_intentos_fallidos   TYPE i. "     con el contador de intentos fallidos a 0.
    DATA mv_bloqueada           TYPE abap_bool.

ENDCLASS.


CLASS zcl_caja_fuerte_02 IMPLEMENTATION.

  METHOD constructor.
    mv_codigo            = iv_codigo.
    mv_intentos_fallidos = 0.
    mv_bloqueada         = abap_false.
  ENDMETHOD.

  METHOD abrir.

    IF mv_bloqueada = abap_true.
      rv_estado_caja = abap_false.

    ELSEIF iv_codigo_intento = mv_codigo.
      mv_intentos_fallidos = 0.
      rv_estado_caja = abap_true.

    ELSE.
      mv_intentos_fallidos = mv_intentos_fallidos + 1.

      IF mv_intentos_fallidos >= 3.
        mv_bloqueada = abap_true.
      ENDIF.
        rv_estado_caja = abap_false.
    ENDIF.

  ENDMETHOD.

  METHOD esta_bloqueada.
    rv_estado_caja = mv_bloqueada.
    if rv_estado_caja = abap_true.
      rv_estado_caja = abap_true.
    else.
      rv_estado_caja = abap_false.
    endif.
  ENDMETHOD.

ENDCLASS.
