CLASS zcl_med_generico_02 DEFINITION

  PUBLIC
  INHERITING FROM zcl_medicamento_02
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        lv_nombre           TYPE string
        lv_precio           TYPE zdecimals2
        lv_stock            TYPE i
        lv_principio_activo TYPE string
        lv_descuento        TYPE i.

    METHODS obtener_principio_activo
      RETURNING VALUE(rv_principio) TYPE string.

    METHODS obtener_precio_final REDEFINITION.

  PROTECTED SECTION.

    DATA principio_activo TYPE string.
    DATA descuento        TYPE i.

ENDCLASS.


CLASS zcl_med_generico_02 IMPLEMENTATION.

  METHOD constructor.

    super->constructor(
      lv_nombre = lv_nombre
      lv_precio = lv_precio
      lv_stock  = lv_stock
    ).

    principio_activo = lv_principio_activo.
    descuento        = lv_descuento.

  ENDMETHOD.


  METHOD obtener_principio_activo.

    rv_principio = principio_activo.

  ENDMETHOD.


  METHOD obtener_precio_final.

    rv_precio = precio - ( precio * descuento / 100 ).

  ENDMETHOD.

ENDCLASS.
