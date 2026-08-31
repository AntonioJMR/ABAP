CLASS zcl_descuentos_tienda_02 DEFINITION

  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_descuentos_tienda_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.


    DATA(lv_importe)     = 750.
    DATA(lv_cliente_vip) = abap_true.

    " COND con inferencia de tipo '#',el tipo se infiere automáticamente como un entero (o el tipo del primer THEN)
    FINAL(lv_porcentaje) = COND #(
      WHEN lv_cliente_vip = abap_true AND lv_importe >= 1000 THEN 30
      WHEN lv_importe >= 1000                                THEN 20
      WHEN lv_importe >= 500                                 THEN 10
      WHEN lv_importe >= 200                                 THEN 5
      ELSE                                                        0
    ).



    DATA(lv_cant_descontada) = ( lv_importe * lv_porcentaje ) / 100.
    DATA(lv_importe_final)   = lv_importe - lv_cant_descontada.


    out->write( |Importe original:        { lv_importe } €| ).
    out->write( |Porcentaje de descuento: { lv_porcentaje } %| ).
    out->write( |Cantidad descontada:     { lv_cant_descontada } €| ).
    out->write( |Importe final:           { lv_importe_final } €| ).

  ENDMETHOD.
ENDCLASS.

