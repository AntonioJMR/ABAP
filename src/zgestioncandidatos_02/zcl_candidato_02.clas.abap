CLASS zcl_candidato_02 DEFINITION

  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA: id                    TYPE i,
          nombre_completo       TYPE string,
          anios_experiencia     TYPE i,
          dni                   TYPE string,
          telefono_personal     TYPE string,
          salario_actual        TYPE p LENGTH 8 DECIMALS 2,
          salario_pretendido    TYPE p LENGTH 8 DECIMALS 2,
          puntuacion_entrevista TYPE i VALUE 0.

    METHODS:
      "No FINAL para permitir redefinición en subclases
      calcular_idoneidad RETURNING VALUE(rv_idoneidad) TYPE decfloat34,

      anadir_puntos_entrevista IMPORTING iv_puntos TYPE i,

      obtener_idoneidad_final RETURNING VALUE(rv_idoneidad_final) TYPE i,

      comparar_con IMPORTING io_otro TYPE REF TO zcl_candidato_02 RETURNING VALUE(rv_resultado) TYPE string,

      calcular_banda_salarial RETURNING VALUE(rv_banda) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_candidato_02 IMPLEMENTATION.

  METHOD calcular_idoneidad.
    " Implementación por default Tope: 10
    rv_idoneidad = me->anios_experiencia * '0.5'.
    IF rv_idoneidad > 10.
      rv_idoneidad = 10.
    ENDIF.
  ENDMETHOD.

  METHOD anadir_puntos_entrevista.
    me->puntuacion_entrevista = me->puntuacion_entrevista + iv_puntos.
  ENDMETHOD.

  METHOD obtener_idoneidad_final.
    " REQUISITO 2: ROUND  y llamada polimorfica con  (me->)
    rv_idoneidad_final = CONV i( ROUND( val = ( me->calcular_idoneidad( ) + ( me->puntuacion_entrevista / 10 ) ) dec = 0 ) ).
  ENDMETHOD.

  METHOD comparar_con.
    IF me->obtener_idoneidad_final( ) > io_otro->obtener_idoneidad_final( ).
      rv_resultado = me->nombre_completo.
    ELSEIF io_otro->obtener_idoneidad_final( ) > me->obtener_idoneidad_final( ).
      rv_resultado = io_otro->nombre_completo.
    ELSE.
      rv_resultado = 'EMPATE'.
    ENDIF.
  ENDMETHOD.

  METHOD calcular_banda_salarial.
    " REQUISITO 2: FLOOR y CEIL
    DATA(lv_low)  = FLOOR( me->salario_pretendido / 5000 ) * 5000.
    DATA(lv_high) = CEIL( me->salario_pretendido / 5000 ) * 5000.
    IF lv_low = lv_high.
      lv_high = lv_low + 5000.
    ENDIF.
    rv_banda = |{ lv_low } - { lv_high }|.
  ENDMETHOD.

ENDCLASS.


