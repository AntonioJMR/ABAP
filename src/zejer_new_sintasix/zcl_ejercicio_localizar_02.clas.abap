CLASS zcl_ejercicio_localizar_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
ENDCLASS.

CLASS zcl_ejercicio_localizar_02 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF ty_candidato,
             id         TYPE i,
             nombre     TYPE string,
             puntuacion TYPE i,
           END OF ty_candidato,
           tt_candidatos TYPE STANDARD TABLE OF ty_candidato WITH EMPTY KEY.


    DATA(lt_candidatos) = VALUE tt_candidatos(
      ( id = 10 nombre = 'Ana'    puntuacion = 7 )
      ( id = 20 nombre = 'Carlos' puntuacion = 5 )
      ( id = 30 nombre = 'Marta'  puntuacion = 9 )
      ( id = 40 nombre = 'Juan'   puntuacion = 8 )
    ).

    out->write( '=== LOCALIZACION DE CANDIDATOS con line_index() ===' ).

    " Buscar posicion con id = 30 usando line_index( )
    DATA(lv_posicion_marta) = line_index( lt_candidatos[ id = 30 ] ).
    out->write( |Marta (ID 30) se encuentra en la posicion: { lv_posicion_marta }| ).


    " id = 99 devolvera 0 pq no lo encuentra
    DATA(lv_posicion_inexistente) = line_index( lt_candidatos[ id = 99 ] ).
    out->write( |Posicion del candidato con ID 99 es: { lv_posicion_inexistente }| ).

    " Si el registro no se encuentra, line_index() devuelve un 0, sin lanzar un DUMP
    IF lv_posicion_inexistente = 0.
      out->write( 'Candidato no encontrado' ).
    ELSE.
      out->write( |Candidato encontrado en la posicion: { lv_posicion_inexistente }| ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.

