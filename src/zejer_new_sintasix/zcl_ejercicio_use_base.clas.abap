CLASS zcl_ejercicio_use_base DEFINITION

  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
ENDCLASS.

CLASS zcl_ejercicio_use_base IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    "DEFINICIÓN DE TIPOS Y ESTRUCTURAS
    TYPES: BEGIN OF ty_candidato,
             id          TYPE i,
             nombre      TYPE string,
             experiencia TYPE i,
             salario     TYPE i,
             ciudad      TYPE string,
           END OF ty_candidato,
           tt_candidatos TYPE STANDARD TABLE OF ty_candidato WITH EMPTY KEY.

    "CREACIÓN DEL CANDIDATO INICIAL (Uso de VALUE)
    DATA(ls_candidato) = VALUE ty_candidato( id          = 1
                                             nombre      = 'Ana'
                                             experiencia = 4
                                             salario     = 28000
                                             ciudad      = 'Sevilla' ).

    "ACTUALIZACIÓN USANDO BASE (Estructuras)
    " Tomamos como cimiento 'ls_candidato' y modificamos únicamente los campos solicitados
    DATA(ls_candidato_actualizado) = VALUE ty_candidato(
            BASE ls_candidato
            experiencia = 5
            salario     = 30000 ).


    out->write( '--- ESTRUCTURA ORIGINAL ---' ).
    out->write( ls_candidato ).
    out->write( '--- ESTRUCTURA ACTUALIZADA (CON BASE) ---' ).
    out->write( ls_candidato_actualizado ).

    "----------------------------------
out->write( '==================================================' ).
    out->write( '         RETO ADICIONAL: BASE EN TABLAS           ' ).
    out->write( '==================================================' ).


    DATA(lt_candidatos_inicial) = VALUE tt_candidatos(
      ( id = 1 nombre = 'Ana'    experiencia = 4 salario = 28000 ciudad = 'Sevilla' )
      ( id = 2 nombre = 'Carlos' experiencia = 6 salario = 35000 ciudad = 'Madrid' )
    ).


    " Copia el contenido previo de la tabla y tercer registro al final sin hacer APPEND
    DATA(lt_candidatos_extendida) = VALUE tt_candidatos(
        BASE lt_candidatos_inicial (
            id = 3
            nombre = 'Marta'
            experiencia = 2
            salario = 24000
            ciudad = 'Barcelona' )
    ).

    "la tabla inicial permanece intacta
    out->write( '--- TABLA INICIAL (2 Registros) ---' ).
    out->write( lt_candidatos_inicial ).
    out->write( '--- TABLA EXTENDIDA con BASE (3 Registros) ---' ).
    out->write( lt_candidatos_extendida ).



  ENDMETHOD.
ENDCLASS.


