**## Ejercicio 3 (difícil) — Ascensor con límite de peso
**
**Un ascensor de un edificio de varias plantas, con control de sobrepeso y bloqueo de seguridad.
**
***Comportamiento:*
**- Nace con la planta más baja del edificio (planta 0) como posición inicial, y con un peso máximo soportado que sí se indica al construirlo.
**- Tiene un peso actual dentro (empieza en 0, vacío).
**- Sabe *entrar gente: le decís cuántos kilos entran. Si al sumarlos no se supera el máximo, se suman con normalidad. Si se superaría,
**el ascensor **se bloquea por sobrepeso* (queda bloqueado hasta que se vacíe) y no deja entrar a nadie más — ni siquiera esos kilos que lo iban a hacer superar el límite.
**- Sabe *vaciarse* (todo el mundo sale): el peso vuelve a 0, y si estaba bloqueado por sobrepeso, se desbloquea automáticamente.
**- Sabe *subir a una planta concreta: recibe el número de planta al que se quiere ir. Solo puede moverse si **no está bloqueado por sobrepeso*
**y si la planta pedida está dentro de un rango válido (entre 0 y la planta máxima del edificio, que también se fija al construir el ascensor).
**Si el movimiento es válido, cambia de planta y devuelve abap_true. Si no es válido (bloqueado, o planta fuera de rango), no se mueve y devuelve abap_false.
**- Sabe informar en qué planta está, cuánto peso lleva dentro, y si está bloqueado.
**
***Clase ZCL_ASCENSOR_XX:*
**
**- Atributos privados: planta actual (I), planta máxima del edificio (I), peso máximo (I), peso actual (I), bloqueado por sobrepeso (abap_bool).
**- Constructor: recibe planta máxima del edificio y peso máximo soportado. Planta actual arranca en 0, peso actual en 0, bloqueado en abap_false.
**- Método entrar_peso: recibe kilos (IMPORTING). Aplica la lógica de suma/bloqueo descrita arriba.
**- Método vaciar: sin parámetros. Resetea peso a 0 y desbloquea.
**- Método subir_a_planta: recibe la planta destino (IMPORTING), devuelve (RETURNING) abap_bool según se haya podido mover o no.
**- Método consultar_estado: sin IMPORTING, con tres salidas por EXPORTING (planta actual, peso actual, bloqueado).
**
***Clase de test:* cread un ascensor para un edificio de 10 plantas, peso máximo 400 kg, y probad esta secuencia mostrando el estado tras cada paso:
**1. Entran 300 kg (debería aceptarse).
**2. Intentan entrar 150 kg más (superaría el máximo → debería bloquearse, sin sumar esos 150).
**3. Intentan subir a la planta 5 (debería fallar, está bloqueado).
**4. Se vacía el ascensor.
**5. Suben a la planta 5 (ahora sí debería funcionar).
**6. Intentan subir a la planta 15 (debería fallar, se sale del rango del edificio).


CLASS zcl_ascensor_02 DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        iv_planta_maxima TYPE i
        iv_peso_maximo   TYPE i.

    METHODS entrar_peso
      IMPORTING
        iv_kilos TYPE i.

    METHODS vaciar.

    METHODS subir_a_planta
      IMPORTING
        iv_planta_destino TYPE i
      RETURNING
        VALUE(resultado) TYPE abap_bool.

    METHODS consultar_estado
      EXPORTING
        ev_planta_actual TYPE i
        ev_peso_actual   TYPE i
        ev_bloqueado     TYPE abap_bool.

  PRIVATE SECTION.

    DATA mv_planta_actual  TYPE i.
    DATA mv_planta_maxima  TYPE i.
    DATA mv_peso_maximo    TYPE i.
    DATA mv_peso_actual    TYPE i.
    DATA mv_bloqueado      TYPE abap_bool.

ENDCLASS.


CLASS zcl_ascensor_02 IMPLEMENTATION.

  METHOD constructor.
    mv_planta_maxima = iv_planta_maxima.
    mv_peso_maximo   = iv_peso_maximo.
    mv_planta_actual = 0.
    mv_peso_actual   = 0.
    mv_bloqueado     = abap_false.
  ENDMETHOD.

  METHOD entrar_peso.

    IF mv_bloqueado = abap_true.
      RETURN.
    ENDIF.

    IF mv_peso_actual + iv_kilos <= mv_peso_maximo.
      mv_peso_actual = mv_peso_actual + iv_kilos.
    ELSE.
      mv_bloqueado = abap_true.
    ENDIF.

  ENDMETHOD.

  METHOD vaciar.
    mv_peso_actual = 0.
    mv_bloqueado   = abap_false.
  ENDMETHOD.

  METHOD subir_a_planta.

    IF mv_bloqueado = abap_true.
      resultado = abap_false.
      RETURN.
    ENDIF.

    IF iv_planta_destino < 0 OR iv_planta_destino > mv_planta_maxima.
      resultado = abap_false.
      RETURN.
    ENDIF.

    mv_planta_actual = iv_planta_destino.
    resultado = abap_true.

  ENDMETHOD.

  METHOD consultar_estado.
    ev_planta_actual = mv_planta_actual.
    ev_peso_actual   = mv_peso_actual.
    ev_bloqueado     = mv_bloqueado.
  ENDMETHOD.

ENDCLASS.
