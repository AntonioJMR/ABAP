CLASS zcl_aleatorio_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_aleatorio_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA(lo_random) = cl_abap_random_int=>create( min = 0
                                                  max = 10 ).

    DATA(lv_aleatorio) = lo_random->get_next(  ).

    out->write( lv_aleatorio ).



  ENDMETHOD.
ENDCLASS.
