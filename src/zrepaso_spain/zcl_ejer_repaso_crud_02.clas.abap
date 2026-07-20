CLASS zcl_ejer_repaso_crud_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ejer_repaso_crud_02 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


*   ==================================================================
*   Ejer 1 — El cliente que cambia de ciudad
*   ==================================================================

out->write( '=================== 1 ======================' ).

    SELECT SINGLE FROM zcliente_02
      FIELDS *
      WHERE cliente_id = '0001'
      INTO @DATA(ls_cliente_antes).

    IF sy-subrc = 0.
      out->write( |Ejer 1 - ANTES:| ).
      out->write( ls_cliente_antes ).
    ELSE.
      out->write( |Ejer 1 - Cliente 0001 no encontrado| ).
    ENDIF.

    "Ejer real emepiza aqui antes era para comprobar antes cambio y ver que cambia.

    UPDATE zcliente_02
      SET ciudad = 'SEVILLA ESTE'
      WHERE cliente_id = '0001'.

    IF sy-subrc = 0.
      out->write( |Ejer 1 - UPDATE ok| ).
    ELSE.
      out->write( |Ejer 1 - Error update| ).
    ENDIF.

    SELECT SINGLE FROM zcliente_02
      FIELDS *
      WHERE cliente_id = '0001'
      INTO @DATA(ls_cliente_despues).

    out->write( |Ejer 1 - DESPUES:| ).
    out->write( ls_cliente_despues ).

    out->write( '=========================================' ).


*   ==================================================================
*   Ejer 2 — Pedido nuevo para un cliente existente
*   ==================================================================

out->write( '=================== 2 ======================' ).

    SELECT SINGLE FROM zcliente_02
      FIELDS cliente_id
      WHERE cliente_id = '0002'
      INTO @DATA(lv_cliente_check).

    IF sy-subrc = 0.
      out->write( |Ejer 2 - Cliente 0002 existe, continuo| ).

      DATA(ls_pedido_nuevo) = VALUE zpedido_02(
        client     = sy-mandt
        pedido_id  = '0099'
        cliente_id = '0002'
        producto   = 'Altavoces'
        importe    = '55.00'
        fecha      = sy-datum ).

      INSERT zpedido_02 FROM @ls_pedido_nuevo.

      IF sy-subrc = 0.
        out->write( |Ejer 2 - { ls_pedido_nuevo-pedido_id } insertado correctamente | ).
      ELSE.
        out->write( |Ejer 2 - Error al insertar (puede que ya exista)| ).
      ENDIF.

  " Verificar
      SELECT FROM zpedido_02 AS p
        INNER JOIN zcliente_02 AS c
          ON p~cliente_id = c~cliente_id
        FIELDS c~nombre, p~pedido_id, p~producto, p~importe
        WHERE p~cliente_id = '0002'
        INTO TABLE @DATA(lt_verificacion_ej2).

      out->write( |Ejer 2 - Pedidos de cliente encontrado: { lines( lt_verificacion_ej2 ) }| ).
      out->write( lt_verificacion_ej2 ).

    ELSE.
      out->write( |Ejer 2 - Ese cliente no existe| ).
    ENDIF.

    out->write( '=========================================' ).


*   ==================================================================
*   Ejer 3 — El cliente sin pedidos
*   ==================================================================

