**3. Enunciado para que los alumnos practiquen
**Ejercicio — Pedido recibido desde un sistema externo
**
**Crea una clase ejecutable ABAP en Eclipse utilizando:
**
**if_oo_adt_classrun
**
**Imagina que un sistema externo envía determinados datos en formato texto.
**
**Declara las siguientes variables:
**
**DATA(lv_precio_texto)   = 125.
**DATA(lv_cantidad_texto) = 4.
**
**Aunque contienen números, ambas variables son textos.
**
**Debes:
**
**Convertir lv_precio_texto a un número entero utilizando CONV.
**Convertir lv_cantidad_texto a un número entero utilizando CONV.
**Calcular el importe total de la compra.
**Mostrar mediante out->write( ):
**Precio original como texto.
**Precio convertido.
**Cantidad original como texto.
**Cantidad convertida.
**Importe total.
**
**No se permite declarar previamente las variables numéricas asignándoles directamente los textos.
**
**La conversión debe realizarse expresamente mediante:
**
**CONV i( ... )
**Reto adicional
**
**Añade:
**
**DATA(lv_descuento_texto) = 10.
**
**Este valor representa un porcentaje de descuento.
**
**Convierte también el descuento mediante CONV.
**
**Después calcula:
**
**importe bruto
**descuento aplicado
**importe final
**
**y muestra los tres resultados con out->write( ).
**
**Segundo reto
**
**Añade:
**
**DATA(lv_edad_texto) = 17.
**
**Convierte la edad a entero y utiliza COND para obtener:
**
**Mayor de edad
**
**o:
**
**Menor de edad
**
**De esta forma ya combinan dos conceptos:
**
**CONV → transformar el tipo
**COND → decidir el resultado


CLASS zcl_conversion_tipos_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_conversion_tipos_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    "text
    DATA(lv_precio_texto)    = '125'.
    DATA(lv_cantidad_texto)  = '4'.

    DATA(lv_descuento_texto) = '10'.
    DATA(lv_edad_texto)      = '17'.

    "int
    DATA(lv_precio_num)     = CONV i( lv_precio_texto ).
    DATA(lv_cantidad_num)   = CONV i( lv_cantidad_texto ).
    DATA(lv_descuento_num)  = CONV i( lv_descuento_texto ).

    "calculado
    DATA(lv_importe_bruto)      = lv_precio_num * lv_cantidad_num.
    DATA(lv_descuento_aplicado) = ( lv_importe_bruto * lv_descuento_num ) / 100.
    DATA(lv_importe_final)      = lv_importe_bruto - lv_descuento_aplicado.
    "calculado
    lv_importe_bruto      = lv_precio_num * lv_cantidad_num.
    lv_descuento_aplicado = ( CONV i( lv_precio_texto ) * CONV i( lv_descuento_texto ) ) / 100.
    lv_importe_final      = lv_importe_bruto - lv_descuento_aplicado.

    out->write( |-----------------------------------------------------| ).
    out->write( |Precio Texto:   { lv_precio_texto }   -> Convertido: { lv_precio_num }| ).
    out->write( |Cantidad Texto: { lv_cantidad_texto }   -> Convertida: { lv_cantidad_num }| ).
    out->write( |-----------------------------------------------------| ).
    out->write( |Importe Bruto:       { lv_importe_bruto } €| ).
    out->write( |Descuento Aplicado:  { lv_descuento_aplicado } € ({ lv_descuento_num }%)| ).
    out->write( |Importe Final:       { lv_importe_final } €| ).
    out->write( |-----------------------------------------------------| ).



    " convertir en el sitio o usamos la variable  convertida
    DATA(lv_edad_num) = CONV i( lv_edad_texto ).

    DATA(lv_resultado_edad) = COND string(
      WHEN lv_edad_num >= 18
      THEN 'Mayor de edad'
      ELSE 'Menor de edad'
    ).

    out->write( |Edad recibida: { lv_edad_texto } años -> Resultado: { lv_resultado_edad }| ).
    out->write( |-----------------------------------------------------| ).

  ENDMETHOD.
ENDCLASS.


