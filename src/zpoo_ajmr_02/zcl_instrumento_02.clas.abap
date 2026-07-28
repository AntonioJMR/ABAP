CLASS zcl_instrumento_02 DEFINITION PUBLIC ABSTRACT CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        iv_marca TYPE string.

    METHODS registrar_practica
      IMPORTING
        iv_horas_practicadas TYPE i.

    METHODS consultar_horas_uso
      RETURNING VALUE(resultado) TYPE i.

  PROTECTED SECTION.

    DATA mv_marca          TYPE string.
    DATA mv_horas_uso      TYPE i.

ENDCLASS.


CLASS zcl_instrumento_02 IMPLEMENTATION.

  METHOD constructor.
    mv_marca     = iv_marca.
    mv_horas_uso = 0.
  ENDMETHOD.

  METHOD registrar_practica.
    mv_horas_uso = mv_horas_uso + iv_horas_practicadas.
  ENDMETHOD.

  METHOD consultar_horas_uso.
    resultado = mv_horas_uso.
  ENDMETHOD.

ENDCLASS.
