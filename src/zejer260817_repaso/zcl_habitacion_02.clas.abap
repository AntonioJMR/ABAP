CLASS zcl_habitacion_02 DEFINITION PUBLIC ABSTRACT CREATE PUBLIC.

  PUBLIC SECTION.

    TYPES tt_habitaciones TYPE STANDARD TABLE OF REF TO zcl_habitacion_02 WITH EMPTY KEY.

    CLASS-DATA total_habitaciones_creadas TYPE i.

    CLASS-METHODS consultar_total_habitaciones
      RETURNING VALUE(resultado) TYPE i.

    METHODS constructor
      IMPORTING
        iv_numero_habitacion TYPE string
        iv_precio_noche      TYPE zdecimals2.

    METHODS calcular_precio_total
      IMPORTING
        iv_numero_noches TYPE i
      RETURNING
        VALUE(resultado) TYPE zdecimals2.

    METHODS registrar_reserva.

    METHODS consultar_veces_reservada
      RETURNING VALUE(resultado) TYPE i.

  PROTECTED SECTION.

    DATA numero_habitacion TYPE string.
    DATA precio_noche      TYPE p LENGTH 8 DECIMALS 2.

  PRIVATE SECTION.

    DATA veces_reservada TYPE i.

ENDCLASS.


CLASS zcl_habitacion_02 IMPLEMENTATION.

  METHOD consultar_total_habitaciones.
    resultado = total_habitaciones_creadas.
  ENDMETHOD.

  METHOD constructor.
    numero_habitacion = iv_numero_habitacion.
    precio_noche      = iv_precio_noche.
    veces_reservada   = 0.
    total_habitaciones_creadas = total_habitaciones_creadas + 1.
  ENDMETHOD.

  METHOD calcular_precio_total.
    resultado = precio_noche * iv_numero_noches.
  ENDMETHOD.

  METHOD registrar_reserva.
    veces_reservada = veces_reservada + 1.
  ENDMETHOD.

  METHOD consultar_veces_reservada.
    resultado = veces_reservada.
  ENDMETHOD.

ENDCLASS.
