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

    "-------------------1---------------------
    out->write(  ' ----------------------1-------------------- ' ).
    SELECT FROM /dmo/flight
        FIELDS *
        ORDER BY carrier_id

        INTO TABLE @DATA(lt_vuelos).
    IF sy-subrc = 0.
      out->write( lt_vuelos ).
    ELSE.
      out->write( 'No se han encontrado vuelos' ).
    ENDIF.

    "----------------------2--------------------
    out->write(  ' ----------------------2-------------------- ' ).
    SELECT FROM /dmo/flight
        FIELDS
             carrier_id,
             connection_id,
             price
        ORDER BY carrier_id

        INTO TABLE @DATA(lt_vuelos2).

    IF sy-subrc = 0.
      out->write( lt_vuelos2 ).
    ELSE.
      out->write( 'No se han encontrado vuelos' ).
    ENDIF.

    "----------------------3--------------------
    out->write(  ' ----------------------3-------------------- ' ).
    SELECT FROM /dmo/flight
         FIELDS *
         WHERE carrier_id = 'LH'
         INTO TABLE @DATA(lt_vuelos3).

    IF sy-subrc = 0.
      out->write( lt_vuelos3 ).
    ELSE.
      out->write( 'No se han encontrado vuelos' ).
    ENDIF.


    "----------------------4--------------------
    out->write(  ' ----------------------4-------------------- ' ).
    SELECT FROM /dmo/flight
         FIELDS *
         WHERE price > 5000
         INTO TABLE @DATA(lt_vuelos4).

    IF sy-subrc = 0.
      out->write( lt_vuelos4 ).
    ELSE.
      out->write( 'No se han encontrado vuelos' ).
    ENDIF.

    "----------------------5--------------------
    out->write(  ' ----------------------5-------------------- ' ).
    SELECT FROM /dmo/flight
         FIELDS
         "cARRIER_ID, CONNECTION_ID, PLANE_TYPE_ID y SEATS_MAX.
         carrier_id,
 		connection_id,
 		plane_type_id,
 		seats_max
         WHERE plane_type_id = 'A320-800'
         INTO TABLE @DATA(lt_vuelos5).

    IF sy-subrc = 0.
      out->write( lt_vuelos5 ).
    ELSE.
      out->write( 'No se han encontrado vuelos' ).
    ENDIF.

    "----------------------6--------------------
    out->write(  ' ----------------------6-------------------- ' ).

    SELECT *
      FROM /dmo/flight
      WHERE carrier_id = 'AA'
        AND price < 1000
      INTO TABLE @DATA(lt_vuelos6).

    IF sy-subrc = 0.
      out->write( lt_vuelos6 ).
    ELSE.
      out->write( 'No se han encontrado vuelos' ).
    ENDIF.

    "----------------------7--------------------
    out->write(  ' ----------------------7-------------------- ' ).

    SELECT carrier_id, connection_id, seats_max, seats_occupied
      FROM /dmo/flight
      WHERE seats_occupied > ( seats_max * division( 9, 10, 1 ) )
      INTO TABLE @DATA(lt_vuelos7).

    IF sy-subrc = 0.
      out->write( lt_vuelos7 ).
    ELSE.
      out->write( 'No se han encontrado vuelos' ).
    ENDIF.

    "----------------------8--------------------
    out->write(  ' ----------------------8-------------------- ' ).
    SELECT carrier_id, connection_id, currency_code, price
  FROM /dmo/flight
  WHERE currency_code = 'EUR'
     OR currency_code = 'USD'
  ORDER BY price DESCENDING
  INTO TABLE @DATA(lt_vuelos8).

    IF sy-subrc = 0.
      out->write( lt_vuelos8 ).
    ELSE.
      out->write( 'No se han encontrado vuelos' ).
    ENDIF.

    "----------------------9--------------------
    out->write(  ' ----------------------9-------------------- ' ).

    SELECT *
      FROM /dmo/flight
      WHERE plane_type_id = '767-200'
        AND  carrier_id IN ( 'SQ', 'UA', 'LH' )
        ORDER BY carrier_id ASCENDING, price DESCENDING
      INTO TABLE @DATA(lt_vuelos9).

    IF sy-subrc = 0.
      out->write( lt_vuelos9 ).
    ELSE.
      out->write( 'No se han encontrado vuelos' ).
    ENDIF.


    "----------------------10--------------------
    out->write(  ' ----------------------10-------------------- ' ).

    SELECT carrier_id, connection_id, flight_date, price, seats_max
         FROM /dmo/flight
         WHERE price BETWEEN 2000 AND 6000
           AND carrier_id <> 'AA'
           AND seats_max > 200
         ORDER BY price ASCENDING
         INTO TABLE @DATA(lt_vuelos10).

    IF sy-subrc = 0.
      out->write( lt_vuelos10 ).
    ELSE.
      out->write( 'No se han encontradovuelos' ).
    ENDIF.



  ENDMETHOD.
ENDCLASS.
