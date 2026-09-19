CLASS zcl_prueba_examen_00__ DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_prueba_examen_00__ IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    data(lo_connection) = new zcl_1717_connections( ).

    out->write( lo_connection->get_connections( i_departure = 'HAV' ) ).

  ENDMETHOD.

ENDCLASS.
