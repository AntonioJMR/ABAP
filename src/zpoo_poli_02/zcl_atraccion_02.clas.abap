CLASS zcl_atraccion_02 DEFINITION PUBLIC CREATE PUBLIC.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        iv_nombre TYPE string.

    METHODS recibir_visitante.

    METHODS calcular_precio_entrada
      RETURNING
        VALUE(rv_precio) TYPE zdecimals2.

    METHODS consultar_visitantes
      RETURNING
        VALUE(rv_visitantes) TYPE i.

  PROTECTED SECTION.
    DATA: mv_nombre         TYPE string,
          mv_visitantes_hoy TYPE i.
ENDCLASS.

CLASS zcl_atraccion_02 IMPLEMENTATION.
  METHOD constructor.
    mv_nombre         = iv_nombre.
    mv_visitantes_hoy = 0.
  ENDMETHOD.

  METHOD recibir_visitante.
    mv_visitantes_hoy = mv_visitantes_hoy + 1.
  ENDMETHOD.

  METHOD calcular_precio_entrada.
    rv_precio = 0.
  ENDMETHOD.

  METHOD consultar_visitantes.
    rv_visitantes = mv_visitantes_hoy.
  ENDMETHOD.
ENDCLASS.
