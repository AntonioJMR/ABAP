CLASS zejemplo_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zejemplo_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(lo_sms) = NEW zcl_notificacion_sms_00( i_telefono = '666666666' ).
    DATA(lo_carta) = NEW ZCL_NOTIFICACION_carta_00( i_direccion = 'Calle 17' ).

    DATA(lv_coste) = lo_sms->zif_notificable_00~consultar_coste_envio(  ).
    out->write( |El coste del SMS es { lv_coste }€| ).

    lv_coste = lo_carta->zif_notificable_00~consultar_coste_envio(  ).
    out->write( |El coste de la carta es { lv_coste }€| ).

    " Tabla con el tipo de la interfaz
    DATA lt_notificaciones TYPE TABLE OF REF TO zif_notificable_00.

    APPEND lo_sms TO lt_notificaciones.
    APPEND lo_carta TO lt_notificaciones.

    APPEND NEW zcl_notificacion_sms_00( i_telefono = '777777777' ) TO lt_notificaciones.
    APPEND NEW zcl_notificacion_carta_00( i_direccion = 'Calle 18' ) TO lt_notificaciones.

    out->write( |Comienza el bucle:| ).
    DATA(lv_contador) = 0.
    LOOP AT lt_notificaciones INTO DATA(lo_notificacion).
      lv_coste = lo_notificacion->consultar_coste_envio(  ).
      out->write( |El coste es { lv_coste }€| ).
      lv_contador += 1.

**  *----------------------------------------------------------------------*
* CONTROL DINO-DINÁMICO DE TIPOS Y REFERENCIAS (RTTI & INSTANCE OF)
*----------------------------------------------------------------------*
* 1. Determinación de Tipo en Tiempo de Ejecución (RTTI):
*    Para conocer el tipo exacto al que apunta una referencia anónima
*    o genérica (TYPE REF TO data / object), se obtiene su objeto descriptor
*    mediante 'cl_abap_typedescr=>describe_by_data_ref'.
*
* 2. Verificación de Tipo (IS INSTANCE OF):
*    Con el tipo de objeto o datos identificado, se utiliza la cláusula
*    'IS INSTANCE OF' para validar de forma segura si la referencia
*    corresponde a una clase o estructura concreta antes de realizar
*    un 'CAST' o asignar el valor.
*----------------------------------------------------------------------*


*----------------------------------------------------------------------*
* Control de Tipos de Referencias en ABAP:
* 1. 'IS INSTANCE OF': Evalúa de forma directa si un objeto/referencia
*    corresponde a un tipo o clase específica.
* 2. 'cl_abap_typedescr': Inspecciona y devuelve el tipo técnico en
*    tiempo de ejecución (RTTI) para controles dinámicos.
*----------------------------------------------------------------------*
      DATA(lo_descriptor) =
            cl_abap_typedescr=>describe_by_object_ref( lo_notificacion ).
      DATA(lv_tipo_real) = lo_descriptor->get_relative_name( ).
      out->write( |La notificación es de tipo: { lv_tipo_real }| ).

    ENDLOOP.
    out->write( |El número de envíos es { lv_contador }| ).
  ENDMETHOD.
ENDCLASS.
