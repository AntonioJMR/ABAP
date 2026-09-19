INTERFACE zif_flight_manager_02
  PUBLIC.

  TYPES:
    BEGIN OF ty_flight,
      airline      TYPE c LENGTH 2,
      flight_num   TYPE n LENGTH 4,
      origin       TYPE c LENGTH 3,
      destination  TYPE c LENGTH 3,
      price        TYPE p LENGTH 8 DECIMALS 2,
    END OF ty_flight.

TYPES tt_flights TYPE SORTED TABLE OF ty_flight
  WITH NON-UNIQUE KEY airline flight_num.

  TYPES ty_total TYPE p LENGTH 10 DECIMALS 2.

  METHODS add_flight
    IMPORTING
      is_flight TYPE ty_flight
    RAISING
      zcx_flight_error_02.

  METHODS get_flights_by_airline
    IMPORTING
      iv_airline TYPE ty_flight-airline
    RETURNING
      VALUE(rt_flights) TYPE tt_flights.

  METHODS get_cheapest_flight
    RETURNING
      VALUE(rs_flight) TYPE ty_flight.

  METHODS get_total_revenue
    RETURNING
      VALUE(rv_total) TYPE ty_total.

ENDINTERFACE.
