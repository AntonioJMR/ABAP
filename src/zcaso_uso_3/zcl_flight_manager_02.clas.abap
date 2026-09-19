CLASS zcl_flight_manager_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES zif_flight_manager_02.

    METHODS constructor.

  PRIVATE SECTION.

    DATA mt_flights TYPE zif_flight_manager_02=>tt_flights.

ENDCLASS.


CLASS zcl_flight_manager_02 IMPLEMENTATION.


  METHOD constructor.

    CLEAR mt_flights.

  ENDMETHOD.


  METHOD zif_flight_manager_02~add_flight.

    "------------------------------------------------------------
    " Comprobar que el precio sea positivo
    "------------------------------------------------------------
    IF is_flight-price <= 0.

      RAISE EXCEPTION NEW zcx_flight_error_02(
        iv_message = 'El precio del vuelo debe ser positivo'
      ).

    ENDIF.


    "------------------------------------------------------------
    " READ TABLE ... TRANSPORTING NO FIELDS: solo comprobamos
    " existencia, sin traer datos a memoria. Con tabla SORTED
    " esto usa búsqueda binaria automáticamente.
    "------------------------------------------------------------
    READ TABLE mt_flights TRANSPORTING NO FIELDS
      WITH KEY airline    = is_flight-airline
               flight_num = is_flight-flight_num.

    IF sy-subrc = 0.

      RAISE EXCEPTION NEW zcx_flight_error_02(
        iv_message = 'El vuelo ya existe'
      ).

    ENDIF.


    "------------------------------------------------------------
    " INSERT INTO TABLE: para tablas SORTED se usa INSERT
    " (no APPEND), ABAP coloca la línea en su posición correcta
    " según la clave.
    "------------------------------------------------------------
    INSERT is_flight INTO TABLE mt_flights.

  ENDMETHOD.


  METHOD zif_flight_manager_02~get_flights_by_airline.

    "------------------------------------------------------------
    " FILTER: al ser 'airline' el primer campo de la clave de
    " la tabla SORTED, ABAP puede filtrar de forma eficiente.
    "------------------------------------------------------------
    rt_flights = FILTER #(
      mt_flights
      WHERE airline = iv_airline
    ).

  ENDMETHOD.


  METHOD zif_flight_manager_02~get_cheapest_flight.

    IF mt_flights IS INITIAL.
      RETURN.
    ENDIF.

    "------------------------------------------------------------
    " REDUCE: agregación funcional recorriendo con FOR
    "------------------------------------------------------------
    rs_flight = REDUCE #(
      INIT cheapest = mt_flights[ 1 ]
      FOR flight IN mt_flights
      NEXT cheapest = COND #(
        WHEN flight-price < cheapest-price
        THEN flight
        ELSE cheapest
      )
    ).

  ENDMETHOD.


  METHOD zif_flight_manager_02~get_total_revenue.

    "------------------------------------------------------------
    " REDUCE para sumar todos los precios
    "------------------------------------------------------------
    rv_total = REDUCE #(
      INIT total = CONV decfloat34( 0 )
      FOR flight IN mt_flights
      NEXT total = total + flight-price
    ).

  ENDMETHOD.


  METHOD zif_flight_manager_02~delete_flight.

    "------------------------------------------------------------
    " Comprobamos existencia con REFERENCE INTO (obtenemos
    " un puntero a la línea sin copiarla)
    "------------------------------------------------------------
    READ TABLE mt_flights REFERENCE INTO DATA(lr_flight)
      WITH KEY airline    = iv_airline
               flight_num = iv_flight_num.

    IF sy-subrc <> 0.

      RAISE EXCEPTION NEW zcx_flight_error_02(
        iv_message = 'El vuelo no existe'
      ).

    ENDIF.

    "------------------------------------------------------------
    " DELETE usando la misma clave
    "------------------------------------------------------------
    DELETE mt_flights
      WHERE airline    = iv_airline
        AND flight_num = iv_flight_num.

  ENDMETHOD.


  METHOD zif_flight_manager_02~update_price.

    IF iv_new_price <= 0.

      RAISE EXCEPTION NEW zcx_flight_error_02(
        iv_message = 'El precio del vuelo debe ser positivo'
      ).

    ENDIF.

    "------------------------------------------------------------
    " READ TABLE ... INTO (copia la línea a una work area)
    " para validar antes de modificar
    "------------------------------------------------------------
    READ TABLE mt_flights INTO DATA(ls_flight)
      WITH KEY airline    = iv_airline
               flight_num = iv_flight_num.

    IF sy-subrc <> 0.

      RAISE EXCEPTION NEW zcx_flight_error_02(
        iv_message = 'El vuelo no existe'
      ).

    ENDIF.

    "------------------------------------------------------------
    " MODIFY: actualiza la línea identificada por la clave
    "------------------------------------------------------------
    ls_flight-price = iv_new_price.

    MODIFY TABLE mt_flights FROM ls_flight.

  ENDMETHOD.


  METHOD zif_flight_manager_02~get_revenue_by_airline.

    "------------------------------------------------------------
    " GROUP BY: agrupamos los vuelos por aerolínea y calculamos
    " facturación total y número de vuelos por grupo.
    "------------------------------------------------------------
    rt_revenue = VALUE #(
      FOR GROUPS <group_key> OF <flight> IN mt_flights
        GROUP BY <flight>-airline
        ( airline       = <group_key>
          num_flights   = REDUCE i(
                             INIT n = 0
                             FOR <f> IN GROUP <group_key>
                             NEXT n = n + 1 )
          total_revenue = REDUCE decfloat34(
                             INIT sum = 0
                             FOR <f> IN GROUP <group_key>
                             NEXT sum = sum + <f>-price ) )
    ).

  ENDMETHOD.


ENDCLASS.
