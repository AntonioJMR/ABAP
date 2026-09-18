CLASS zcl_gestion_empleados_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: tt_empleados TYPE STANDARD TABLE OF ztab_usuario_02 WITH EMPTY KEY.

    METHODS constructor
      IMPORTING
        iv_nombre          TYPE string
        iv_apellido        TYPE string
        iv_telefono        TYPE string
        iv_experiencia     TYPE i
        iv_certificaciones TYPE i.

    METHODS calcular_sueldo
      RETURNING VALUE(rv_sueldo) TYPE ze_sueldo_02.

    METHODS generar_id
      RETURNING VALUE(rv_id) TYPE ze_id_emp_02.

    METHODS dar_alta
      RETURNING VALUE(rv_mensaje) TYPE string.

    METHODS modificar
      IMPORTING
        iv_id              TYPE ze_id_emp_02
        iv_nombre          TYPE string
        iv_apellido        TYPE string
        iv_telefono        TYPE string
        iv_experiencia     TYPE i
        iv_certificaciones TYPE i
      RETURNING VALUE(rv_mensaje) TYPE string.

    METHODS consultar
      IMPORTING
        iv_id_empleado TYPE ze_id_emp_02
      RETURNING VALUE(rt_empleados) TYPE tt_empleados.

    METHODS consultar_n
      IMPORTING
        iv_n TYPE i
      RETURNING VALUE(rt_empleados) TYPE tt_empleados.

  PRIVATE SECTION.
    DATA: mv_nombre          TYPE string,
          mv_apellido        TYPE string,
          mv_telefono        TYPE string,
          mv_experiencia     TYPE i,
          mv_certificaciones TYPE i,
          mv_sueldo          TYPE ze_sueldo_02.

ENDCLASS.

CLASS zcl_gestion_empleados_02 IMPLEMENTATION.

  METHOD constructor.
    mv_nombre          = iv_nombre.
    mv_apellido        = iv_apellido.
    mv_telefono        = iv_telefono.
    mv_experiencia     = iv_experiencia.
    mv_certificaciones = iv_certificaciones.
  ENDMETHOD.


  METHOD calcular_sueldo.
    " SUELDO = 1000 + (certificaciones * 50) + (experiencia * 100)
    mv_sueldo = 1000
              + ( mv_certificaciones * 50 )
              + ( mv_experiencia * 100 ).

    rv_sueldo = mv_sueldo.
  ENDMETHOD.


  METHOD generar_id.
    DATA(lv_max_id) = CONV ze_id_emp_02( 0 ).

    SELECT SINGLE MAX( id_empleado )
      FROM ztab_usuario_02
      INTO @lv_max_id.

    IF lv_max_id IS INITIAL.
      rv_id = 1.
    ELSE.
      rv_id = lv_max_id + 1.
    ENDIF.
  ENDMETHOD.


  METHOD dar_alta.
    DATA: ls_empleado TYPE ztab_usuario_02.

    ls_empleado-id_empleado = generar_id( ).
    ls_empleado-nombre      = mv_nombre.
    ls_empleado-apellido    = mv_apellido.
    ls_empleado-telefono    = mv_telefono.
    ls_empleado-sueldo      = calcular_sueldo( ).

    INSERT ztab_usuario_02 FROM @ls_empleado.

    IF sy-subrc = 0.
      rv_mensaje = |Empleado dado de alta correctamente. ID asignado: { ls_empleado-id_empleado }|.
    ELSE.
      rv_mensaje = 'Error: no se ha podido dar de alta al empleado.'.
    ENDIF.
  ENDMETHOD.

  METHOD modificar.
    DATA: ls_empleado TYPE ztab_usuario_02.

    " Comprobar que el empleado existe
    SELECT SINGLE *
      FROM ztab_usuario_02
      WHERE id_empleado = @iv_id
      INTO @ls_empleado.

    IF sy-subrc <> 0.
      rv_mensaje = |Error: no existe ningún empleado con ID { iv_id }. No se ha modificado nada.|.
      RETURN.
    ENDIF.

    " ... resto del método igual ...
  ENDMETHOD.


  METHOD consultar.
    IF iv_id_empleado = 0.
      SELECT *
        FROM ztab_usuario_02
        INTO TABLE @rt_empleados.
    ELSE.
      SELECT *
        FROM ztab_usuario_02
        WHERE id_empleado = @iv_id_empleado
        INTO TABLE @rt_empleados.
    ENDIF.
  ENDMETHOD.


  METHOD consultar_n.
    SELECT *
      FROM ztab_usuario_02
      ORDER BY id_empleado
      INTO TABLE @rt_empleados
      UP TO @iv_n ROWS.
  ENDMETHOD.

ENDCLASS.

