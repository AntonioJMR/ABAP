CLASS zcl_ficha_publica_02 DEFINITION

  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .

    " 1. Definición de las estructuras requeridas
    TYPES: BEGIN OF ty_usuario,
             id_usuario      TYPE i,
             nombre_completo TYPE string,
             correo          TYPE string,
             telefono        TYPE string,
             password        TYPE string,
             salario         TYPE i,
           END OF ty_usuario.

    TYPES: BEGIN OF ty_ficha_publica,
             id       TYPE i,
             nombre   TYPE string,
             email    TYPE string,
             telefono TYPE string,
             salario  TYPE i,
           END OF ty_ficha_publica.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ficha_publica_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    "origen
    DATA(ls_usuario) = VALUE ty_usuario(
        id_usuario      = 101
        nombre_completo = 'Luis Carlos Pérez'
        correo          = 'luis@formacion.es'
        telefono        = '666555444'
        password        = 'AbapModerno2026_#'
        salario         = 45000
    ).

    " 3. Convertir con CORRESPONDING usando MAPPING y EXCEPT
    DATA(ls_ficha_publica) = CORRESPONDING ty_ficha_publica(
      ls_usuario MAPPING id     = id_usuario
                         nombre = nombre_completo
                         email  = correo
*                         telefono = telefono "No es necesario hacer MAPPING pq ya lo hace implicito CoRRESPONDING
                 EXCEPT  salario   "Lo ponemos pq CORRESPONDING lo forzaria a meter al llamarse igual que de la tabla ORIGEN
    ).


    out->write( '--- DATOS DEL USUARIO INTERNO (ORIGEN) ---' ).
    out->write( ls_usuario ).

    out->write( '--- FICHA PÚBLICA GENERADA (DESTINO) ---' ).
    out->write( ls_ficha_publica ).

  ENDMETHOD.
ENDCLASS.


