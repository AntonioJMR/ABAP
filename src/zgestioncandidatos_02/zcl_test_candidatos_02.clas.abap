CLASS ZCL_TEST_CANDIDATOS_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
ENDCLASS.

CLASS ZCL_TEST_CANDIDATOS_02 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF ty_candidato_completo,
             id                 TYPE i,
             nombre_completo    TYPE string,
             anios_experiencia  TYPE i,
             dni                TYPE string,
             salario_actual     TYPE p LENGTH 8 DECIMALS 2,
             salario_pretendido TYPE p LENGTH 8 DECIMALS 2,
             idoneidad          TYPE i,
             banda_salarial     TYPE string,
           END OF ty_candidato_completo,
           tt_candidatos_completos TYPE STANDARD TABLE OF ty_candidato_completo WITH EMPTY KEY.

    TYPES: BEGIN OF ty_ficha_candidato,
             id             TYPE i,
             nombre         TYPE string,
             experiencia    TYPE i,
             idoneidad      TYPE i,
             banda_salarial TYPE string,
           END OF ty_ficha_candidato,
           tt_ranking TYPE STANDARD TABLE OF ty_ficha_candidato WITH EMPTY KEY.

    TYPES t_objetos TYPE STANDARD TABLE OF REF TO zcl_candidato WITH EMPTY KEY.

    " 1. Instanciación sin APPEND empleando VALUE #( )
    DATA(lt_objetos_candidatos) = VALUE t_objetos(
      ( NEW zcl_candidato_interno( ) )
      ( NEW zcl_candidato_interno( ) )
      ( NEW zcl_candidato_externo( ) )
      ( NEW zcl_candidato_externo( ) )
    ).

    " Asignación de datos base para las pruebas
    DATA(lo_int1) = lt_objetos_candidatos[ 1 ].
    lo_int1->id = 1. lo_int1->nombre_completo = 'Ana Gómez'. lo_int1->anios_experiencia = 5.
    lo_int1->dni = '12345678A'. lo_int1->salario_pretendido = 28000.

    DATA(lo_int2) = lt_objetos_candidatos[ 2 ].
    lo_int2->id = 2. lo_int2->nombre_completo = 'Luis Pardo'. lo_int2->anios_experiencia = 12.
    lo_int2->dni = '87654321B'. lo_int2->salario_pretendido = 30000.

    DATA(lo_ext1) = CAST zcl_candidato_externo( lt_objetos_candidatos[ 3 ] ).
    lo_ext1->id = 3. lo_ext1->nombre_completo = 'Eva Sastre'. lo_ext1->anios_experiencia = 4.
    lo_ext1->num_certificaciones = 2. lo_ext1->dni = '55554444C'. lo_ext1->salario_pretendido = 32500.

    DATA(lo_ext2) = CAST zcl_candidato_externo( lt_objetos_candidatos[ 4 ] ).
    lo_ext2->id = 4. lo_ext2->nombre_completo = 'Igor Rian'. lo_ext2->anios_experiencia = 2.
    lo_ext2->num_certificaciones = 5. lo_ext2->dni = '99991111D'. lo_ext2->salario_pretendido = 41000.

    out->write( '=== 1. Recorrido Polimórfico - Idoneidades Iniciales ===' ).
    LOOP AT lt_objetos_candidatos INTO DATA(lo_cand).
      out->write( |Candidato: { lo_cand->nombre_completo } -> Idoneidad Base: { lo_cand->calcular_idoneidad( ) }| ).
    ENDLOOP.

    " Modificación de estados con entrevistas
    lo_int1->anadir_puntos_entrevista( 15 ).
    lo_ext1->anadir_puntos_entrevista( 10 ).

    out->write( NEW string( ) ).
    out->write( '=== 2. Comparación entre Ana Gómez y Eva Sastre ===' ).
    out->write( |Ganador por idoneidad: { lo_int1->comparar_con( lo_ext1 ) }| ).

    " Sentencia Moderna: Generar la tabla estructurada usando expresiones FOR en VALUE (Sin APPEND)
    DATA(lt_completos) = VALUE tt_candidatos_completos(
      FOR o_cand IN lt_objetos_candidatos (
        id                 = o_cand->id
        nombre_completo    = o_cand->nombre_completo
        anios_experiencia  = o_cand->anios_experiencia
        dni                = o_cand->dni
        salario_pretendido = o_cand->salario_pretendido
        idoneidad          = o_cand->obtener_idoneidad_final( )
        banda_salarial     = o_cand->calcular_banda_salarial( )
      )
    ).

    " Sentencia Moderna: CORRESPONDING directo con MAPPING y EXCEPT (Sin LOOP ni APPEND manual)
    DATA(lt_ranking_final) = CORRESPONDING tt_ranking(
      lt_completos MAPPING nombre      = nombre_completo
                           experiencia = anios_experiencia

    ).

    SORT lt_ranking_final BY idoneidad DESCENDING.
    out->write( NEW string( ) ).
    out->write( 'Ranking Final' ).
    out->write( lt_ranking_final ).



    out->write( NEW string( ) ).
    out->write( '==================================================' ).
    out->write( '                      TEST' ).
    out->write( '==================================================' ).

    " Caso 1
    DATA(lo_test_int) = NEW zcl_candidato_interno( ).
    lo_test_int->anios_experiencia = 8.
    DATA(lv_res_1) = lo_test_int->calcular_idoneidad( ).
    out->write( |Idoneidad candidato interno -> Esperado: 6.8 : Obtenido: { lv_res_1 } | &&
                COND string( WHEN lv_res_1 = '6.8' THEN ' : OK' ELSE ' : ERROR' ) ).

    " Caso 2
    DATA(lo_test_ext) = NEW zcl_candidato_externo( ).
    lo_test_ext->anios_experiencia = 3.
    lo_test_ext->num_certificaciones = 4.
    DATA(lv_res_2) = lo_test_ext->calcular_idoneidad( ).
    out->write( |Idoneidad candidato externo -> Esperado: 6.9 : Obtenido: { lv_res_2 } | &&
                COND string( WHEN lv_res_2 = '6.9' THEN ' : OK' ELSE ' : ERROR' ) ).

    " Caso 3
    DATA(lo_test_tope) = NEW zcl_candidato_interno( ).
    lo_test_tope->anios_experiencia = 20.
    DATA(lv_res_3) = lo_test_tope->calcular_idoneidad( ).
    out->write( |Tope máximo (interno)       -> Esperado: 10  : Obtenido: { lv_res_3 } | &&
                COND string( WHEN lv_res_3 = 10 THEN ' : OK' ELSE ' : ERROR' ) ).

    " Caso 4
    DATA(lo_test_ent) = NEW zcl_candidato_interno( ).
    lo_test_ent->anios_experiencia = 9.
    lo_test_ent->anadir_puntos_entrevista( 15 ).
    DATA(lv_res_4) = lo_test_ent->obtener_idoneidad_final( ).
    out->write( |Idoneidad con entrevista    -> Esperado: 9   : Obtenido: { lv_res_4 } | &&
                COND string( WHEN lv_res_4 = 9 THEN ' : OK' ELSE ' : ERROR' ) ).

    " Caso 5
    DATA(lo_test_sal1) = NEW zcl_candidato( ).
    lo_test_sal1->salario_pretendido = 27500.
    DATA(lv_res_5) = lo_test_sal1->calcular_banda_salarial( ).
    out->write( |Banda salarial              -> Esperado: 25000 - 30000 : Obtenido: { lv_res_5 } | &&
                COND string( WHEN lv_res_5 = '25000 - 30000' THEN ' : OK' ELSE ' : ERROR' ) ).

    " Caso 6
    DATA(lo_test_sal2) = NEW zcl_candidato( ).
    lo_test_sal2->salario_pretendido = 30000.
    DATA(lv_res_6) = lo_test_sal2->calcular_banda_salarial( ).
    out->write( |Banda salarial (múltiplo)   -> Esperado: 30000 - 35000 : Obtenido: { lv_res_6 } | &&
                COND string( WHEN lv_res_6 = '30000 - 35000' THEN ' : OK' ELSE ' : ERROR' ) ).

    " Caso 7
    DATA(lo_comp1) = NEW zcl_candidato( ). lo_comp1->nombre_completo = 'Candidato A'. lo_comp1->anios_experiencia = 2.
    DATA(lo_comp2) = NEW zcl_candidato( ). lo_comp2->nombre_completo = 'Candidato B'. lo_comp2->anios_experiencia = 8.
    DATA(lv_res_7) = lo_comp1->comparar_con( lo_comp2 ).
    out->write( |Comparación de candidatos   -> Esperado: Candidato B   : Obtenido: { lv_res_7 } | &&
                COND string( WHEN lv_res_7 = 'Candidato B' THEN ' : OK' ELSE ' : ERROR' ) ).

  ENDMETHOD.
ENDCLASS.

*
