CLASS zcl_gestor_reservas_02 DEFINITION PUBLIC FINAL CREATE PRIVATE.

  PUBLIC SECTION.

    CLASS-METHODS crear_reserva
      IMPORTING
        iv_numero_habitacion TYPE char5
        iv_cliente           TYPE char40
      RETURNING
        VALUE(rv_id_reserva) TYPE char10.

    CLASS-METHODS consultar_reserva
      IMPORTING
        iv_id_reserva TYPE char10
      EXPORTING
        ev_numero_habitacion TYPE char5
        ev_cliente            TYPE char40
        ev_estado              TYPE char10
        ev_encontrado          TYPE abap_bool.

    CLASS-METHODS liberar_reserva
      IMPORTING
        iv_id_reserva TYPE char10
      RETURNING
        VALUE(resultado) TYPE abap_bool.

    CLASS-METHODS eliminar_reserva
      IMPORTING
        iv_id_reserva TYPE char10
      RETURNING
        VALUE(resultado) TYPE abap_bool.

ENDCLASS.


CLASS zcl_gestor_reservas_02 IMPLEMENTATION.

  METHOD crear_reserva.

    SELECT SINGLE FROM zreserva_02
      FIELDS MAX( id_reserva )
      INTO @DATA(lv_id_maximo).

    rv_id_reserva = lv_id_maximo + 1.

    DATA(ls_reserva) = VALUE zreserva_02(
      client             = sy-mandt
      id_reserva         = rv_id_reserva
      numero_habitacion  = iv_numero_habitacion
      cliente            = iv_cliente
      estado             = 'OCUPADA'
    ).

    INSERT zreserva_02 FROM @ls_reserva.

  ENDMETHOD.


  METHOD consultar_reserva.

    SELECT SINGLE FROM zreserva_02
      FIELDS numero_habitacion, cliente, estado
      WHERE id_reserva = @iv_id_reserva
      INTO ( @ev_numero_habitacion, @ev_cliente, @ev_estado ).

    ev_encontrado = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).

  ENDMETHOD.


  METHOD liberar_reserva.

    UPDATE zreserva_02
      SET estado = 'LIBERADA'
      WHERE id_reserva = @iv_id_reserva.

    resultado = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).

  ENDMETHOD.


  METHOD eliminar_reserva.

    DELETE FROM zreserva_02
      WHERE id_reserva = @iv_id_reserva.

    resultado = COND #( WHEN sy-subrc = 0 THEN abap_true ELSE abap_false ).

  ENDMETHOD.

ENDCLASS.
