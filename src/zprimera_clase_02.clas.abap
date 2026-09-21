CLASS zprimera_clase_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zprimera_clase_02 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

        TYPES: BEGIN OF ty_pedido,
             id_pedido    TYPE i,
             importe      TYPE p LENGTH 5  DECIMALS 2,
             tipo_cliente TYPE string,
           END OF ty_pedido.


        DATA: ls_pedido  TYPE ty_pedido,
              lt_pedidos TYPE TABLE OF ty_pedido,
              lv_vuelta  TYPE i VALUE 0,
              lv_resto   TYPE i.

*           5 iteracion
        DO 5 TIMES.

          " de  de 1 a 5)
          lv_vuelta = lv_vuelta + 1.

          ls_pedido-id_pedido = lv_vuelta.
          ls_pedido-importe   = lv_vuelta * '120.75'.

          " cacl par
          lv_resto = lv_vuelta MOD 2.

          CASE lv_resto.
            WHEN 0.
              "PAr
              ls_pedido-tipo_cliente = 'PREMIUM'.
            WHEN OTHERS.
              " impar
              ls_pedido-tipo_cliente = 'ESTANDAR'.
          ENDCASE.


          APPEND ls_pedido TO lt_pedidos.

        ENDDO.

        out->write( 'endDo' && lv_vuelta ).

  ENDMETHOD.
ENDCLASS.
