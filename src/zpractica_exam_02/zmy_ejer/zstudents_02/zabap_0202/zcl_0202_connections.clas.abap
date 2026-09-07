CLASS zcl_0202_connections DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .

    METHODS get_connections
        IMPORTING
            i_departure  type /dmo/airport_from_id
        RETURNING
          VALUE(r_connections) TYPE zcert_connections.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_0202_connections IMPLEMENTATION.

  METHOD get_connections.

    "----------------------------------------------------------
    " 1. Vuelos directos
    "----------------------------------------------------------

    SELECT
      carrier_id,
      airport_from_id,
      airport_to_id,
      '-' AS airport_via_id
      FROM /dmo/connection
      WHERE airport_from_id = @i_departure
      INTO CORRESPONDING FIELDS OF TABLE @r_connections.


    "----------------------------------------------------------
    " 2. Vuelos con una escala
    "----------------------------------------------------------

    SELECT
      first~carrier_id,
      first~airport_from_id,
      second~airport_to_id,
      first~airport_to_id AS airport_via_id
      FROM /dmo/connection AS first
      INNER JOIN /dmo/connection AS second
        ON  second~carrier_id      = first~carrier_id
        AND second~airport_from_id = first~airport_to_id
      WHERE first~airport_from_id = @i_departure
        AND second~airport_to_id  <> @i_departure
      APPENDING CORRESPONDING FIELDS OF TABLE @r_connections.



**      SELECT
**          first~carrier_id,
**          first~airport_from_id,
**          CASE
**            WHEN second~airport_to_id IS NULL
**              THEN first~airport_to_id
**            ELSE second~airport_to_id
**          END AS airport_to_id,
**          CASE
**            WHEN second~airport_to_id IS NULL
**              THEN ' '
**            ELSE first~airport_to_id
**          END AS airport_via_id
**
**          FROM /dmo/connection AS first
**
**          LEFT OUTER JOIN /dmo/connection AS second
**            ON  second~carrier_id     = first~carrier_id
**            AND second~airport_from_id = first~airport_to_id
**            AND second~airport_to_id  <> @i_departure
**
**          WHERE first~airport_from_id = @i_departure
**          INTO
**          CORRESPONDING
**            FIELDS OF TABLE @r_connections.

  ENDMETHOD.



  METHOD if_oo_adt_classrun~main.

    DATA(lt_connections) = get_connections(
        i_departure = 'SIN'
    ).
    out->write( lt_connections ).

  ENDMETHOD.

ENDCLASS.
