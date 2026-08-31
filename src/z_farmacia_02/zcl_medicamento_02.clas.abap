CLASS zcl_medicamento_02 DEFINITION

  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        iv_nombre  TYPE string
        iv_precio  TYPE zdecimals2
        iv_stock   TYPE i.

    METHODS obtener_nombre
      RETURNING VALUE(rv_nombre) TYPE string.

    METHODS obtener_precio_final
      RETURNING VALUE(rv_precio) TYPE zdecimals2.

  PROTECTED SECTION.

    DATA nombre TYPE string.
    DATA precio TYPE zdecimals2.
    DATA stock  TYPE i.

ENDCLASS.


CLASS zcl_medicamento_02 IMPLEMENTATION.

  METHOD constructor.

    nombre = iv_nombre.
    precio = iv_precio.
    stock  = iv_stock.

  ENDMETHOD.


  METHOD obtener_nombre.

    rv_nombre = nombre.

  ENDMETHOD.


  METHOD obtener_precio_final.

    rv_precio = precio.

  ENDMETHOD.

ENDCLASS.
