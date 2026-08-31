CLASS zcl_programador_02 DEFINITION

  PUBLIC
  INHERITING FROM zcl_empleado_02
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS:
      constructor
        IMPORTING
          lv_nombre   TYPE string
          lv_lenguaje TYPE string.

    METHODS:
      obtener_lenguaje
        RETURNING VALUE(rv_lenguaje) TYPE string.

  PROTECTED SECTION.

    DATA lenguaje TYPE string.

ENDCLASS.


CLASS zcl_programador_02 IMPLEMENTATION.

  METHOD constructor.

    super->constructor( lv_nombre = lv_nombre ).

    lenguaje = lv_lenguaje.

  ENDMETHOD.


  METHOD obtener_lenguaje.

    rv_lenguaje = lenguaje.

  ENDMETHOD.

ENDCLASS.
