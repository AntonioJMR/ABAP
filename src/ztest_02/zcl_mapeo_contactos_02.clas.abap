CLASS zcl_mapeo_contactos_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .


    TYPES: BEGIN OF ty_empleado,
             id           TYPE i,
             nombre       TYPE string,
             email        TYPE string,
             telefono     TYPE string,
             departamento TYPE string,
             salario      TYPE i,
           END OF ty_empleado.
    TYPES tt_empleados TYPE STANDARD TABLE OF ty_empleado WITH DEFAULT KEY.

    TYPES: BEGIN OF ty_contacto,
             id       TYPE i,
             nombre   TYPE string,
             email    TYPE string,
             telefono TYPE string,
           END OF ty_contacto.
    TYPES tt_contactos TYPE STANDARD TABLE OF ty_contacto WITH DEFAULT KEY.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mapeo_contactos_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " Inicializa
    DATA(lt_empleados) = VALUE tt_empleados(
        ( id = 1 nombre = 'Ana García'   email = 'ana@empresa.es'
			telefono = '111111111' departamento = 'Desarrollo'     salario = 28000 )
        ( id = 2 nombre = 'Carlos Pérez' email = 'carlos@empresa.es'
			telefono = '222222222' departamento = 'Ventas'         salario = 32000 )
        ( id = 3 nombre = 'Marta López'  email = 'marta@empresa.es'
			telefono = '333333333' departamento = 'Administración' salario = 26000 )
    ).

    " AL LLAMARSE IGUAL: Solo necesitas pasar la tabla origen dentro de los paréntesis.
    " ABAP hace la inferencia y el emparejamiento automático por debajo.
    DATA(lt_contactos) = CORRESPONDING tt_contactos( lt_empleados ).


    out->write( '--- TABLA DE EMPLEADOS (ORIGEN) ---' ).
    out->write( lt_empleados ).

    out->write( '--- TABLA DE CONTACTOS (DESTINO AUTOMÁTICO) ---' ).
    out->write( lt_contactos ).

  ENDMETHOD.
ENDCLASS.
** Si no se llaman IGUAL debemos hacer como el siguiente codigo




**CLASS zcl_mapeo_contactos_02 DEFINITION
**  PUBLIC
**  FINAL
**  CREATE PUBLIC .
**
**  PUBLIC SECTION.
**    INTERFACES if_oo_adt_classrun .
**
**
**    TYPES: BEGIN OF ty_empleado,
**             id           TYPE i,
**             nombre       TYPE string,
**             email        TYPE string,
**             telefono     TYPE string,
**             departamento TYPE string,
**             salario      TYPE i,
**           END OF ty_empleado.
**    TYPES tt_empleados TYPE STANDARD TABLE OF ty_empleado WITH DEFAULT KEY.
**
**
**    TYPES: BEGIN OF ty_contacto_ext,
**             id_contacto     TYPE i,      " id
**             nombre_completo TYPE string, " nombre
**             email           TYPE string, " Se mantiene
**             telefono_movil  TYPE string, " telefono
**           END OF ty_contacto_ext.
**    TYPES tt_contactos_ext TYPE STANDARD TABLE OF ty_contacto_ext WITH DEFAULT KEY.
**
**  PROTECTED SECTION.
**  PRIVATE SECTION.
**ENDCLASS.
**
**
**
**CLASS zcl_mapeo_contactos_02 IMPLEMENTATION.
**
**  METHOD if_oo_adt_classrun~main.
**
**
**    DATA(lt_empleados) = VALUE tt_empleados(
**        ( id = 2 nombre = 'Carlos Pérez' email = 'carlos@empresa.es'
**			telefono = '222222222' departamento = 'Ventas'         salario = 32000 )
**        ( id = 3 nombre = 'Marta López'  email = 'marta@empresa.es'
**			telefono = '333333333' departamento = 'Administración' salario = 26000 )
**        ( id = 1 nombre = 'Ana García'   email = 'ana@empresa.es'
**			telefono = '111111111' departamento = 'Desarrollo'     salario = 28000 )
**    ).
**
**    " 2º tabla desde la anterior
**    " Conversión explícita aplicando la cláusula MAPPING
**    " Estructura: CORRESPONDING tipo_destino( origen MAPPING campo_destino = campo_origen )
**    DATA(lt_contactos_ext) = CORRESPONDING tt_contactos_ext(
**      lt_empleados MAPPING id_contacto     = id
**                           nombre_completo = nombre
**                           telefono_movil  = telefono
**    ).
**
**    " 4. Muestra de resultados por consola
**    out->write( '--- TABLA DE EMPLEADOS (ORIGEN) ---' ).
**    out->write( lt_empleados ).
**
**    out->write( '--- TABLA DE CONTACTOS EXTERNOS (DESTINO CON MAPPING) ---' ).
**    out->write( lt_contactos_ext ).
**
**  ENDMETHOD.
**ENDCLASS.
**

