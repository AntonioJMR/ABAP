CLASS zcl_taller_bicis_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS registrar_reparacion
      IMPORTING
        iv_cliente    TYPE zdb_tallebici_02-cliente
        iv_averia     TYPE zdb_tallebici_02-averia
      RETURNING
        VALUE(rv_id)  TYPE zdb_tallebici_02-id_reparacion.

    METHODS consultar_reparacion
      IMPORTING
        iv_id           TYPE zdb_tallebici_02-id_reparacion
      EXPORTING
        ev_cliente      TYPE zdb_tallebici_02-cliente
        ev_averia       TYPE zdb_tallebici_02-averia
        ev_estado       TYPE zdb_tallebici_02-estado
        ev_encontrado   TYPE abap_bool.

    METHODS cambiar_estado
      IMPORTING
        iv_id         TYPE  zdb_tallebici_02-id_reparacion
        iv_estado     TYPE  zdb_tallebici_02-estado
      RETURNING
        VALUE(rv_ok)  TYPE abap_bool.


    METHODS eliminar_reparacion
      IMPORTING
        iv_id         TYPE  zdb_tallebici_02-id_reparacion
      RETURNING
        VALUE(rv_ok)  TYPE abap_bool.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_taller_bicis_02 IMPLEMENTATION.

  METHOD registrar_reparacion.



    SELECT SINGLE MAX( id_reparacion )
      FROM zdb_tallebici_02
      INTO @data(lv_idMaxBBDD).

    IF sy-subrc = 0.
        rv_id = CONV zdb_tallebici_02-id_reparacion( lv_idMaxBBDD + 1 ).
    ELSE.
        rv_id = 1.
    ENDIF.


    INSERT zdb_tallebici_02
      FROM @( VALUE #(  client        = sy-mandt
                        id_reparacion = rv_id
                        cliente       = iv_cliente
                        averia        = iv_averia
                        estado        = 'PENDIENTE' ) ).

  ENDMETHOD.


  METHOD consultar_reparacion.

    SELECT SINGLE cliente, averia, estado
      FROM zdb_tallebici_02
      WHERE id_reparacion = @iv_id
      INTO ( @ev_cliente, @ev_averia, @ev_estado ).

    IF sy-subrc = 0.
      ev_encontrado = abap_true.
    ELSE.
      ev_encontrado = abap_false.
      CLEAR: ev_cliente, ev_averia, ev_estado.
    ENDIF.

  ENDMETHOD.


  METHOD cambiar_estado.

    UPDATE zdb_tallebici_02
       SET estado = @iv_estado
     WHERE id_reparacion = @iv_id.

    IF sy-subrc = 0.
      rv_ok = abap_true.
    ELSE.
      rv_ok = abap_false.
    ENDIF.

  ENDMETHOD.


  METHOD eliminar_reparacion.

    DELETE FROM zdb_tallebici_02
     WHERE id_reparacion = @iv_id.

    IF sy-subrc = 0.
      rv_ok = abap_true.
    ELSE.
      rv_ok = abap_false.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
