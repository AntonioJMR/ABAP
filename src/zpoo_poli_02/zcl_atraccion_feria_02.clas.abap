CLASS zcl_atraccion_feria_02 DEFINITION
PUBLIC INHERITING FROM zcl_atraccion_02
FINAL
CREATE PUBLIC.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        iv_nombre TYPE string
        iv_precio TYPE zdecimals2.

    METHODS calcular_precio_entrada REDEFINITION.

  PRIVATE SECTION.
    DATA: mv_precio TYPE p DECIMALS 2.
ENDCLASS.



CLASS ZCL_ATRACCION_FERIA_02 IMPLEMENTATION.


  METHOD constructor.
    super->constructor( iv_nombre = iv_nombre ).
    mv_precio = iv_precio.
  ENDMETHOD.


  METHOD calcular_precio_entrada.
    rv_precio = mv_precio.
  ENDMETHOD.
ENDCLASS.
