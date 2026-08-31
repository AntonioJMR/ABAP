CLASS zcl_ejercicio_seleccion_02 DEFINITION

  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
ENDCLASS.

CLASS zcl_ejercicio_seleccion_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF ty_candidato,
             id         TYPE i,
             nombre     TYPE string,
             puntuacion TYPE i,
           END OF ty_candidato,
           tt_candidatos TYPE STANDARD TABLE OF ty_candidato WITH EMPTY KEY.

    " destino
    TYPES: BEGIN OF ty_seleccionado,
             nombre     TYPE string,
             puntuacion TYPE i,
           END OF ty_seleccionado,
           tt_seleccionados TYPE STANDARD TABLE OF ty_seleccionado WITH EMPTY KEY.

    "ini origen
    DATA(lt_candidatos) = VALUE tt_candidatos(
      ( id = 1 nombre = 'Ana'    puntuacion = 8 )
      ( id = 2 nombre = 'Carlos' puntuacion = 5 )
      ( id = 3 nombre = 'Marta'  puntuacion = 9 )
      ( id = 4 nombre = 'Juan'   puntuacion = 6 )
      ( id = 5 nombre = 'Lucía'  puntuacion = 10 )
    ).

    "Crea la tabla local usando FOR ... IN (Sin LOOP ni APPEND) filtra con where
    DATA(lt_seleccionados) = VALUE tt_seleccionados(
      FOR ls_cand IN lt_candidatos
        WHERE ( puntuacion >= 8 ) (
            nombre     = ls_cand-nombre
            puntuacion = ls_cand-puntuacion
      )
    ).


    out->write( '=== CANDIDATOS puntuacion >= 8 ===' ).
    out->write( lt_seleccionados ).

  ENDMETHOD.
ENDCLASS.


