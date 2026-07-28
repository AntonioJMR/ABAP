**## Enunciado A — Dron de reparto (sin base de datos, misma dificultad que el ascensor)
**
**Un dron de reparto que combina dos recursos limitados a la vez: *batería* y *carga que transporta*.
**
**### Comportamiento
**
**- Nace con la batería al 100% y sin ninguna carga (0 kg). El único dato que se pide al construirlo es la *carga máxima* que puede transportar.
**- Sabe *recoger un paquete*: recibe el peso del paquete.
**  - Si al sumarlo no se supera la carga máxima *y la batería es de al menos 20%*
**  (necesita energía de sobra para poder despegar cargado), se acepta el paquete.
**  - Si no se cumple cualquiera de las dos condiciones, el paquete *no se recoge*
**  y no cambia nada.
**- Sabe *volar hasta un cliente: cada vuelo consume batería, pero el consumo
****depende de si lleva carga o no*: si lleva algo de peso encima, gasta 15% de batería; si va vacío, gasta solo 5%.
**  - Si no tiene batería suficiente para ese vuelo, el vuelo no se realiza y no se descuenta nada.
**  - Si el vuelo se realiza y llevaba carga, al llegar *se entrega el paquete*
**  (la carga vuelve a 0).
**  - Si la batería llega a 10% o menos después de un vuelo, el dron queda en
**  *modo reserva* y ya no acepta más paquetes ni vuelos hasta que se recargue.
**- Sabe *recargar*: la batería vuelve a 100% y sale del modo reserva si estaba en él.
**- Sabe informar de su batería actual, la carga que lleva encima y si está en modo reserva.
**
**### Lo que hay que construir
**
**Clase ZCL_DRON_XX con:
**
**- Atributos privados: batería (I, 0-100), carga máxima (I), carga actual (I), modo reserva (abap_bool).
**- Constructor: recibe la carga máxima. Inicializa batería a 100, carga actual a 0, modo reserva a abap_false.
**- Método recoger_paquete: IMPORTING peso del paquete, RETURNING abap_bool (se aceptó o no).
**- Método volar_a_cliente: sin parámetros de entrada, RETURNING abap_bool (se realizó el vuelo o no).
**Si se realiza y llevaba carga, la entrega (carga a 0) dentro del propio método.
**- Método recargar: sin parámetros.
**- Método consultar_estado: EXPORTING batería, carga actual y modo reserva a la vez.
**
**Clase de test ZCL_TEST_DRON_XX que cree un dron con carga máxima 5 kg, y pruebe: recoger un paquete de 3 kg,
**volar (debe entregar y bajar batería), recoger otro paquete de 2 kg, volar varias veces seguidas hasta forzar
**el modo reserva, intentar recoger un paquete estando en reserva (debe rechazarse), recargar,
**y volver a intentar recoger el paquete (ahora sí debe aceptarse). Mostrar el estado tras cada paso.

CLASS zcl_dron_02 DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        iv_carga_maxima TYPE i.

    METHODS recoger_paquete
      IMPORTING
        iv_peso           TYPE i
      RETURNING
        VALUE(rv_aceptado) TYPE abap_bool.

    METHODS volar_a_cliente
      RETURNING
        VALUE(rv_vuelo_realizado) TYPE abap_bool.

    METHODS recargar.

    METHODS consultar_estado
      EXPORTING
        ev_bateria      TYPE i
        ev_carga_actual TYPE i
        ev_modo_reserva TYPE abap_bool.

  PRIVATE SECTION.
    DATA:     mv_bateria      TYPE i,
              mv_carga_maxima TYPE i,
              mv_carga_actual TYPE i,
              mv_modo_reserva TYPE abap_bool.
  ENDCLASS.



CLASS zcl_dron_02 IMPLEMENTATION.

  METHOD constructor.
    mv_carga_maxima = iv_carga_maxima.
    mv_bateria      = 100.
    mv_carga_actual = 0.
    mv_modo_reserva = abap_false.
  ENDMETHOD.

  METHOD recoger_paquete.
    rv_aceptado = abap_false.

    " No acepta si está en modo reserva
    IF mv_modo_reserva = abap_true.
      RETURN.
    ENDIF.

    " No acepta si supera carga máxima
    IF mv_carga_actual + iv_peso > mv_carga_maxima.
      RETURN.
    ENDIF.

    " No acepta si batería menor a 20%
    IF mv_bateria < 20.
      RETURN.
    ENDIF.

    mv_carga_actual = mv_carga_actual + iv_peso.
    rv_aceptado = abap_true.
  ENDMETHOD.

  METHOD volar_a_cliente.
    DATA: lv_consumo TYPE i.

    rv_vuelo_realizado = abap_false.

    " No vuela si está en modo reserva
    IF mv_modo_reserva = abap_true.
      RETURN.
    ENDIF.

    " Consumo según si lleva carga
    IF mv_carga_actual > 0.
      lv_consumo = 15.
    ELSE.
      lv_consumo = 5.
    ENDIF.

    " No vuela si no tiene batería suficiente
    IF mv_bateria < lv_consumo.
      RETURN.
    ENDIF.

    " Realizar vuelo
    mv_bateria = mv_bateria - lv_consumo.
    rv_vuelo_realizado = abap_true.

    " Entregar paquete si llevaba carga
    IF mv_carga_actual > 0.
      mv_carga_actual = 0.
    ENDIF.

    " Activar modo reserva si batería <= 10%
    IF mv_bateria <= 10.
      mv_modo_reserva = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD recargar.
    mv_bateria      = 100.
    mv_modo_reserva = abap_false.
  ENDMETHOD.

  METHOD consultar_estado.
    ev_bateria      = mv_bateria.
    ev_carga_actual = mv_carga_actual.
    ev_modo_reserva = mv_modo_reserva.
  ENDMETHOD.

ENDCLASS.


