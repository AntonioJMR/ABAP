CLASS zcl_validar_candidato_02 DEFINITION

  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

ENDCLASS.


CLASS zcl_validar_candidato_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA lv_edad        TYPE i VALUE 28.
    DATA lv_experiencia TYPE i VALUE 4.
    DATA lv_puntuacion  TYPE i VALUE 8.



    "Validar candidato mediante XSDBOOL = convertir directamente una condición en un booleano ABAP, es como un un if y valida un grupo condiciones
    DATA lv_apto TYPE abap_bool.

    lv_apto = xsdbool(
      lv_edad >= 18
      AND lv_experiencia >= 3
      AND lv_puntuacion >= 7
    ).

    out->write( lv_apto ).
    if lv_apto = abap_true.
      out->write( 'Apto' ).
    else.
      out->write( 'No apto' ).
    endif.

  ENDMETHOD.

ENDCLASS.
