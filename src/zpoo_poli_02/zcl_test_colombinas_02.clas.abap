***Enunciado — Atracciones de las Fiestas Colombinas de Huelva (con guía)
***
***Aprovechando que estamos en fechas de Fiestas Colombinas,
***vamos a modelar las distintas *atracciones del recinto ferial*:
***casetas de comida, atracciones de feria, y conciertos. Todas comparten cosas,
***pero cada una calcula el precio de entrada de forma distinta
***— el escenario perfecto para practicar polimorfismo de verdad.
***
***### Comportamiento común (clase padre)
***
***Toda atracción del recinto:
***
***- *Tiene*: un nombre, y el número de visitantes que han pasado por ella hoy.
***- *Sabe*:
***  - *recibir_visitante*: sin parámetros de entrada, suma 1 al contador de visitantes de hoy.
***  - *calcular_precio_entrada: sin parámetros, devuelve (RETURNING) un importe. Comportamiento
***del padre: **entrada gratuita (0€)*, por defecto.
***  - *consultar_visitantes*: devuelve (RETURNING) el número de visitantes de hoy.
***
***### Hija 1 — Caseta de feria (ZCL_CASETA_00)
***
***Las casetas de comida y bebida no cobran entrada, son gratuitas para entrar
***— igual que el padre. No redefine calcular_precio_entrada.*
***
***- Añade un método propio: pedir_rebujito, sin parámetros ni lógica obligatoria.
***
***### Hija 2 — Atracción de feria (tipo noria, coches de choque...) (ZCL_ATRACCION_FERIA_00)
***
***Aquí sí cambia el precio: cada atracción de feria tiene un *precio fijo por persona*,
***que se indica al crear la atracción (no es siempre el mismo para todas
***— una noria puede costar 3€ y los coches de choque 2€, por ejemplo).
***
***- *Redefine calcular_precio_entrada*, devolviendo el precio fijo propio de esa atracción
***concreta (guardado en un atributo propio).
***- Añade un atributo propio: precio fijo (tipo p decimals 2), que se recibe en su propio
***constructor.
***
***### Hija 3 — Concierto (ZCL_CONCIERTO_00)
***
***Los conciertos tienen una particularidad: el precio *depende de si ya han pasado
***500 visitantes o más ese día* — a partir del visitante 500,
***se activa un "precio de última hora" más barato para animar
***a la gente a última hora (por ejemplo, 5€ en vez de 10€).
***
***- *Redefine calcular_precio_entrada*: si consultar_visitantes( ) es menor de 500,
***el precio es 10€; si es 500 o más, el precio es 5€.
***- No añade ningún atributo ni método propio extra — con la redefinición ya tiene
***toda su particularidad.
***
***### Clase de test ZCL_TEST_COLOMBINAS_00
***
***1. Crear una caseta, una atracción de feria (con precio 3€) y un concierto.
***2. Meter los tres objetos en *una única tabla interna* del tipo del padre
***(TABLE OF REF TO zcl_atraccion_00).
***3. Recorrer la tabla con un LOOP, y para cada elemento: llamar a recibir_visitante( )
***una vez, y mostrar por consola el nombre (si lo tenéis como atributo) junto
***con el resultado de calcular_precio_entrada( ).
***4. Fuera del LOOP, forzar que el concierto reciba 500 visitantes de golpe
***(con un bucle simple llamando 500 veces a recibir_visitante( ) sobre el objeto concierto
***directamente, no a través de la tabla), y volver a consultar su precio — comprobad que
***ahora sale el precio reducido.
***
***### 🧭 Guía paso a paso
***
***1. Empezad por la clase padre exactamente con el mismo patrón que ya conocéis:
***PUBLIC SECTION con los métodos, PROTECTED SECTION con lo que las hijas
***puedan necesitar (pensad si visitantes_hoy debería ser
***PROTECTED o PRIVATE — depende de si alguna hija necesita tocarlo directamente además
***de a través de recibir_visitante; en este ejercicio, con que sea PROTECTED es suficiente y
***más simple).
***2. Para que calcular_precio_entrada se pueda redefinir en las hijas, aseguraos de
***que la clase padre *no lleva FINAL*.
***3. En cada hija que redefina, no olvidéis la línea METHODS calcular_precio_entrada
***REDEFINITION. en la DEFINITION, y el código nuevo en la IMPLEMENTATION — recordad que la firma
***(RETURNING VALUE(...) TYPE p DECIMALS 2) no se repite, ya viene fijada por el padre.
***4. Acordaos del patrón super->constructor( iv_nombre = iv_nombre ) en el constructor de
***cada hija, para no perder la inicialización del padre.
***5. Para la tabla mezclada, usad el mismo patrón que vimos en el ejemplo de
***zcl_polimorfismo_00: DATA lt_atracciones TYPE TABLE OF REF TO zcl_atraccion_00. y varios
***APPEND NEW zcl_xxx( ... ) TO lt_atracciones. con cada tipo de hija.
***6. En el LOOP, acordaos de que solo podéis llamar, a través del tipo padre,
***a métodos que *existan en el padre* (aunque estén redefinidos) — no podríais llamar
***a pedir_rebujito dentro de ese mismo LOOP genérico, porque el padre no lo conoce.
***7. Para forzar los 500 visitantes del concierto, no lo hagáis a través de
***la tabla genérica — usad directamente la variable original con la que creasteis el concierto
***(antes de meterlo en la tabla, o guardando también una referencia aparte), ya que
***necesitáis llamarlo muchas veces seguidas de forma controlada.
***
***Cuando lo tengáis, lo revisamos — es un buen ejercicio para que vean con sus propios ojos cómo,
***en el mismo LOOP, cada tipo de atracción "contesta" un precio distinto sin que el
***código del bucle tenga que preguntar nunca de qué tipo es cada una.
***


CLASS zcl_test_colombinas_02 DEFINITION PUBLIC FINAL CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PRIVATE SECTION.
    DATA: mo_out TYPE REF TO if_oo_adt_classrun_out.
ENDCLASS.


CLASS zcl_test_colombinas_02 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    mo_out = out.

    DATA(lo_caseta)    = NEW zcl_caseta_02( iv_nombre = 'Caseta El Rocío' ).
    DATA(lo_atraccion) = NEW zcl_atraccion_feria_02( iv_nombre = 'Noria' iv_precio = '3.00' ).
    DATA(lo_concierto) = NEW zcl_concierto_02( iv_nombre = 'Concierto Melendi' ).

    DATA: lt_atracciones TYPE TABLE OF REF TO zcl_atraccion_02.

    APPEND lo_caseta    TO lt_atracciones.
    APPEND lo_atraccion TO lt_atracciones.
    APPEND lo_concierto TO lt_atracciones.

    LOOP AT lt_atracciones INTO DATA(lo_ref).
      lo_ref->recibir_visitante( ).
      DATA(lv_precio) = lo_ref->calcular_precio_entrada( ).
      mo_out->write( |Visitantes: { lo_ref->consultar_visitantes( ) } - Precio: { lv_precio } EUR| ).
    ENDLOOP.

    mo_out->write( '--- Antes del Forzado  ---'    ).
    mo_out->write( |Concierto tras 500 visitantes - Precio: { lo_concierto->calcular_precio_entrada( ) } EUR| ).

    mo_out->write( '--- Forzando 500 visitantes al concierto ---' ).
    DO 501 TIMES.
      lo_concierto->recibir_visitante( ).
    ENDDO.

    mo_out->write( |Concierto tras 500 visitantes - Precio: { lo_concierto->calcular_precio_entrada( ) } EUR| ).
  ENDMETHOD.
ENDCLASS.
