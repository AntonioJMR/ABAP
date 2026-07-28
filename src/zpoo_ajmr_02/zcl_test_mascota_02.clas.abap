CLASS zcl_test_mascota_02 DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS zcl_test_mascota_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(lo_mascota) = NEW zcl_mascota_02( ).

    DATA: lv_hambre  TYPE i,
          lv_energia TYPE i.

    DO 5 TIMES.
      lo_mascota->jugar( ).
      lo_mascota->consultar_estado(
        IMPORTING
          ev_hambre  = lv_hambre
          ev_energia = lv_energia
      ).
      out->write( |Tras jugar (vuelta { sy-index }): Hambre = { lv_hambre } - Energia = { lv_energia }| ).
    ENDDO.

    lo_mascota->comer( ).
    lo_mascota->consultar_estado(
      IMPORTING
        ev_hambre  = lv_hambre
        ev_energia = lv_energia
    ).
    out->write( |Tras comer: Hambre = { lv_hambre } - Energia = { lv_energia }| ).

  ENDMETHOD.

ENDCLASS.
