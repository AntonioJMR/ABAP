INTERFACE zif_describible_02 PUBLIC.

  TYPES tt_describibles TYPE STANDARD TABLE OF REF TO zif_describible_02 WITH EMPTY KEY.

  METHODS describir
    RETURNING VALUE(resultado) TYPE string.

ENDINTERFACE.

