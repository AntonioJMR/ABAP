CLASS zcl_ejercicio_cast_02 DEFINITION

  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

ENDCLASS.


CLASS zcl_ejercicio_cast_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.


    DATA(lo_programador) = NEW zcl_programador_02(
      lv_nombre   = 'Ana'
      lv_lenguaje = 'ABAP'
    ).

    "referencia como EMPLEADO
    DATA lo_empleado TYPE REF TO zcl_empleado_02.
    lo_empleado = lo_programador.


    "Comprobar si es  PROGRAMADOR
    IF lo_empleado IS INSTANCE OF zcl_programador_02.
      out->write( 'El objeto ES un ZCL_PROGRAMADOR_02' ).
    ELSE.
      out->write( 'El objeto NO es un ZCL_PROGRAMADOR_02' ).
    ENDIF.

    "CAST Obtener una referencia de tipo PROGRAMADOR
    DATA(lo_programador_cast) =
      CAST zcl_programador_02( lo_empleado ).

    "obtener_lenguaje( ) metodo solo existe en programador, si el obj no es programador no podra llamarlo
    DATA(lv_lenguaje) =
      lo_programador_cast->obtener_lenguaje( ).

    out->write( 'DATOS DEL PROGRAMADOR' ).
    out->write( |Nombre: { lo_programador_cast->obtener_nombre( ) }| ).
    out->write( |Lenguaje: { lv_lenguaje }| ).

  ENDMETHOD.

ENDCLASS.
