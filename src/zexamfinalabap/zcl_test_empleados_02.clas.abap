CLASS zcl_test_empleados_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

ENDCLASS.


CLASS zcl_test_empleados_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " Cambia este valor para probar cada funcionalidad:
    " 1 = Alta, 2 = Modificación, 3 = Consulta por ID / todos, 4 = Consulta N registros
    DATA(lv_opcion) = 1.

    CASE lv_opcion.

      WHEN 1. " --- ALTA DE EMPLEADO ---
        DATA(lo_alta) = NEW zcl_gestion_empleados_02(
          iv_nombre          = 'Juan'
          iv_apellido        = 'Perez'
          iv_telefono        = '600123456'
          iv_experiencia     = 5
          iv_certificaciones = 2 ).

        out->write( lo_alta->dar_alta( ) ).


      WHEN 2. " --- MODIFICACIÓN DE EMPLEADO ---
        DATA(lo_mod) = NEW zcl_gestion_empleados_02(
          iv_nombre          = ''
          iv_apellido        = ''
          iv_telefono        = ''
          iv_experiencia     = 0
          iv_certificaciones = 0 ).

        out->write( lo_mod->modificar(
          iv_id              = 1
          iv_nombre          = 'Juan'
          iv_apellido        = 'Perez Garcia'
          iv_telefono        = '600999888'
          iv_experiencia     = 8
          iv_certificaciones = 4 ) ).


      WHEN 3. " --- CONSULTA (por ID o todos si ID = 0) ---
        DATA(lo_consulta) = NEW zcl_gestion_empleados_02(
          iv_nombre          = ''
          iv_apellido        = ''
          iv_telefono        = ''
          iv_experiencia     = 0
          iv_certificaciones = 0 ).

        DATA(lt_empleados) = lo_consulta->consultar( iv_id_empleado = 0 ).
        out->write( lt_empleados ).


      WHEN 4. " --- CONSULTA DE N REGISTROS ---
        DATA(lo_consulta_n) = NEW zcl_gestion_empleados_02(
          iv_nombre          = ''
          iv_apellido        = ''
          iv_telefono        = ''
          iv_experiencia     = 0
          iv_certificaciones = 0 ).

        DATA(lt_top_n) = lo_consulta_n->consultar_n( iv_n = 5 ).
        out->write( lt_top_n ).


      WHEN OTHERS.
        out->write( 'Opción no válida.' ).

    ENDCASE.

  ENDMETHOD.

ENDCLASS.
