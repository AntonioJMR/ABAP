# ABAP

# Aprendiendo ABAP (Advanced Business Application Programming)

¡Bienvenido/a a mi repositorio de aprendizaje de ABAP! Este espacio dedicado a mi aprendizaje en el lenguaje de programación de SAP. Aquí guardo ejercicios, proyectos prácticos, apuntes y snippets de código desde los conceptos más básicos hasta temas avanzados.

---

##  Objetivos del Repositorio
*   Comprender la arquitectura de **SAP NetWeaver** y el entorno de desarrollo (GUI y ADT en Eclipse).
*   Dominar la sintaxis clásica de ABAP y las **nuevas expresiones de sintaxis moderna (7.40+)**.
*   Aprender a interactuar con la base de datos mediante **Open SQL**.
*   Desarrollar reportes, formularios y comprender la programación orientada a objetos (ABAP OO).

---

## Estructura del Proyecto

El repositorio está organizado por módulos de aprendizaje para mantener el código limpio y localizable:
<!--
```text
├── 01-fundamentos/          # Tipos de datos, variables, estructuras de control
├── 02-estructuras-datos/    # Tablas internas, estructuras, áreas de trabajo
├── 03-base-datos/           # Operaciones CRUD, Open SQL, joins y subqueries
├── 04-modularizacion/       # Subrutinas (FORM), módulos de función, bapis
├── 05-reportes/             # Reportes clásicos, interactivos y ALV (SAP List Viewer)
├── 06-abap-oo/              # Clases, interfaces, herencia y polimorfismo
└── 07-sintaxis-moderna/     # Expresiones condicionales, constructores (VALUE, REDUCE, FILTER)
```

---
-->
##  Entorno de Desarrollo y Herramientas
Para escribir y probar el código de este repositorio utilizo:
*   **Eclipse (ADT):** [Indica cuál usas, por ejemplo: *ABAP Development Tools en Eclipse*]
*   **Sistema SAP:** [Indica tu entorno, por ejemplo: *SAP AS ABAP 7.52 SP04 Developer Edition / SAP BTP ABAP Environment*]
*   **Control de Versiones:** **abapGit** (para exportar el código del sistema SAP a texto plano).

---
<!--
##  Ejemplos Destacados

### 1. Sintaxis Clásica vs Moderna
Un ejemplo de cómo he ido evolucionando mi código aplicando la sintaxis de ABAP 7.40+:

**Estilo Clásico:**
```abap
DATA: lt_usuarios TYPE TABLE OF ty_usuarios,
      ls_usuario  TYPE ty_usuarios.

READ TABLE lt_usuarios INTO ls_usuario WITH KEY id = '100'.
IF sy-subrc = 0.
  " Procesar datos
ENDIF.
```

**Estilo Moderno (7.40+):**
```abap
ASSIGN lt_usuarios[ id = '100' ] TO FIELD-SYMBOL(<fs_usuario>).
IF sy-subrc = 0.
  " Procesar datos directamente con el Field Symbol
ENDIF.
```

---
-->
##  Recursos Útiles
Enlaces y documentación que utilizo como referencia:
*   [SAP Help Portal](https://sap.com) - Documentación oficial de SAP.
*   [ABAP Keyword Documentation](https://sap.comdoc/abapdocu_latest_index_htm/latest/en-US/index.htm) - Diccionario de palabras clave.
*   [openSAP](https://sap.com) / [SAP Learning](https://sap.com) - Cursos gratuitos oficiales.

---

## 👤 Autor
*   **Antonio**
<!--
*   LinkedIn: [@TuUsuario](https://linkedin.com)
*   SAP Community: [@TuPerfil](https://sap.com)
-->
---
⭐️ ¡Si te resulta útil este material o estás aprendiendo ABAP como yo, no dudes en darle una estrella al repositorio. Gracias!
