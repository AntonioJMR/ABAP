CLASS zcl_test_hotel_02 DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS zcl_test_hotel_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    "===================================================================
    " Paso 1: contador antes de crear nada
    "===================================================================
    out->write( |Paso 1 - Total habitaciones antes de crear: { zcl_habitacion_02=>consultar_total_habitaciones( ) }| ).

    "===================================================================
    " Paso 2: crear las tres habitaciones
    "===================================================================
    DATA(habitacion101) = NEW zcl_habitacion_estandar_02(
      iv_numero_habitacion = '101' iv_precio_noche = '60.00' iv_tiene_vistas_mar = abap_true ).

    DATA(habitacion102) = NEW zcl_habitacion_estandar_02(
      iv_numero_habitacion = '102' iv_precio_noche = '60.00' iv_tiene_vistas_mar = abap_false ).

    DATA(habitacion201) = NEW zcl_habitacion_suite_02(
      iv_numero_habitacion = '201' iv_precio_noche = '100.00' iv_incluye_jacuzzi = abap_true ).

    "===================================================================
    " Paso 3: contador tras crear las tres (deberia ser 3)
    "===================================================================
    out->write( |Paso 3 - Total habitaciones tras crear 3: { zcl_habitacion_02=>consultar_total_habitaciones( ) }| ).

    "===================================================================
    " Paso 4: precio total con noches reales (3, 3, 2)
    "===================================================================
    out->write( |Paso 4 - Precio 101 (3 noches): { habitacion101->calcular_precio_total( iv_numero_noches = 3 ) } EUR| ).
    out->write( |Paso 4 - Precio 102 (3 noches): { habitacion102->calcular_precio_total( iv_numero_noches = 3 ) } EUR| ).
    out->write( |Paso 4 - Precio 201 (2 noches): { habitacion201->calcular_precio_total( iv_numero_noches = 2 ) } EUR| ).

    "===================================================================
    " Paso 5: tabla polimorfica por HERENCIA, todas a 1 noche
    "===================================================================
    DATA(habitaciones) = VALUE zcl_habitacion_02=>tt_habitaciones( ( habitacion101 ) ( habitacion102 ) ( habitacion201 ) ).

    LOOP AT habitaciones INTO DATA(habitacion_actual).
      out->write( |Paso 5 - Precio via tabla padre (1 noche): { habitacion_actual->calcular_precio_total( iv_numero_noches = 1 ) } EUR| ).
    ENDLOOP.

    "===================================================================
    " Paso 6: tabla polimorfica por INTERFAZ
    "===================================================================
    DATA(describibles) = VALUE zif_describible_02=>tt_describibles( ( habitacion101 ) ( habitacion102 ) ( habitacion201 ) ).

    LOOP AT describibles INTO DATA(describible_actual).
      out->write( |Paso 6 - { describible_actual->describir( ) }| ).
    ENDLOOP.

    "===================================================================
    " Paso 7: contadores de instancia independientes
    "===================================================================
    DO 2 TIMES.
      habitacion101->registrar_reserva( ).
    ENDDO.

    habitacion201->registrar_reserva( ).

    out->write( |Paso 7 - Veces reservada 101: { habitacion101->consultar_veces_reservada( ) }| ).
    out->write( |Paso 7 - Veces reservada 201: { habitacion201->consultar_veces_reservada( ) }| ).

    "===================================================================
    " Paso 8: CRUD de reservas, solo con metodos estaticos
    "===================================================================
    DATA(id_101) = zcl_gestor_reservas_02=>crear_reserva( iv_numero_habitacion = '101' iv_cliente = 'Fran' ).
    out->write( |Paso 8 - Reserva creada (101/Fran), ID: { id_101 }| ).

    DATA(id_201) = zcl_gestor_reservas_02=>crear_reserva( iv_numero_habitacion = '201' iv_cliente = 'Jesus' ).
    out->write( |Paso 8 - Reserva creada (201/Jesus), ID: { id_201 }| ).

    zcl_gestor_reservas_02=>consultar_reserva(
      EXPORTING iv_id_reserva        = id_101
      IMPORTING ev_numero_habitacion = DATA(habitacion_1)
                ev_cliente           = DATA(cliente_1)
                ev_estado            = DATA(estado_1)
                ev_encontrado        = DATA(encontrado_1)
    ).
    out->write( |Paso 8 - Consulta ID { id_101 }: { habitacion_1 } - { cliente_1 } - { estado_1 } - Encontrado: { encontrado_1 }| ).

    DATA(liberado_ok) = zcl_gestor_reservas_02=>liberar_reserva( iv_id_reserva = id_101 ).
    out->write( |Paso 8 - Liberacion ID { id_101 }: { liberado_ok }| ).

    zcl_gestor_reservas_02=>consultar_reserva(
      EXPORTING iv_id_reserva        = id_101
      IMPORTING ev_numero_habitacion = DATA(habitacion_2)
                ev_cliente           = DATA(cliente_2)
                ev_estado            = DATA(estado_2)
                ev_encontrado        = DATA(encontrado_2)
    ).
    out->write( |Paso 8 - Consulta tras liberar ID { id_101 }: { habitacion_2 } - { cliente_2 } - { estado_2 } - Encontrado: { encontrado_2 }| ).

    DATA(eliminado_ok) = zcl_gestor_reservas_02=>eliminar_reserva( iv_id_reserva = id_201 ).
    out->write( |Paso 8 - Eliminacion ID { id_201 }: { eliminado_ok }| ).

    zcl_gestor_reservas_02=>consultar_reserva(
      EXPORTING iv_id_reserva        = id_201
      IMPORTING ev_numero_habitacion = DATA(habitacion_3)
                ev_cliente           = DATA(cliente_3)
                ev_estado            = DATA(estado_3)
                ev_encontrado        = DATA(encontrado_3)
    ).
    out->write( |Paso 8 - Consulta tras eliminar ID { id_201 }: Encontrado: { encontrado_3 }| ).

  ENDMETHOD.

ENDCLASS.