out->write( '=================== 3 ======================' ).

    " Paso 1: buscar un cliente que NO tenga pedido (LEFT JOIN + IS NULL)

    SELECT FROM zcliente_02 AS c
      LEFT OUTER JOIN zpedido_02 AS p
        ON c~cliente_id = p~cliente_id
      FIELDS c~cliente_id, c~nombre
      WHERE p~pedido_id IS NULL
      INTO TABLE @DATA(lt_clientes_sin_pedido).

    out->write( |Ejer 3 - Clientes sin  pedido: { lines( lt_clientes_sin_pedido ) }| ).
    out->write( lt_clientes_sin_pedido ).

    IF lines( lt_clientes_sin_pedido ) > 0.
      DATA(ls_cliente_a_borrar) = lt_clientes_sin_pedido[ 1 ].

      " Paso 2: borrarlo
      DELETE FROM zcliente_02 WHERE cliente_id = @ls_cliente_a_borrar-cliente_id.

      IF sy-subrc = 0.
        out->write( |Ejer 3 - Cliente { ls_cliente_a_borrar-cliente_id } borrado correctamente| ).
      ELSE.
        out->write( |Ejer 3 - Error al borrar el cliente| ).
      ENDIF.

      " Paso 3: intentar insertar un pedido para ese cliente ya borrado
      DATA(ls_pedido_fantasma) = VALUE zpedido_02(
        client     = sy-mandt
        pedido_id  = '0098'
        cliente_id = ls_cliente_a_borrar-cliente_id
        producto   = 'Producto fantasma'
        importe    = '10.00'
        fecha      = sy-datum ).

      INSERT zpedido_02 FROM @ls_pedido_fantasma.

      IF sy-subrc = 0.
        out->write( |Ejer 3 - OJO: la BD ha permitido insertar un pedido para un cliente que ya no existe (no hay integridad referencial fisica)| ).
      ELSE.
        out->write( |Ejer 3 - No se ha podido insertar el pedido fantasma| ).
      ENDIF.

    ELSE.
      out->write( |Ejer 3 - Todos los clientes tienen al menos un pedido, borra uno manualmente para probar esto| ).
    ENDIF.

    out->write( '=========================================' ).


*   ==================================================================
*   Ejer 4 — Sube el importe a todos los pedidos de un cliente
*   ==================================================================
out->write( '=================== 4 ======================' ).

SELECT FROM zpedido_02
  FIELDS cliente_id, AVG( importe ) AS importe_medio
  WHERE cliente_id = '0001'
  GROUP BY cliente_id
  INTO TABLE @DATA(lt_avg_antes).

out->write( |Ejer 4 - Importe medio ANTES:| ).
out->write( lt_avg_antes ).


" --- Leer los pedidos del cliente, calcular el nuevo importe y actualizar ---
SELECT FROM zpedido_02
  FIELDS *
  WHERE cliente_id = '0001'
  INTO TABLE @DATA(lt_pedidos_cliente).

    LOOP AT lt_pedidos_cliente ASSIGNING FIELD-SYMBOL(<fs_pedido>).
      <fs_pedido>-importe = <fs_pedido>-importe * '1.1'.
    ENDLOOP.

    UPDATE zpedido_02 FROM TABLE @lt_pedidos_cliente.

    IF sy-subrc = 0.
      out->write( |Ejer 4 - Importes actualizados. Filas afectadas: { lines( lt_pedidos_cliente ) }| ).

*      out->write( 'TEST:'  ).
*      out->write( lt_pedidos_cliente  ).
    ELSE.
      out->write( |Ejer 4 - Error al actualizar importes| ).
    ENDIF.


    SELECT FROM zpedido_02
      FIELDS cliente_id, AVG( importe ) AS importe_medio
      WHERE cliente_id = '0001'
      GROUP BY cliente_id
      INTO TABLE @DATA(lt_avg_despues).

    out->write( |Ejer 4 - Importe medio DESPUES:| ).
    out->write( lt_avg_despues ).

out->write( '=========================================' ).

**   ==================================================================
**   Ejer 5 — El cliente fantasma
**   ==================================================================
out->write( '=================== 5 ======================' ).
    DATA(lv_cliente_falso) = '9999'.

    SELECT SINGLE FROM zcliente_02
      FIELDS cliente_id
      WHERE cliente_id = @lv_cliente_falso
      INTO @DATA(lv_cliente_encontrado).

    IF sy-subrc <> 0.
      out->write( |Ejer 5 - ok el cliente { lv_cliente_falso } no existe| ).
    ELSE.
      out->write( |Ejer 5 - cliente existe| ).
    ENDIF.

    DATA(ls_pedido_cliente_falso) = VALUE zpedido_02(
      client     = sy-mandt
      pedido_id  = '0097'
      cliente_id = lv_cliente_falso
      producto   = 'Producto sin dueño'
      importe    = '10.00'
      fecha      = sy-datum ).

    INSERT zpedido_02 FROM @ls_pedido_cliente_falso.

    IF sy-subrc = 0.
      out->write( |Ejer 5 - Insertado cliente no existe| ).
    ELSE.
      out->write( |Ejer 5 - No se ha podido insertar| ).
    ENDIF.

