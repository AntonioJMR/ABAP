CLASS zcx_flight_error_02 DEFINITION

  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    DATA message TYPE string READ-ONLY.

    METHODS constructor
      IMPORTING
        iv_message TYPE string.

ENDCLASS.


CLASS zcx_flight_error_02 IMPLEMENTATION.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.

    super->constructor( ).

    message = iv_message.

  ENDMETHOD.

ENDCLASS.



