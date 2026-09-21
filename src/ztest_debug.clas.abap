CLASS ztest_debug DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS ztest_debug IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "hazme un bucle sencillo del 1 al 10
    DATA(i) = 1.

    WHILE i <= 10.
      out->write( i ).
      i = i + 1.
    ENDWHILE.

  ENDMETHOD.
ENDCLASS.
