CLASS zcl_test_practica_3_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

ENDCLASS.



CLASS zcl_test_practica_3_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(lo_manager) = NEW zcl_flight_manager_02( ).


    "==========================================================
    " 1. Añadir 5 vuelos
    "==========================================================

    TRY.

        lo_manager->zif_flight_manager_02~add_flight(
          VALUE #(
            airline     = 'LH'
            flight_num  = '0400'
            origin      = 'FRA'
            destination = 'JFK'
            price       = '899.00'
          )
        ).

        lo_manager->zif_flight_manager_02~add_flight(
          VALUE #(
            airline     = 'IB'
            flight_num  = '3740'
            origin      = 'MAD'
            destination = 'BCN'
            price       = '120.00'
          )
        ).

        lo_manager->zif_flight_manager_02~add_flight(
          VALUE #(
            airline     = 'AA'
            flight_num  = '0017'
            origin      = 'JFK'
            destination = 'SFO'
            price       = '450.50'
          )
        ).

        lo_manager->zif_flight_manager_02~add_flight(
          VALUE #(
            airline     = 'LH'
            flight_num  = '0455'
            origin      = 'FRA'
            destination = 'MAD'
            price       = '310.75'
          )
        ).

        lo_manager->zif_flight_manager_02~add_flight(
          VALUE #(
            airline     = 'SQ'
            flight_num  = '0026'
            origin      = 'SIN'
            destination = 'FRA'
            price       = '1250.00'
          )
        ).

      CATCH zcx_flight_error_02 INTO DATA(lx_error).

        out->write(
          |Error al añadir vuelo: { lx_error->message }|
        ).

    ENDTRY.


    "==========================================================
    " 2. Mostrar vuelos de LH
    "==========================================================

    out->write( '--- Vuelos de LH ---' ).

    DATA(lt_lh_flights) =
      lo_manager->zif_flight_manager_02~get_flights_by_airline(
        'LH'
      ).

    LOOP AT lt_lh_flights INTO DATA(ls_lh).

      out->write(
        |{ ls_lh-airline }-{ ls_lh-flight_num } |
        && |{ ls_lh-origin } -> { ls_lh-destination } |
        && |{ ls_lh-price } €|
      ).

    ENDLOOP.


    "==========================================================
    " 3. Intentar añadir precio negativo
    "==========================================================

    out->write( '--- Prueba precio negativo ---' ).

    TRY.

        lo_manager->zif_flight_manager_02~add_flight(
          VALUE #(
            airline     = 'XX'
            flight_num  = '9999'
            origin      = 'MAD'
            destination = 'LON'
            price       = '-100.00'
          )
        ).

      CATCH zcx_flight_error_02 INTO lx_error.

        out->write(
          |ERROR CAPTURADO: { lx_error->message }|
        ).

    ENDTRY.


    "==========================================================
    " 4. Intentar añadir vuelo duplicado
    "==========================================================

    out->write( '--- Prueba vuelo duplicado ---' ).

    TRY.

        lo_manager->zif_flight_manager_02~add_flight(
          VALUE #(
            airline     = 'LH'
            flight_num  = '0400'
            origin      = 'FRA'
            destination = 'JFK'
            price       = '899.00'
          )
        ).

      CATCH zcx_flight_error_02 INTO lx_error.

        out->write(
          |ERROR CAPTURADO: { lx_error->message }|
        ).

    ENDTRY.


    "==========================================================
    " 5. Obtener vuelo más barato
    "==========================================================

    out->write( '--- Vuelo más barato ---' ).

    DATA(ls_cheapest) =
      lo_manager->zif_flight_manager_02~get_cheapest_flight( ).

    out->write(
      |{ ls_cheapest-airline }-{ ls_cheapest-flight_num } |
      && |{ ls_cheapest-origin } -> { ls_cheapest-destination } |
      && |{ ls_cheapest-price } €|
    ).


    "==========================================================
    " 6. Facturación total
    "==========================================================

    out->write( '--- Facturación total ---' ).

    DATA(lv_total) =
      lo_manager->zif_flight_manager_02~get_total_revenue( ).

    out->write(
      |Facturación total: { lv_total } €|
    ).

  ENDMETHOD.

ENDCLASS.
