CLASS zcl_airline_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_airline_02 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

*   ==================================================================
*   EJERCICIO 1 — Vuelos con su avión y su aerolínea
*   ==================================================================
out->write( '--------------1 con JOIN-------------------' ).


    " --- SOL INNER JOIN ---
    SELECT FROM /dmo/flight AS f
      INNER JOIN /dmo/carrier AS c
        ON f~carrier_id = c~carrier_id
      FIELDS  c~name,
              f~connection_id,
              f~flight_date,
              f~price,
              f~currency_code,
              f~plane_type_id
      WHERE f~price > 5000
      ORDER BY f~price DESCENDING
      INTO TABLE @DATA(lt_ej1_join).

    IF sy-subrc = 0.
      out->write( 'Ejercicio 1 - JOIN' ).
      out->write( lt_ej1_join ).
    ELSE.
      out->write( 'Sin resultados' ).
    ENDIF.

    out->write( '--------------1 con WHERE-------------------' ).
*
    SELECT FROM /dmo/flight AS f
      FIELDS f~carrier_id, f~connection_id, f~flight_date, f~price, f~currency_code, f~plane_type_id
      WHERE price > 5000
      INTO TABLE @DATA(lt_vuelos_ej1).

    IF sy-subrc = 0.
      out->write( 'Ejer1 - WHERE:' ).
      out->write( lt_vuelos_ej1 ).
      SELECT FROM /dmo/carrier
        FIELDS carrier_id, name
        INTO TABLE @DATA(lt_subConsult_ej1).
*
*      LOOP AT lt_vuelos_ej1 INTO DATA(ls_vuelo_ej1).
*        READ TABLE lt_subConsult_ej1 INTO DATA(ls_carrier_ej1)
*             WITH KEY carrier_id = ls_vuelo_ej1-carrier_id.

*        out->write( |{ ls_carrier_ej1-name } - { ls_vuelo_ej1-connection_id } - { ls_vuelo_ej1-flight_date } - { ls_vuelo_ej1-price }| ).
         out->write( lt_subConsult_ej1 ).
*      ENDLOOP.
    ELSE.
      out->write( 'Sin resultados').
    ENDIF.


*
*
**   ==================================================================
**   EJERCICIO 2 — ¿Quién reservó cada vuelo?
**   ==================================================================
    out->write( '--------------2 con JOIN-------------------' ).
