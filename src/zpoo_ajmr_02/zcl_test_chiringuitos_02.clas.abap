***Enunciado — Chiringuitos de playa (herencia + varias redefiniciones)
***
***Temática nueva: vamos a modelar **puestos de playa**, con un padre genérico
***y dos tipos concretos que redefinen comportamiento de formas distintas.
***
***### Comportamiento común (clase padre)
***
***Todo puesto de playa:
***
***- **Tiene**: un nombre, y el dinero recaudado en el día (empieza en 0).
***- **Sabe**:
***  - **`vender`**: recibe un importe (`IMPORTING`), y lo suma a la recaudación del día.
***  Comportamiento por defecto (el del padre): se acepta cualquier importe mayor que 0,
***  sin más condiciones.
***  - **`calcular_comision_ayuntamiento`**: sin parámetros, devuelve (`RETURNING`) un importe.
***  Comportamiento por defecto del padre: la comisión es siempre el **10%**
***  de la recaudación del día.
***  - **`consultar_recaudacion`**: devuelve (`RETURNING`) la recaudación acumulada del día.
***
***### Hija 1 — Chiringuito de bebidas (`ZCL_CHIRINGUITO_BEBIDAS_XX`)
***
***Vende bebidas, y tiene una regla especial de venta: **no puede vender por debajo de 1,50€**
***(es el precio mínimo de cualquier bebida, así que una venta de menos de eso no tiene sentido
***y debe rechazarse). Por lo demás, cuando la venta sí es válida, se suma igual que en el padre.
***
***- Debe **redefinir `vender`**, añadiendo esa condición mínima antes de aceptar la venta.
***Si el importe es menor de 1,50€, no se suma nada y el método debe devolver (`RETURNING`)
***un `abap_bool` indicando si la venta se realizó o no. *(Ojo: esto implica que
***también tenéis que cambiar la firma con `RETURNING` respecto al padre
***— pensad si eso es posible o no con `REDEFINITION`, y si hace falta ajustar el método
***del padre desde el principio para que ya lleve ese `RETURNING` desde el diseño original.)*
***- No toca `calcular_comision_ayuntamiento` — hereda la del 10% tal cual.
***- Añade además un método propio, `anadir_hielo`, sin parámetros ni lógica obligatoria
***(podéis dejarlo vacío o con un simple `out->write`).
***
***### Hija 2 — Alquiler de hamacas (`ZCL_ALQUILER_HAMACAS_XX`)
***
***Alquila hamacas y sombrillas, y aquí la particularidad está en la **comisión**:
***el ayuntamiento le cobra más porque ocupa espacio físico de la playa. En vez del 10% general,
*** a este tipo de negocio se le aplica un **20%** de comisión.
***
***- Debe **redefinir `calcular_comision_ayuntamiento`**, cambiando el porcentaje al 20%.
***Pensad si os conviene reutilizar `super->calcular_comision_ayuntamiento( )`
***de alguna forma ingeniosa (pista: el resultado del padre ya os da el
***10%... ¿cómo llegaríais al 20% a partir de eso, sin repetir el cálculo desde cero?),
***o si preferís calcularlo directamente vosotros con vuestro propio porcentaje.
***- No toca `vender` — hereda el comportamiento del padre tal cual
***(cualquier importe mayor que 0 se acepta).
***- Añade además un método propio, `reservar_sombrilla`,
***recibe un número de sombrilla (`IMPORTING`), sin lógica obligatoria más allá de guardarlo
***o mostrarlo (vosotros decidís el nivel de detalle).
***
***### Clase de test `ZCL_TEST_CHIRINGUITOS_XX`
***
***Debe, en este orden, mostrando el resultado de cada paso por consola:
***
***1. Crear un chiringuito de bebidas.
***2. Intentar vender por 1,00€ (debería rechazarse, por debajo del mínimo).
***3. Vender por 3,50€ (debería aceptarse).
***4. Consultar y mostrar su recaudación y su comisión (debería salir el 10%, heredado sin cambios).
***5. Crear un alquiler de hamacas.
***6. Vender (alquilar) por 8,00€ (usando el método heredado sin redefinir,
***debería aceptarse sin ninguna condición especial de mínimo).
***7. Consultar y mostrar su recaudación y su comisión
***— aquí debería verse claramente que sale el **20%**, distinto al chiringuito de bebidas,
***a pesar de ser el mismo método heredado del mismo padre.
***
***### Puntos importantes en los que pensar antes de escribir código
***
***- **Diseñad bien la firma del método `vender` en el padre desde el principio.
***** Como una de las hijas necesita que `vender` devuelva un `abap_bool`
***(si se aceptó o no la venta), y en ABAP `REDEFINITION` **no permite cambiar la firma del método**
***(los parámetros deben ser exactamente los mismos que en el padre), el padre
***ya debe declarar `vender` con ese `RETURNING abap_bool` desde el principio,
***aunque en el padre la lógica sea tan simple que casi siempre devuelva `abap_true`.
***- Repasad la visibilidad de los atributos del padre (nombre, recaudación)
***para que ambas hijas puedan acceder sin problema.
***- Acordaos del patrón `super->constructor(...)` en el constructor de cada hija,
*** igual que en los ejercicios anteriores.
***
***Este es un ejercicio pensado para que veáis **dos formas
***distintas de usar `REDEFINITION`**: una que cambia por completo la lógica añadiendo
***una condición previa (bebidas), y otra que reutiliza el cálculo del padre para llegar
***a un resultado distinto (hamacas). Cuando lo tengáis, lo coment


