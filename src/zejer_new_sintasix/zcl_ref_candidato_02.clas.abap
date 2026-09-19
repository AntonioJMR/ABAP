CLASS zcl_ref_candidato_02 DEFINITION


  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

ENDCLASS.


CLASS zcl_ref_candidato_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF ty_candidato,
             id         TYPE i,
             nombre     TYPE string,
             puntuacion TYPE i,
           END OF ty_candidato.

    DATA(ls_candidato) = VALUE ty_candidato(
      id         = 1
      nombre     = 'Ana'
      puntuacion = 7
    ).


    " Mostrar la estructura original
    out->write( 'CANDIDATO' ).
    out->write( ls_candidato ).
    out->write( 'Puntuación ANTES de modificar mediante REF:' ).
    out->write( ls_candidato-puntuacion ).

    " Crear una referencia a la estructura REF no copia la estructura. Es un puntero.
    DATA(lr_candidato) = REF #( ls_candidato ).
    " Modificar la estructura a través de la referencia
    lr_candidato->puntuacion = 9.


    " Mostrar la estructura original Modifi
    out->write( 'CANDIDATO mod' ).
    out->write( ls_candidato ).
    " Mostrar la puntuación original
    out->write( 'Puntuación después de modificar mediante REF:' ).
    out->write( ls_candidato-puntuacion ).


    "------------------------------------------------------------
    " RETO
    out->write( '=================== RETO =====================' ).

    TYPES tt_candidatos TYPE STANDARD TABLE OF ty_candidato
                        WITH EMPTY KEY.


    DATA(lt_candidatos) = VALUE tt_candidatos(
      ( id = 1 nombre = 'Ana'    puntuacion = 7  )
      ( id = 2 nombre = 'Carlos' puntuacion = 5  )
      ( id = 3 nombre = 'Marta'  puntuacion = 9  )
      ( id = 4 nombre = 'Juan'   puntuacion = 6  )
      ( id = 5 nombre = 'Lucía'  puntuacion = 10 )
    ).


    " Obtener referencia directamente al candidato con ID = 2
    DATA(lr_candidato_2) = REF #( lt_candidatos[ id = 2 ] ).



    " Modificar mediante la referencia
    lr_candidato_2->puntuacion = 9.


    out->write( 'TABLA DESPUÉS DE MODIFICAR ID = 2' ).
    out->write( lt_candidatos ).

  ENDMETHOD.

ENDCLASS.
