CLASS zcl_alquiler_hamacas_02 DEFINITION
  PUBLIC
  INHERITING FROM zcl_chiringuito_02
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS calcular_comision_ayuntamiento REDEFINITION.

    METHODS reservar_sombrilla
      IMPORTING
        iv_numero_sombrilla TYPE i
      RETURNING
        VALUE(rv_mensaje) TYPE string.

ENDCLASS.


CLASS zcl_alquiler_hamacas_02 IMPLEMENTATION.

  METHOD calcular_comision_ayuntamiento.
    rv_comision = super->calcular_comision_ayuntamiento( ) * 2.
  ENDMETHOD.

  METHOD reservar_sombrilla.
    rv_mensaje =  |Sombrilla número { iv_numero_sombrilla } reservada.|.
  ENDMETHOD.

ENDCLASS.
