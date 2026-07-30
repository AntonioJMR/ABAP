CLASS zcl_concierto_02 DEFINITION
PUBLIC INHERITING FROM zcl_atraccion_02
FINAL
CREATE PUBLIC.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        iv_nombre TYPE string.

    METHODS calcular_precio_entrada REDEFINITION.
ENDCLASS.

CLASS zcl_concierto_02 IMPLEMENTATION.
  METHOD constructor.
    super->constructor( iv_nombre = iv_nombre ).
  ENDMETHOD.

  METHOD calcular_precio_entrada.
    IF consultar_visitantes( ) < 500.
      rv_precio = '10.00'.
    ELSE.
      rv_precio = '5.00'.
    ENDIF.
  ENDMETHOD.
ENDCLASS.