*
*    " La clave de union NO es travel_id, es customer_id
*    " (BOOKING guarda que cliente hizo la reserva mediante customer_id).
*
*    " --- SOLUCIÓN A: con INNER JOIN ---
*    SELECT FROM /dmo/booking AS b
*      INNER JOIN /dmo/customer AS cu
*        ON b~customer_id = cu~customer_id
*      FIELDS  cu~first_name,
*              cu~last_name,
*              b~travel_id,
*              b~booking_id,
*              b~booking_date
*      INTO TABLE @DATA(lt_ej2_join).
*
*    IF sy-subrc = 0.
*      out->write( |Ejercicio 2 - JOIN - Registros: { lines( lt_ej2_join ) }| ).
*      out->write( lt_ej2_join ).
*    ELSE.
*      out->write( |Ejercicio 2 - JOIN - Sin resultados| ).
*    ENDIF.
*
*    out->write( '---------------------------------------' ).
*
out->write( '--------------2 con WHERE -------------------' ).
*    SELECT FROM /dmo/booking
*      FIELDS customer_id, travel_id, booking_id, booking_date
*      INTO TABLE @DATA(lt_bookings_ej2).
*
*    IF sy-subrc = 0.
*      out->write( |Ejercicio 2 - WHERE - Reservas encontradas: { lines( lt_bookings_ej2 ) }| ).
*
*      SELECT FROM /dmo/customer
*        FIELDS customer_id, first_name, last_name
*        INTO TABLE @DATA(lt_customers_ej2).
*
*      LOOP AT lt_bookings_ej2 INTO DATA(ls_booking_ej2).
*        READ TABLE lt_customers_ej2 INTO DATA(ls_customer_ej2)
*             WITH KEY customer_id = ls_booking_ej2-customer_id.
*
*        out->write( |{ ls_customer_ej2-first_name } { ls_customer_ej2-last_name } - Travel { ls_booking_ej2-travel_id } - Booking { ls_booking_ej2-booking_id }| ).
*      ENDLOOP.
*    ELSE.
*      out->write( |Ejercicio 2 - WHERE - Sin resultados| ).
*    ENDIF.
*
*    out->write( '=========================================' ).
*
*
**   ==================================================================
**   EJERCICIO 3 — El itinerario completo de una reserva
**   ==================================================================
out->write( '-------------- 3 con JOIN-------------------' ).
*
*    " BOOKING -> FLIGHT: se conectan por carrier_id + connection_id + flight_date
*    " FLIGHT -> CARRIER: se conectan por carrier_id
*
*    " --- SOLUCIÓN A: con dos INNER JOIN encadenados ---
*    SELECT FROM /dmo/booking AS b
*      INNER JOIN /dmo/flight AS f
*        ON b~carrier_id    = f~carrier_id
*       AND b~connection_id = f~connection_id
*       AND b~flight_date   = f~flight_date
*      INNER JOIN /dmo/carrier AS c
*        ON f~carrier_id = c~carrier_id
*      FIELDS  c~name,
*              f~connection_id,
*              f~flight_date,
*              f~plane_type_id,
*              b~booking_id
*      INTO TABLE @DATA(lt_ej3_join).
*
*    IF sy-subrc = 0.
*      out->write( |Ejercicio 3 - JOIN - Registros: { lines( lt_ej3_join ) }| ).
*      out->write( lt_ej3_join ).
*    ELSE.
*      out->write( |Ejercicio 3 - JOIN - Sin resultados| ).
*    ENDIF.
*
    out->write( '-------------- 3 con WHERE -------------------' ).
*    SELECT FROM /dmo/booking
*      FIELDS carrier_id, connection_id, flight_date, booking_id
*      INTO TABLE @DATA(lt_bookings_ej3).
*
*    IF sy-subrc = 0.
*      out->write( |Ejercicio 3 - WHERE - Reservas encontradas: { lines( lt_bookings_ej3 ) }| ).
*
*      SELECT FROM /dmo/flight
*        FIELDS carrier_id, connection_id, flight_date, plane_type_id
*        INTO TABLE @DATA(lt_flights_ej3).
*
*      SELECT FROM /dmo/carrier
*        FIELDS carrier_id, name
*        INTO TABLE @DATA(lt_carriers_ej3).
*
*      LOOP AT lt_bookings_ej3 INTO DATA(ls_booking_ej3).
*
*        READ TABLE lt_flights_ej3 INTO DATA(ls_flight_ej3)
*             WITH KEY carrier_id    = ls_booking_ej3-carrier_id
*                      connection_id = ls_booking_ej3-connection_id
*                      flight_date   = ls_booking_ej3-flight_date.
*
*        IF sy-subrc <> 0.
*          CONTINUE.
*        ENDIF.
*
*        READ TABLE lt_carriers_ej3 INTO DATA(ls_carrier_ej3)
*             WITH KEY carrier_id = ls_booking_ej3-carrier_id.
*
*        out->write( |{ ls_carrier_ej3-name } - { ls_flight_ej3-connection_id } - { ls_flight_ej3-flight_date } - { ls_flight_ej3-plane_type_id } - Booking { ls_booking_ej3-booking_id }| ).
*
*      ENDLOOP.
*    ELSE.
*      out->write( |Ejercicio 3 - WHERE - Sin resultados| ).
*    ENDIF.

  ENDMETHOD.
ENDCLASS.