*    out->write( |Ejer 5 - Razonamiento: con INNER JOIN CLIENTE+PEDIDO, esta fila DESAPARECERIA| ).
*    out->write( |del resultado (no hay cliente que emparejar). Con LEFT OUTER JOIN desde PEDIDO hacia| ).
*    out->write( |CLIENTE, la fila del pedido se mantendria, pero nombre/ciudad saldrian vacios/NULL.| ).

    out->write( '=========================================' ).


**   ==================================================================
**   Ejer 6 — El cliente que más gasta
**   ==================================================================
out->write( '=================== 6 ======================' ).
    SELECT FROM zpedido_02 AS p
      INNER JOIN zcliente_02 AS c
        ON p~cliente_id = c~cliente_id
      FIELDS c~cliente_id, c~nombre, SUM( p~importe ) AS gasto_total
      GROUP BY c~cliente_id, c~nombre
      ORDER BY gasto_total DESCENDING
      INTO TABLE @DATA(lt_clientes_gasto)
      UP TO 1 ROWS.

    IF lines( lt_clientes_gasto ) > 0.
      DATA(ls_cliente_top) = lt_clientes_gasto[ 1 ].
      out->write( |Ejer 6 - Cliente que mas ha gastado: { ls_cliente_top-nombre } - Total: { ls_cliente_top-gasto_total }| ).
    ELSE.
      out->write( |Ejer 6 - No encontrado | ).
    ENDIF.

    out->write( '=========================================' ).


**   ==================================================================
**   Ejer 7 — Cambia el producto de un pedido y comprueba que el
**                 cliente sigue intacto
**   ==================================================================
out->write( '=================== 7 ======================' ).
    DATA(lv_pedido_id_ej7) = '0001'.

    SELECT SINGLE FROM zpedido_02
      FIELDS pedido_id, producto
      WHERE pedido_id = @lv_pedido_id_ej7
      INTO @DATA(ls_pedido_antes_ej7).

    out->write( |Ejer 7 - Producto ANTES: { ls_pedido_antes_ej7-producto }| ).

    UPDATE zpedido_02
      SET producto = 'Portatil (modelo actualizado)'
      WHERE pedido_id = @lv_pedido_id_ej7.

    IF sy-subrc = 0.
      out->write( |Ejer 7 - Actualizado| ).
    ELSE.
      out->write( |Ejer 7 - Error| ).
    ENDIF.

    SELECT FROM zpedido_02 AS p
      INNER JOIN zcliente_02 AS c
        ON p~cliente_id = c~cliente_id
      FIELDS p~pedido_id, p~producto, c~cliente_id, c~nombre
      WHERE p~pedido_id = @lv_pedido_id_ej7
      INTO TABLE @DATA(lt_verificacion_ej7).

    out->write( |Ejer 7 - Verificacion depues  UPDATE (el cliente deberia no estar igual):| ).
    out->write( lt_verificacion_ej7 ).

    out->write( '=========================================' ).


**   ==================================================================
**   Ejer 8 — La ciudad con más clientes
**   ==================================================================
out->write( '=================== 8 ======================' ).
    SELECT FROM zcliente_02
      FIELDS ciudad, COUNT(*) AS num_clientes
      GROUP BY ciudad
      ORDER BY num_clientes DESCENDING
      INTO TABLE @DATA(lt_ciudades)
      UP TO 1 ROWS.

    IF lines( lt_ciudades ) > 0.
      DATA(ls_ciudad_top) = lt_ciudades[ 1 ].
      out->write( |Ejer 8 - Ciudad con mas clientes: { ls_ciudad_top-ciudad } - Total: { ls_ciudad_top-num_clientes }| ).
    ELSE.
      out->write( |Ejer 8 - No se han encontrado datos| ).
    ENDIF.

    out->write( '=========================================' ).


