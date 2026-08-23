CLASS zcl_test_ascensor_02_ejem DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_TEST_ASCENSOR_02_EJEM IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA(lo_ascensor) = NEW zcl_ascensor_00(
                                i_planta_maxima = 7
                                i_peso_maximo = 300 ).

    data(lo_ascensor2) = NEW zcl_ascensor_00(
                                i_planta_maxima = 17
                                i_peso_maximo = 1000 ).

    lo_ascensor->entrar_peso( 200 ).
*    lo_ascensor->entrar_peso( 200 ).
    lo_ascensor->subir_a_planta( 5 ).

    lo_ascensor->entrar_peso( 50 ).

    lo_ascensor->vaciar( ).


  ENDMETHOD.
ENDCLASS.
