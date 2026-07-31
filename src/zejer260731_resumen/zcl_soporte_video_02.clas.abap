CLASS zcl_soporte_video_02 DEFINITION
  PUBLIC
*  FINAL
  CREATE PUBLIC .

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


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_soporte_video_02 IMPLEMENTATION.

  METHOD consultar_total_soportes.

  ENDMETHOD.

  METHOD constructor.

  ENDMETHOD.

  METHOD calcular_precio_final.

  ENDMETHOD.

ENDCLASS.
