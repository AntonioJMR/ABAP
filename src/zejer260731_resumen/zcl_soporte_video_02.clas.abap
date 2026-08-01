CLASS zcl_soporte_video_02 DEFINITION PUBLIC ABSTRACT CREATE PUBLIC.

  PUBLIC SECTION.

    CLASS-DATA total_soportes_creados TYPE i.

    CLASS-METHODS consultar_total_soportes
      RETURNING VALUE(resultado) TYPE i.

    METHODS constructor
      IMPORTING
        iv_titulo          TYPE string
        iv_precio_alquiler TYPE zdecimals2.

    METHODS calcular_precio_final
      RETURNING VALUE(resultado) TYPE zdecimals2.

    METHODS registrar_alquiler.

    METHODS consultar_veces_alquilado
      RETURNING VALUE(resultado) TYPE i.

  PROTECTED SECTION.

    DATA titulo          TYPE string.
    DATA precio_alquiler TYPE p LENGTH 8 DECIMALS 2.

  PRIVATE SECTION.

    DATA veces_alquilado TYPE i.

ENDCLASS.


CLASS zcl_soporte_video_02 IMPLEMENTATION.

  METHOD consultar_total_soportes.
    resultado = total_soportes_creados.
  ENDMETHOD.

  METHOD constructor.
    titulo           = iv_titulo.
    precio_alquiler  = iv_precio_alquiler.
    veces_alquilado  = 0.
    total_soportes_creados = total_soportes_creados + 1.
  ENDMETHOD.

  METHOD calcular_precio_final.
    resultado = precio_alquiler.
  ENDMETHOD.

  METHOD registrar_alquiler.
    veces_alquilado = veces_alquilado + 1.
  ENDMETHOD.

  METHOD consultar_veces_alquilado.
    resultado = veces_alquilado.
  ENDMETHOD.

ENDCLASS.
