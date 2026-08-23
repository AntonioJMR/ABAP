CLASS zcl_chiringuito_bebidas_02 DEFINITION
  PUBLIC
  INHERITING FROM zcl_chiringuito_02
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS vender REDEFINITION.

    METHODS anadir_hielo
      RETURNING
        VALUE(rv_mensaje) TYPE string.

ENDCLASS.



CLASS ZCL_CHIRINGUITO_BEBIDAS_02 IMPLEMENTATION.


  METHOD vender.
    IF iv_importe < '1.50'.
      rv_ok = abap_false.
    ELSE.
      mv_recaudacion = mv_recaudacion + iv_importe.
      rv_ok = abap_true.
    ENDIF.
  ENDMETHOD.


  METHOD anadir_hielo.
    rv_mensaje = |Se ha añadido hielo extra al pedido.|.
  ENDMETHOD.
ENDCLASS.
