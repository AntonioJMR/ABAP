CLASS zcl_caseta_02 DEFINITION
PUBLIC INHERITING FROM zcl_atraccion_02
FINAL
CREATE PUBLIC.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        iv_nombre TYPE string.

    METHODS pedir_rebujito.
ENDCLASS.

CLASS zcl_caseta_02 IMPLEMENTATION.


  METHOD pedir_rebujito.
    " sin lógica obligatoria
  ENDMETHOD.
  METHOD constructor.

    super->constructor( iv_nombre = iv_nombre ).

  ENDMETHOD.


ENDCLASS.
