CLASS zcl_habitacion_estandar_02 DEFINITION PUBLIC FINAL CREATE PUBLIC
  INHERITING FROM zcl_habitacion_02.

  PUBLIC SECTION.

    INTERFACES zif_describible_02.

    METHODS constructor
      IMPORTING
        iv_numero_habitacion TYPE string
        iv_precio_noche      TYPE zdecimals2
        iv_tiene_vistas_mar  TYPE abap_bool.

    METHODS calcular_precio_total REDEFINITION.

  PRIVATE SECTION.

    DATA tiene_vistas_mar TYPE abap_bool.

ENDCLASS.


CLASS zcl_habitacion_estandar_02 IMPLEMENTATION.

  METHOD constructor.
    super->constructor(
      iv_numero_habitacion = iv_numero_habitacion
      iv_precio_noche      = iv_precio_noche
    ).
    tiene_vistas_mar = iv_tiene_vistas_mar.
  ENDMETHOD.

  METHOD calcular_precio_total.
    resultado = super->calcular_precio_total( iv_numero_noches = iv_numero_noches ).

    IF tiene_vistas_mar = abap_true.
      resultado = resultado + '15.00'.
    ENDIF.
  ENDMETHOD.

  METHOD zif_describible_02~describir.
    IF tiene_vistas_mar = abap_true.
      resultado = |Habitacion { numero_habitacion } (Estandar) - Con vistas al mar|.
    ELSE.
      resultado = |Habitacion { numero_habitacion } (Estandar) - Sin vistas al mar|.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
