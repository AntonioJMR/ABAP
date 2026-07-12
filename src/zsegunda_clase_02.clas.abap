CLASS zsegunda_clase_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zsegunda_clase_02 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*
** 1. EJERCICIO SIMPLE
** Enunciado: Define con TYPES una estructura ty_producto (nombre, precio)
** y una tabla tt_productos de ese tipo. Declara las variables con DATA.
** Añade 3 productos con APPEND. Usa LOOP AT para recorrer la tabla y
** muestra con out->write( ) el nombre de cada producto.
** ====================================================================
*
*TYPES: BEGIN OF ty_producto,
*         nombre TYPE string,
*         precio TYPE p LENGTH 5 DECIMALS 2,
*       END OF ty_producto.
*
*
*DATA: lt_productos TYPE TABLE OF ty_producto.
*DATA: ls_producto  TYPE ty_producto.
*
*
*    ls_producto-nombre = 'Teclado M$'.
*    ls_producto-precio = '8.50'.
*    APPEND ls_producto TO lt_productos.
*
*
*    ls_producto-nombre = 'Ratón Óptico Ergonomico'.
*    ls_producto-precio = '21.99'.
*    APPEND ls_producto TO lt_productos.
*
*
*    ls_producto-nombre = 'Monitor 32"'.
*    ls_producto-precio = '249.99'.
*    APPEND ls_producto TO lt_productos.
*
*    ls_producto-nombre = 'TV para mundia 75'.
*    ls_producto-precio = '249.99'.
*    APPEND ls_producto TO lt_productos.
*
*
*    LOOP AT lt_productos INTO ls_producto.
*      out->write( ls_producto-nombre ).
*      out->write( ls_producto-precio ).
*    ENDLOOP.
*
*
**     2. EJERCICIO INTERMEDIO
** Enunciado: Define con TYPES una estructura ty_empleado (nombre, salario).
** Declara la tabla directamente en DATA. Añade 4 empleados.
** Usa LOOP AT para recorrer la tabla y, con un IF, muestra con
** out->write( ) solo el nombre de los que ganen más de 2000.
** ====================================================================
*
*
*TYPES: BEGIN OF ty_empleado,
*         nombre  TYPE string,
*         salario TYPE p LENGTH 6 DECIMALS 2,
*       END OF ty_empleado.
*
*DATA: lt_empleados TYPE TABLE OF ty_empleado,
*      ls_empleado  TYPE ty_empleado.
**DATA: ls_empleado  TYPE ty_empleado,
**lt_empleados TYPE TABLE OF ty_empleado WITH EMPTY KEY.
*
*
*    ls_empleado-nombre  = 'Ana'.
*    ls_empleado-salario = '1850.00'.
*    APPEND ls_empleado TO lt_empleados.
*
*
*    ls_empleado-nombre  = 'Luis'.
*    ls_empleado-salario = '2400.50'.
*    APPEND ls_empleado TO lt_empleados.
*
*
*    ls_empleado-nombre  = 'María'.
*    ls_empleado-salario = '3100.00'.
*    APPEND ls_empleado TO lt_empleados.
*
*
*    ls_empleado-nombre  = 'Pedro'.
*    ls_empleado-salario = '1950.00'.
*    APPEND ls_empleado TO lt_empleados.
*
*
*    LOOP AT lt_empleados INTO ls_empleado.
*
*      IF ls_empleado-salario > 2000.
*        out->write( '---2----' ).
*        out->write( ls_empleado-nombre ).
*      ENDIF.
*    ENDLOOP.
*
*
**    3. EJERCICIO DIFÍCIL
** Enunciado: Define ty_pedido (id_pedido, importe, estado).
** Declara la tabla directamente en DATA. Con DO 6 TIMES genera pedidos.
** CASE sobre vuelta MOD 3: 0 -> 'ENVIADO', 1 -> 'PENDIENTE', 2 -> 'CANCELADO'.
** APPEND a la tabla. Luego, LOOP AT para mostrar solo los 'PENDIENTE'
** con su importe, y al final muestra el total de pendientes con un contador.
** ====================================================================
*
*
*TYPES: BEGIN OF ty_pedido,
*         id_pedido TYPE i,
*         importe   TYPE p LENGTH 5 DECIMALS 2,
*         estado    TYPE string,
*       END OF ty_pedido.
*
*DATA lt_pedidos TYPE TABLE OF ty_pedido.
*DATA: ls_pedido  TYPE ty_pedido,
*
*
*      lv_vuelta       TYPE i VALUE 0,
*      lv_resto        TYPE i,
*      lv_cont_pend    TYPE i VALUE 0,
*      lv_texto_salida TYPE string.
*
*
*DO 6 TIMES.
*  CLEAR ls_pedido.
*
*
*  lv_vuelta = lv_vuelta + 1.
*  ls_pedido-id_pedido = lv_vuelta.
*
*
*  ls_pedido-importe   = lv_vuelta * '45.30'.
*
*
*  lv_resto = lv_vuelta MOD 3.
*  CASE lv_resto.
*    WHEN 0.
*      ls_pedido-estado = 'ENVIADO'.
*    WHEN 1.
*      ls_pedido-estado = 'PENDIENTE'.
*    WHEN 2.
*      ls_pedido-estado = 'CANCELADO'.
*  ENDCASE.
*
*
*  APPEND ls_pedido TO lt_pedidos.
*ENDDO.
*
*
*LOOP AT lt_pedidos INTO ls_pedido.
*  IF ls_pedido-estado = 'PENDIENTE'.
*
*    lv_cont_pend = lv_cont_pend + 1.
*
**        lv_texto_salida = |Pedido ID: { ls_pedido-id_pedido } - Importe: { ls_pedido-importe }|.
**        out->write( lv_texto_salida ).
*    out->write( ls_pedido-estado ).
*    out->write( ls_pedido-importe ).
*    out->write( ls_pedido-id_pedido ).
*  ENDIF.
*ENDLOOP.
*
**    lv_texto_salida = |Total de pedidos en estado PENDIENTE: { lv_cont_pend }|.
*
*
*out->write( lv_texto_salida ).
*

"hazme un bucle sencillo que imprima los números del 1 al 100 creado variables nuevas no te bases en nada anterior
DATA: lv_numero TYPE i VALUE 1,
          lv_texto  TYPE string.

    WHILE lv_numero <= 100.
      lv_texto = lv_numero.
      out->write( lv_texto ).
      lv_numero = lv_numero + 1.
    ENDWHILE.



  ENDMETHOD.
ENDCLASS.
