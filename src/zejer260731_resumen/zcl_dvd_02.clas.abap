CLASS zcl_dvd_02 DEFINITION
  PUBLIC
  INHERITING FROM zcl_soporte_video_02
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        iv_titulo          TYPE string
        iv_precio_alquiler TYPE zdecimals2
        iv_tema            TYPE string.


  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA veces_alquilado TYPE i.

ENDCLASS.



CLASS zcl_dvd_02 IMPLEMENTATION.


  METHOD constructor.

    super->constructor( ).

  ENDMETHOD.

ENDCLASS.
