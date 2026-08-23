***&---------------------------------------------------------------------*
***& Enunciado — Reservas de una biblioteca
***&---------------------------------------------------------------------*
***& Misma mecánica que el museo (sin herencia): atributos/métodos de
***& instancia junto a atributos/métodos estáticos, para practicar la
***& diferencia con una temática nueva.
***&
***& Contexto
***& --------
***& Cada vez que un socio de la biblioteca reserva un libro, se genera
***& un préstamo individual (con sus propios datos). Pero la biblioteca,
***& además, quiere llevar dos contadores GLOBALES, compartidos por
***& todos los préstamos: cuántos libros se han prestado en total, y
***& cuántos de esos préstamos siguen sin devolverse.
***&
***& Lo que hay que construir
***& -------------------------
***& Clase ZCL_PRESTAMO_BIBLIOTECA_XX (sin herencia, sin padre ni hijos):
***&
***& Estáticos (pertenecen a la biblioteca en general, no a ningún
***& préstamo concreto):
***&   - CLASS-DATA total_prestamos_realizados (tipo I) — se incrementa
***&     cada vez que se crea un préstamo nuevo.
***&   - CLASS-DATA prestamos_pendientes (tipo I) — sube al crear un
***&     préstamo, y baja cuando se marca como devuelto.
***&   - Método estático consultar_total_prestamos, que devuelve
***&     (RETURNING) total_prestamos_realizados.
***&   - Método estático consultar_pendientes, que devuelve (RETURNING)
***&     prestamos_pendientes.
***&
***& De instancia (pertenecen a cada préstamo concreto):
***&   - Atributos privados: nombre del socio (string), título del libro
***&     (string), y si ya ha sido devuelto (abap_bool).
***&   - Constructor: recibe nombre del socio y título del libro. El
***&     estado de devuelto arranca en abap_false. Aquí es donde hay que
***&     tocar también los dos contadores estáticos (sumar 1 a cada uno).
***&   - Método marcar_devuelto: sin parámetros. Pone el atributo de
***&     devuelto a abap_true, y RESTA 1 a prestamos_pendientes (el
***&     estático) — pero solo si antes no estaba ya devuelto (para no
***&     restar dos veces por error si alguien llama al método dos
***&     veces).
***&   - Método consultar_datos: devuelve, por EXPORTING, el nombre del
***&     socio, el título y si está devuelto.
***&
***& Clase de test ZCL_TEST_PRESTAMOS_XX
***& ------------------------------------
***&   1. Antes de crear ningún préstamo, consultar y mostrar
***&      consultar_total_prestamos y consultar_pendientes (deberían
***&      salir ambos a 0).
***&   2. Crear 3 préstamos distintos (socios y libros diferentes).
***&   3. Mostrar los datos de uno de ellos en concreto, usando
***&      consultar_datos (acceso de instancia, con ->).
***&   4. Mostrar consultar_total_prestamos y consultar_pendientes
***&      (deberían salir ambos a 3, sin haber devuelto nada aún).
***&   5. Marcar como devuelto uno de los tres préstamos.
***&   6. Volver a mostrar consultar_total_prestamos (sigue en 3, nunca
***&      baja) y consultar_pendientes (ahora debería bajar a 2).
***&
***& Pista para no liarse
***& ---------------------
***& Fijaos bien en la diferencia entre los dos contadores:
***& total_prestamos_realizados SOLO SUBE, NUNCA BAJA (es un histórico
***& acumulado). prestamos_pendientes SUBE al crear y BAJA al devolver
***& (refleja el estado actual). Son dos comportamientos distintos
***& aunque los dos sean estáticos — no os confundáis actualizando los
***& dos igual dentro de marcar_devuelto.
***&---------------------------------------------------------------------*

CLASS zcl_test_prestamos_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

ENDCLASS.



CLASS ZCL_TEST_PRESTAMOS_02 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: lo_prestamo1 	TYPE REF TO zcl_prestamo_biblioteca_02,
          lo_prestamo2 	TYPE REF TO zcl_prestamo_biblioteca_02,
          lo_prestamo3 	TYPE REF TO zcl_prestamo_biblioteca_02,
          lv_total     	TYPE i,
          lv_pendientes TYPE i,
          lv_socio     	TYPE string,
          lv_libro     	TYPE string,
          lv_devuelto  	TYPE abap_bool.

    " ---- 1. Antes de crear nada, deben salir ambos a 0 ----
    lv_total      = zcl_prestamo_biblioteca_02=>consultar_total_prestamos( ).
    lv_pendientes = zcl_prestamo_biblioteca_02=>consultar_pendientes( ).
    out->write( |Antes de crear préstamos -> total: { lv_total }, pendientes: { lv_pendientes }| ).

    " ---- 2. Crear 3 préstamos distintos ----
    lo_prestamo1 = NEW zcl_prestamo_biblioteca_02(
                     iv_socio = 'Ana García'
                     iv_libro = 'Cien años de soledad' ).

    lo_prestamo2 = NEW zcl_prestamo_biblioteca_02(
                     iv_socio = 'Luis Martín'
                     iv_libro = 'El Quijote' ).

    lo_prestamo3 = NEW zcl_prestamo_biblioteca_02(
                     iv_socio = 'Marta Ruiz'
                     iv_libro = '1984' ).

    " ---- 3. Mostrar datos de uno de ellos (instancia, con ->) ----
    lo_prestamo1->consultar_datos(
      IMPORTING ev_socio    = lv_socio
                ev_libro    = lv_libro
                ev_devuelto = lv_devuelto ).

    out->write( |Préstamo 1 -> socio: { lv_socio }, libro: { lv_libro }, devuelto: { lv_devuelto }| ).

    " ---- 4. Mostrar total y pendientes (deben ser 3 y 3) ----
    lv_total      = zcl_prestamo_biblioteca_02=>consultar_total_prestamos( ).
    lv_pendientes = zcl_prestamo_biblioteca_02=>consultar_pendientes( ).
    out->write( |Tras crear 3 préstamos -> total: { lv_total }, pendientes: { lv_pendientes }| ).

    " ---- 5. Marcar uno como devuelto ----
    lo_prestamo2->marcar_devuelto( ).   ""modifica el atributo estatico quitandole valor -1

    " ---- 6. Mostrar total (sigue en 3) y pendientes (baja a 2) ----
    lv_total      = zcl_prestamo_biblioteca_02=>consultar_total_prestamos( ).
    lv_pendientes = zcl_prestamo_biblioteca_02=>consultar_pendientes( ).
    out->write( |Tras devolver 1 préstamo -> total: { lv_total }, pendientes: { lv_pendientes }| ).


  ENDMETHOD.
ENDCLASS.
