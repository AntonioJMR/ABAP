CLASS zcl_caseta_02 DEFINITION
PUBLIC INHERITING FROM zcl_atraccion_02
FINAL
CREATE PUBLIC.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        iv_nombre TYPE string.

    METHODS pedir_rebujito
        RETURNING  VALUE(rv_texto) TYPE string.

ENDCLASS.

CLASS zcl_caseta_02 IMPLEMENTATION.

  METHOD constructor.

    super->constructor( iv_nombre = iv_nombre ).

  ENDMETHOD.


  METHOD pedir_rebujito.
    " sin lógica obligatoria
        rv_texto = | dame un pedir rebujito |.
  ENDMETHOD.



ENDCLASS.
