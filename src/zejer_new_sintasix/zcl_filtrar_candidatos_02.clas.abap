CLASS zcl_filtrar_candidatos_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

ENDCLASS.


CLASS zcl_filtrar_candidatos_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.


    TYPES: BEGIN OF ty_candidato,
             id         TYPE i,
             nombre     TYPE string,
             puntuacion TYPE i,
           END OF ty_candidato.


    "SORTED Ordenada por puntuacionNON-UNIQUE porque puede haber varias personas con la misma puntuacion

    TYPES tt_candidatos TYPE SORTED TABLE OF ty_candidato
                        WITH NON-UNIQUE KEY puntuacion.


    DATA(lt_candidatos) = VALUE tt_candidatos(
      ( id = 1 nombre = 'Ana'    puntuacion = 8  )
      ( id = 2 nombre = 'Carlos' puntuacion = 5  )
      ( id = 3 nombre = 'Marta'  puntuacion = 9  )
      ( id = 4 nombre = 'Juan'   puntuacion = 6  )
      ( id = 5 nombre = 'Lucía'  puntuacion = 10 )
    ).

    out->write( 'TODOS LOS CANDIDATOS' ).
    out->write( lt_candidatos ).

    "------------------------------------------------------------
    " EJERCICIO 1
    " Filtrar candidatos con puntuacion >= 8
    "------------------------------------------------------------
    DATA(lt_aprobados) = FILTER #(
      lt_candidatos
      WHERE puntuacion >= 8
    ).

    out->write( ' ---- CANDIDATOS CON PUNTUACION >= 8 ----' ).
    out->write( lt_aprobados ).

    "------------------------------------------------------------
    " RETO:
    " Filtrar candidatos con puntuacion < 8
    "
    " EXCEPT elimina los que cumplen puntuacion >= 8 y nos deja los menores de 8
    "------------------------------------------------------------
    DATA(lt_no_aprobados) = FILTER #(
      lt_candidatos
      EXCEPT WHERE puntuacion >= 8
    ).
    out->write( 'RETO: CANDIDATOS CON PUNTUACION < 8' ).
    out->write( lt_no_aprobados ).

  ENDMETHOD.

ENDCLASS.
