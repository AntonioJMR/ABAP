CLASS zcl_candidato_interno_02 DEFINITION
  PUBLIC
  INHERITING FROM zcl_candidato_02
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS calcular_idoneidad REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_candidato_interno_02 IMPLEMENTATION.

  METHOD calcular_idoneidad.
    "Tope max 10.
    rv_idoneidad = ( me->anios_experiencia * '0.6' ) + ( 5 * '0.4' ).
    IF rv_idoneidad > 10.
      rv_idoneidad = 10.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

