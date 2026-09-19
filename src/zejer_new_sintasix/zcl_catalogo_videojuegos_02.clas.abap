CLASS zcl_catalogo_videojuegos_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_catalogo_videojuegos_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

      TYPES: BEGIN OF ty_videojuego,
             titulo     TYPE string,
             plataforma TYPE string,
             precio     TYPE i,
           END OF ty_videojuego.

*    TYPES tt_videojuegos TYPE STANDARD TABLE OF ty_videojuego WITH DEFAULT KEY.
*    DATA lt_videojuegos TYPE  tt_videojuego.

    DATA lt_videojuegos TYPE TABLE OF ty_videojuego.

    lt_videojuegos = VALUE #(
        ( titulo = 'Minecraft' plataforma = 'PC'     precio = 30 )
        ( titulo = 'Zelda'     plataforma = 'Switch' precio = 60 )
        ( titulo = 'FIFA'      plataforma = 'PS5'    precio = 70 )
    ).

    out->write( lt_videojuegos ).

  ENDMETHOD.
ENDCLASS.

