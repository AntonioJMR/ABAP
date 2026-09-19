CLASS zcl_total_puntuaciones_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

ENDCLASS.


CLASS zcl_total_puntuaciones_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.


    TYPES: BEGIN OF ty_candidato,
             id         TYPE i,
             nombre     TYPE string,
             puntuacion TYPE i,
           END OF ty_candidato.


    " tabla interna
    TYPES tt_candidatos TYPE STANDARD TABLE OF ty_candidato
                        WITH EMPTY KEY.


    " Crear tabla
    DATA(lt_candidatos) = VALUE tt_candidatos(
      ( id = 1 nombre = 'Ana'    puntuacion = 8  )
      ( id = 2 nombre = 'Carlos' puntuacion = 5  )
      ( id = 3 nombre = 'Marta'  puntuacion = 9  )
      ( id = 4 nombre = 'Juan'   puntuacion = 6  )
      ( id = 5 nombre = 'Lucía'  puntuacion = 10 )
    ).


    " REDUCE sumar todas puntuaciones

    DATA(lv_total) = REDUCE i(
      INIT suma = 0
        FOR candidato IN lt_candidatos
            NEXT suma = suma + candidato-puntuacion
    ).

    out->write( 'TOTAL DE PUNTUACIONES' ).
    out->write( lv_total ).


    " RETO -- REDUCE solamente para puntuaciones >= 8

    DATA(lv_total_aprobados) = REDUCE i(
      INIT suma = 0
      FOR candidato IN lt_candidatos
          WHERE ( puntuacion >= 8 )
          NEXT suma = suma + candidato-puntuacion
    ).
    out->write( 'RETO:  TOTAL DE PUNTUACIONES >= 8' ).
    out->write( lv_total_aprobados ).

  ENDMETHOD.

ENDCLASS.
