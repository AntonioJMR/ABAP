*
*## Ejercicio 1 (fácil) — Máquina de chicles
*
*Una máquina de chicles de las de toda la vida, con monedas.
*
**Comportamiento:*
**- Nace con una cantidad de chicles dentro (capacidad inicial) y
*un precio fijo por chicle de 25 céntimos.
**- Sabe *vender un chicle*: le metéis una moneda (en céntimos)
*y, si la moneda es suficiente y quedan chicles, entrega uno
*y devuelve el cambio. Si no hay chicles o la moneda no llega,
*no entrega nada y devuelve el dinero íntegro
*como "cambio" (no se ha vendido nada).
*- Sabe decir cuántos chicles le quedan.
*
**Clase ZCL_MAQUINA_CHICLES_XX:*
*
*- Atributos privados: chicles restantes (I), precio del chicle
*(I, en céntimos).
*- Constructor: recibe la cantidad inicial de chicles.
*El precio no se pide por parámetro — se fija siempre a 25 dentro
*del propio constructor.
*- Método vender_chicle: recibe la moneda insertada (IMPORTING, tipo I),
*y devuelve (RETURNING) el cambio a entregar (tipo I). Si la venta
*no es posible (moneda insuficiente o sin stock), el cambio devuelto
*es igual a la moneda metida (no se queda con nada).
*- Método consultar_stock: devuelve (RETURNING) los chicles restantes.
*
**Clase de test:* cread una máquina con 2 chicles, y probad: comprar
*con 25 (debe vender, cambio 0), comprar con 50 (debe vender, cambio 25),
*comprar con 25 otra vez cuando ya no queda stock (no debe vender, cambio 25),
*y comprar con 10 (moneda insuficiente, no vende, cambio 10).
*Mostrad en consola el resultado de cada intento y el stock final.
*


CLASS zcl_maquina_chicles_02 DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        iv_chicles_iniciales TYPE i.

    METHODS vender_chicle
      IMPORTING
        iv_moneda TYPE i
      RETURNING
        VALUE(rv_cambio) TYPE i.

    METHODS consultar_stock
      RETURNING VALUE(resultado) TYPE i.

  PRIVATE SECTION.

    DATA mv_chicles_restantes TYPE i.
    DATA mv_precio_chicle     TYPE i.

ENDCLASS.



CLASS ZCL_MAQUINA_CHICLES_02 IMPLEMENTATION.


  METHOD constructor.
    mv_chicles_restantes = iv_chicles_iniciales.
    mv_precio_chicle     = 25.
  ENDMETHOD.


  METHOD vender_chicle.

    IF iv_moneda >= mv_precio_chicle AND mv_chicles_restantes > 0.
      mv_chicles_restantes = mv_chicles_restantes - 1.
      rv_cambio = iv_moneda - mv_precio_chicle.
    ELSE.
      rv_cambio = iv_moneda. "el cambio devuelto es igual a la moneda metida (no se queda con nada).
    ENDIF.

  ENDMETHOD.


  METHOD consultar_stock.
    resultado = mv_chicles_restantes.
  ENDMETHOD.
ENDCLASS.
