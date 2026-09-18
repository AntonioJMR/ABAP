CLASS zcl_prestamo_biblioteca_02 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    "---- Estáticos: pertenecen a la biblioteca en general ----
    CLASS-DATA total_prestamos_realizados TYPE i. ""atributos de cla se estaticos
    CLASS-DATA prestamos_pendientes       TYPE i.  ""atributos de cla se estaticos

    CLASS-METHODS consultar_total_prestamos
      RETURNING
        VALUE(rv_total) TYPE i.

    CLASS-METHODS consultar_pendientes
      RETURNING
        VALUE(rv_pendientes) TYPE i.

    "---- De instancia: pertenecen a cada préstamo concreto ----
    METHODS constructor
      IMPORTING
        iv_socio  TYPE string ""atributos de clase estaticos
        iv_libro  TYPE string.

    METHODS marcar_devuelto.

    METHODS consultar_datos
      EXPORTING
        ev_socio    TYPE string
        ev_libro    TYPE string
        ev_devuelto TYPE abap_bool.

  PRIVATE SECTION.
    DATA mv_socio    TYPE string.
    DATA mv_libro    TYPE string.
    DATA mv_devuelto TYPE abap_bool.

ENDCLASS.



CLASS ZCL_PRESTAMO_BIBLIOTECA_02 IMPLEMENTATION.


  METHOD consultar_total_prestamos.
    rv_total = total_prestamos_realizados.
  ENDMETHOD.


  METHOD consultar_pendientes.
    rv_pendientes = prestamos_pendientes.
  ENDMETHOD.


  METHOD constructor.
    mv_socio    = iv_socio.
    mv_libro    = iv_libro.
    mv_devuelto = abap_false.

    " Se crea un préstamo nuevo -> sube el histórico y sube el pendiente
    total_prestamos_realizados = total_prestamos_realizados + 1.
    prestamos_pendientes       = prestamos_pendientes + 1.
  ENDMETHOD.


  METHOD marcar_devuelto.
    " Solo restamos si antes NO estaba ya devuelto (evita restar dos veces)
    IF mv_devuelto = abap_false.
      mv_devuelto = abap_true.
      prestamos_pendientes = prestamos_pendientes - 1.
    ENDIF.
  ENDMETHOD.


  METHOD consultar_datos.
    ev_socio    = mv_socio.
    ev_libro    = mv_libro.
    ev_devuelto = mv_devuelto.
  ENDMETHOD.
ENDCLASS.
