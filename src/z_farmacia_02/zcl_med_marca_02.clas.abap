CLASS zcl_med_marca_02 DEFINITION

  PUBLIC
  INHERITING FROM zcl_medicamento_02
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        lv_nombre          TYPE string
        lv_precio          TYPE zdecimals2
        lv_stock           TYPE i
        lv_nombre_comercial TYPE string
        lv_recargo         TYPE i.

    METHODS obtener_nombre_comercial
      RETURNING VALUE(rv_nombre_comercial) TYPE string.

    METHODS obtener_precio_final REDEFINITION.

  PROTECTED SECTION.

    DATA nombre_comercial TYPE string.
    DATA recargo          TYPE i.

ENDCLASS.


CLASS zcl_med_marca_02 IMPLEMENTATION.

  METHOD constructor.

    super->constructor(
      lv_nombre = lv_nombre
      lv_precio = lv_precio
      lv_stock  = lv_stock
    ).

    nombre_comercial = lv_nombre_comercial.
    recargo          = lv_recargo.

  ENDMETHOD.


  METHOD obtener_nombre_comercial.

    rv_nombre_comercial = nombre_comercial.

  ENDMETHOD.


  METHOD obtener_precio_final.

    rv_precio = precio + ( precio * recargo / 100 ).

  ENDMETHOD.

ENDCLASS.
