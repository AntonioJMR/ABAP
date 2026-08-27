CLASS zcx_planta_invalida_02 DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  CREATE PUBLIC.

  PUBLIC SECTION.

  INTERFACES if_t100_dyn_msg .
  INTERFACES if_t100_message .

    CONSTANTS:
      BEGIN OF stock_insuficiente,
        msgid TYPE symsgid VALUE 'ZMSG_JARDINERIA_02',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF stock_insuficiente,

      BEGIN OF riego_insuficiente,
        msgid TYPE symsgid VALUE 'ZMSG_JARDINERIA_02',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF riego_insuficiente.
    CLASS-METHODS class_constructor.



METHODS constructor
  IMPORTING
    textid LIKE if_t100_message=>t100key OPTIONAL
    previous LIKE previous OPTIONAL.

ENDCLASS.


CLASS zcx_planta_invalida_02 IMPLEMENTATION.

  METHOD class_constructor.

  ENDMETHOD.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( previous = previous ).

    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

  ENDMETHOD.

ENDCLASS.

