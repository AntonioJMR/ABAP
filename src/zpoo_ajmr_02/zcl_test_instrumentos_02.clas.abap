CLASS zcl_test_instrumentos_02 DEFINITION
PUBLIC
FINAL
CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.



CLASS ZCL_TEST_INSTRUMENTOS_02 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    " No puedes llamar al forzando al constructor del hijo
*    DATA(lo_guitarra_2) = NEW zcl_guitarra_02( iv_marca = 'Gibson' ).
*    out->write(  lo_guitarra_2->iv_numero_cuerdas ).

    " Paso 1 y 2: crear guitarra y piano
    DATA(lo_guitarra) = NEW zcl_guitarra_02( iv_marca = 'Fender' iv_numero_cuerdas = 6 ).

    DATA(lo_piano)    = NEW zcl_piano_02( iv_marca = 'Yamaha' iv_es_electrico = abap_true ).

    " Paso 3: afinar cuerda 8 (deberia fallar)
    DATA(lv_afinar_1) = lo_guitarra->afinar_cuerda( iv_numero_cuerda = 8 ).
    out->write( |Paso 3 - Afinar cuerda 8: { lv_afinar_1 }| ).

    " Paso 4: afinar cuerda 3 (deberia funcionar)
    DATA(lv_afinar_2) = lo_guitarra->afinar_cuerda( iv_numero_cuerda = 3 ).
    out->write( |Paso 4 - Afinar cuerda 3: { lv_afinar_2 }| ).

    " Paso 5: pedalear en piano recien creado (deberia fallar)
    DATA(lv_pedal_1) = lo_piano->pedalear( ).
    out->write( |Paso 5 - Pedalear (piano nuevo): { lv_pedal_1 }| ).

    " Paso 6: registrar 2 horas de practica en el piano
    lo_piano->registrar_practica( iv_horas_practicadas = 2 ).
    out->write( |Paso 6 - Practica registrada en piano| ).

    " Paso 7: volver a intentar pedalear (deberia funcionar)
    DATA(lv_pedal_2) = lo_piano->pedalear( ).
    out->write( |Paso 7 - Pedalear (tras practica): { lv_pedal_2 }| ).

    " Paso 8: registrar 1 hora de practica en la guitarra
    lo_guitarra->registrar_practica( iv_horas_practicadas = 1 ).
    out->write( |Paso 8 - Practica registrada en guitarra| ).

    " Paso 9: consultar horas de uso finales de ambos
    out->write( |Paso 9 - Horas de uso guitarra: { lo_guitarra->consultar_horas_uso( ) }| ).
    out->write( |Paso 9 - Horas de uso piano: { lo_piano->consultar_horas_uso( ) }| ).

  ENDMETHOD.
ENDCLASS.
