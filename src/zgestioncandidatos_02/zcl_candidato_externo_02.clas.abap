CLASS zcl_candidato_externo_02 DEFINITION
  PUBLIC
  INHERITING FROM zcl_candidato_02
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA num_certificaciones TYPE i.
    METHODS calcular_idoneidad REDEFINITION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_candidato_externo_02 IMPLEMENTATION.

  METHOD calcular_idoneidad.
    " Tope 10.
    rv_idoneidad = ( me->anios_experiencia * '0.3' ) + ( me->num_certificaciones * '1.5' ).
    IF rv_idoneidad > 10.
      rv_idoneidad = 10.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