**   ==================================================================
**   Ejer 9 — Borra un pedido y comprueba el rastro del cliente
**   ==================================================================
out->write( '=================== 9 ======================' ).
    DATA(lv_pedido_borrar) = '0002'.

    SELECT SINGLE FROM zpedido_02
      FIELDS pedido_id, cliente_id
      WHERE pedido_id = @lv_pedido_borrar
      INTO @DATA(ls_pedido_a_borrar).

    IF sy-subrc = 0.
      out->write( |Ejer 9 - Pedido elegido: { ls_pedido_a_borrar-pedido_id } - Cliente { ls_pedido_a_borrar-cliente_id }| ).

      DELETE FROM zpedido_02 WHERE pedido_id = @lv_pedido_borrar.

      IF sy-subrc = 0.
        out->write( |Ejer 9 - Pedido borrado ok| ).
      ELSE.
        out->write( |Ejer 9 - Error al borrar pedido| ).
      ENDIF.

      SELECT SINGLE FROM zcliente_02
        FIELDS cliente_id, nombre
        WHERE cliente_id = @ls_pedido_a_borrar-cliente_id
        INTO @DATA(ls_cliente_rastro).

      IF sy-subrc = 0.
        out->write( |Ejer 9 - ok: cliente { ls_cliente_rastro-nombre } sigue existiendo aunque ese pedido ya no| ).
      ELSE.
        out->write( |Ejer 9 - cliente no  existe| ).
      ENDIF.

    ELSE.
      out->write( |Ejer 9 - pedido no existe| ).
    ENDIF.

    out->write( '=========================================' ).


**   ==================================================================
**   Ejer 10 — El resumen completo de un cliente
**   ==================================================================
out->write( '=================== 10 ======================' ).
    DATA(lv_cliente_resumen) = '0001'.

    SELECT FROM zcliente_02 AS c
      INNER JOIN zpedido_02 AS p
        ON c~cliente_id = p~cliente_id
      FIELDS  c~nombre,
              c~ciudad,
              p~pedido_id,
              p~producto,
              p~importe,
              p~fecha
      WHERE c~cliente_id = @lv_cliente_resumen
      ORDER BY p~fecha ASCENDING
      INTO TABLE @DATA(lt_resumen_cliente).

    IF sy-subrc = 0.
      out->write( |Ejer 10 - listado  cliente { lv_cliente_resumen }:| ).
      out->write( lt_resumen_cliente ).

      DATA(lv_total_gastado) = REDUCE zpedido_02-importe(
        INIT total = 0
        FOR ls IN lt_resumen_cliente
        NEXT total = total + ls-importe ).

      out->write( |Ejer 10 - Total gastado por el cliente: { lv_total_gastado }| ).
    ELSE.
      out->write( |Ejer 10 - Cliente sin pedidos registrados| ).
    ENDIF.



**   ==================================================================
**   REINICIA TODO A ESTADO ANTERIOR por si se ejecuta varias veces,
**     otra opción es volver ejecutar el que crea la tabla
**   ==================================================================
out->write( '=================== RESET ======================' ).
"1"
*    UPDATE zcliente_02
*      SET ciudad = 'Sevilla'
*      WHERE cliente_id = '0001'.
*
*    IF sy-subrc = 0.
*      out->write( |Ejer 1 - UPDATE ok| ).
*    ELSE.
*      out->write( |Ejer 1 - Error update| ).
*    ENDIF.
*
*    SELECT SINGLE FROM zcliente_02
*      FIELDS *
*      WHERE cliente_id = '0001'
*      INTO @DATA(ls_cliente_despues1).
*"2"


  ENDMETHOD.
ENDCLASS.
