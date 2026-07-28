**## Ejercicio 2 (medio) — Mascota virtual (tipo Tamagotchi)
**
**Una mascota digital con hambre y energía, que hay que cuidar.
**
***Comportamiento:*
**- Nace con hambre a 100 (totalmente llena) y energía a 100
*(totalmente descansada). Nadie le pasa esos valores por parámetro
*al nacer — siempre empieza igual.
**- Sabe *comer*: sube el hambre en 20, sin superar nunca 100 como máximo
*(si ya tiene 90, al comer se queda en 100, no en 110).
**- Sabe *jugar: esto la hace feliz, pero **cuesta energía* (baja 15)
*y *da hambre* (baja el hambre en 10). Ninguno de
*los dos valores puede bajar de 0. Además, *si la energía está por debajo
*de 20, la mascota está demasiado cansada para jugar* y jugar
*no tiene ningún efecto (ni sube ni baja nada).
**- Sabe decir su hambre y su energía actuales (dos consultas separadas,
*o pensad si os compensa una que devuelva las dos a la vez con EXPORTING).
*
**Clase ZCL_MASCOTA_XX:*
*
*- Atributos privados: hambre (I), energía (I).
*- Constructor: sin parámetros de entrada — inicializa ambos a 100.
*- Método comer: sin IMPORTING, sube el hambre en 20 respetando el tope de 100.
*- Método jugar: sin IMPORTING. Aplica la regla de energía mínima antes de hacer nada. Baja energía y hambre respetando el mínimo de 0.
*- Método consultar_estado: sin IMPORTING, con dos parámetros de salida por EXPORTING (hambre y energía a la vez).
*
**Clase de test:* cread una mascota y probad esta secuencia, mostrando el estado después de cada acción: jugar 5 veces seguidas
*(comprobad que en algún punto deja de tener efecto por falta de energía), y luego comer una vez y ver cómo sube el hambre.

CLASS zcl_mascota_02 DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor.

    METHODS comer.

    METHODS jugar.

    METHODS consultar_estado
      EXPORTING
        ev_hambre  TYPE i
        ev_energia TYPE i.

  PRIVATE SECTION.

    DATA mv_hambre  TYPE i.
    DATA mv_energia TYPE i.

ENDCLASS.


CLASS zcl_mascota_02 IMPLEMENTATION.

  METHOD constructor.
    mv_hambre  = 100.
    mv_energia = 100.
  ENDMETHOD.

  METHOD comer.
    mv_hambre = mv_hambre + 20.
    IF mv_hambre > 100.
      mv_hambre = 100.
    ENDIF.
  ENDMETHOD.

  METHOD jugar.

    IF mv_energia < 20.
      RETURN.
    ENDIF.

    mv_energia = mv_energia - 15.
    IF mv_energia < 0.
      mv_energia = 0.
    ENDIF.

    mv_hambre = mv_hambre - 10.
    IF mv_hambre < 0.
      mv_hambre = 0.
    ENDIF.

  ENDMETHOD.

  METHOD consultar_estado.
    ev_hambre  = mv_hambre.
    ev_energia = mv_energia.
  ENDMETHOD.

ENDCLASS.
