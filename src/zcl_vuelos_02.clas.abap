CLASS zcl_vuelos_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_vuelos_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    SELECT FROM /dmo/flight
        FIELDS
             carrier_id,
             connection_id,
             price
        ORDER BY carrier_id

        INTO TABLE @DATA(lt_vuelos).

    if sy-subrc = 0.
        out->write( lt_vuelos ).
    else.
        out->write( 'No se han encontrado vuelos' ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
