CLASS ztest DEFINITION

  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS ztest IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    out->write(  ' HOLA WORLD!!' ).

    "** -----------------------------------

*    ASSERT 1 = 2.

    DATA lv_texto TYPE string VALUE 'HOLA MUNDO!!'.
    DATA lv_numero TYPE i VALUE 1.

    WHILE lv_numero < 8.
      out->write( lv_texto ).
      lv_numero = lv_numero + 1.
    ENDWHILE.

  ENDMETHOD.
ENDCLASS.