CLASS zcl_test_chiringuitos_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

ENDCLASS.


CLASS zcl_test_chiringuitos_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: lo_bebidas  TYPE REF TO zcl_chiringuito_bebidas_02,
          lo_hamacas  TYPE REF TO zcl_alquiler_hamacas_02,
          lv_ok       TYPE abap_bool,
          lv_recaud   TYPE decfloat34,
          lv_comision TYPE decfloat34.

    " ---- 1. Crear chiringuito de bebidas ----
    lo_bebidas = NEW zcl_chiringuito_bebidas_02( iv_nombre = 'Chiringuito La Ola' ).

    " ---- 2. Intentar vender por 1,00€ (debe rechazarse) ----
    lv_ok = lo_bebidas->vender( iv_importe = '1.00' ).
    out->write( |Venta de 1,00€ en bebidas aceptada?: { lv_ok }| ).

    " ---- 3. Vender por 3,50€ (debe aceptarse) ----
    lv_ok = lo_bebidas->vender( iv_importe = '3.50' ).
    out->write( |Venta de 3,50€ en bebidas aceptada?: { lv_ok }| ).

    " ---- 4. Consultar recaudación y comisión (10%) ----
    lv_recaud   = lo_bebidas->consultar_recaudacion( ).
    lv_comision = lo_bebidas->calcular_comision_ayuntamiento( ).
    out->write( |Recaudación bebidas: { lv_recaud } € | ).
    out->write( |Comisión ayuntamiento bebidas (10%): { lv_comision } € | ).

    " ---- 5. Crear alquiler de hamacas ----
    lo_hamacas = NEW zcl_alquiler_hamacas_02( iv_nombre = 'Hamacas Costa Azul' ).

    " ---- 6. Vender (alquilar) por 8,00€, sin condición de mínimo ----
    lv_ok = lo_hamacas->vender( iv_importe = '8.00' ).
    out->write( |Alquiler de 8,00€ aceptado?: { lv_ok }| ).

    " ---- 7. Consultar recaudación y comisión (20%) ----
    lv_recaud   = lo_hamacas->consultar_recaudacion( ).
    lv_comision = lo_hamacas->calcular_comision_ayuntamiento( ).
    out->write( |Recaudación hamacas: { lv_recaud } € | ).
    out->write( |Comisión ayuntamiento hamacas (20%): { lv_comision } € | ).

  ENDMETHOD.

ENDCLASS.
