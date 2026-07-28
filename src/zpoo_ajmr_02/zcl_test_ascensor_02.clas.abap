CLASS zcl_test_ascensor_02 DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS zcl_test_ascensor_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(lo_ascensor) = NEW zcl_ascensor_02( iv_planta_maxima = 10 iv_peso_maximo = 400 ).

    DATA: lv_planta_actual TYPE i,
          lv_peso_actual   TYPE i,
          lv_bloqueado     TYPE abap_bool.

    " Paso 1: entran 300 kg
    lo_ascensor->entrar_peso( iv_kilos = 300 ).
    lo_ascensor->consultar_estado(
      IMPORTING ev_planta_actual = lv_planta_actual
                ev_peso_actual   = lv_peso_actual
                ev_bloqueado     = lv_bloqueado ).
    out->write( |Paso 1 (entran 300kg): Peso = { lv_peso_actual } - Bloqueado = { lv_bloqueado }| ).

    " Paso 2: intentan entrar 150 kg mas (superaria el maximo)
    lo_ascensor->entrar_peso( iv_kilos = 150 ).
    lo_ascensor->consultar_estado(
      IMPORTING ev_planta_actual = lv_planta_actual
                ev_peso_actual   = lv_peso_actual
                ev_bloqueado     = lv_bloqueado ).
    out->write( |Paso 2 (intentan entrar 150kg mas): Peso = { lv_peso_actual } - Bloqueado = { lv_bloqueado }| ).

    " Paso 3: intentan subir a planta 5 (deberia fallar, bloqueado)
    DATA(lv_subida_1) = lo_ascensor->subir_a_planta( iv_planta_destino = 5 ).
    out->write( |Paso 3 (subir a planta 5, bloqueado): Se movio = { lv_subida_1 }| ).

    " Paso 4: se vacia el ascensor
    lo_ascensor->vaciar( ).
    lo_ascensor->consultar_estado(
      IMPORTING ev_planta_actual = lv_planta_actual
                ev_peso_actual   = lv_peso_actual
                ev_bloqueado     = lv_bloqueado ).
    out->write( |Paso 4 (vaciado): Peso = { lv_peso_actual } - Bloqueado = { lv_bloqueado }| ).

    " Paso 5: suben a planta 5 (deberia funcionar)
    DATA(lv_subida_2) = lo_ascensor->subir_a_planta( iv_planta_destino = 5 ).
    lo_ascensor->consultar_estado(
      IMPORTING ev_planta_actual = lv_planta_actual
                ev_peso_actual   = lv_peso_actual
                ev_bloqueado     = lv_bloqueado ).
    out->write( |Paso 5 (subir a planta 5): Se movio = { lv_subida_2 } - Planta actual = { lv_planta_actual }| ).

    " Paso 6: intentan subir a planta 15 (fuera de rango)
    DATA(lv_subida_3) = lo_ascensor->subir_a_planta( iv_planta_destino = 15 ).
    lo_ascensor->consultar_estado(
      IMPORTING ev_planta_actual = lv_planta_actual
                ev_peso_actual   = lv_peso_actual
                ev_bloqueado     = lv_bloqueado ).
    out->write( |Paso 6 (subir a planta 15, fuera de rango): Se movio = { lv_subida_3 } - Planta actual = { lv_planta_actual }| ).

  ENDMETHOD.

ENDCLASS.
