CLASS zcl_habitacion_suite_02 DEFINITION PUBLIC FINAL CREATE PUBLIC
  INHERITING FROM zcl_habitacion_02.

  PUBLIC SECTION.

    INTERFACES zif_describible_02.

    METHODS constructor
      IMPORTING
        iv_numero_habitacion TYPE string
        iv_precio_noche      TYPE zdecimals2
        iv_incluye_jacuzzi   TYPE abap_bool.

    METHODS calcular_precio_total REDEFINITION.

  PRIVATE SECTION.

    DATA incluye_jacuzzi TYPE abap_bool.

ENDCLASS.


CLASS zcl_habitacion_suite_02 IMPLEMENTATION.

  METHOD constructor.
    super->constructor(
      iv_numero_habitacion = iv_numero_habitacion
      iv_precio_noche      = iv_precio_noche
    ).
    incluye_jacuzzi = iv_incluye_jacuzzi.
  ENDMETHOD.

  METHOD calcular_precio_total.
    resultado = super->calcular_precio_total( iv_numero_noches = iv_numero_noches ) * '1.8'.

    IF incluye_jacuzzi = abap_true.
      resultado = resultado + '25.00'.
    ENDIF.
  ENDMETHOD.

  METHOD zif_describible_02~describir.
    IF incluye_jacuzzi = abap_true.
      resultado = |Habitacion { numero_habitacion } (Suite) - Incluye jacuzzi|.
    ELSE.
      resultado = |Habitacion { numero_habitacion } (Suite) - Sin jacuzzi|.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
