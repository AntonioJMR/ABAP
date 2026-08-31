CLASS zcl_empleado_02 DEFINITION

  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS:
      obtener_nombre
        RETURNING VALUE(rv_nombre) TYPE string.

    METHODS:
      constructor
        IMPORTING
          lv_nombre TYPE string.

  PROTECTED SECTION.

    DATA nombre TYPE string.

ENDCLASS.


CLASS zcl_empleado_02 IMPLEMENTATION.

  METHOD constructor.

    nombre = lv_nombre.

  ENDMETHOD.


  METHOD obtener_nombre.

    rv_nombre = nombre.

  ENDMETHOD.

ENDCLASS.
