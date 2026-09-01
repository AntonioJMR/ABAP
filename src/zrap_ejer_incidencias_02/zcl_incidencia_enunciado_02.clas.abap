CLASS zcl_incidencia_enunciado_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_incidencia_enunciado_02 IMPLEMENTATION.
ENDCLASS.

**19/08/2026
**
**# Práctica: Gestión de incidencias con RAP
**
**## Objetivo
**
**Desarrollar una aplicación SAP Fiori Elements para gestionar incidencias internas utilizando
**ABAP Cloud y RAP.
**
**El desarrollo debe partir de una tabla transparente y terminar en una aplicación OData V4 con:
**
**- altas, modificaciones y borradores;
**- presentación personalizada;
**- una determinación automática;
**- una acción de negocio sencilla.
**
**Cada alumno utilizará sus dos dígitos asignados en lugar de XX.
**
**---
**
**## 1. Modelo de datos
**
**Crear la tabla transparente:
**
**text
**ZINCIDENCIA_XX
**
**
**La tabla debe contener los siguientes campos funcionales:
**
**| Campo | Tipo recomendado | Descripción |
**|---|---|---|
**| client | abap.clnt | Mandante |
**| id_incidencia | abap.char(10) | Identificador y clave |
**| titulo | abap.char(60) | Título de la incidencia |
**| descripcion | abap.char(255) | Descripción detallada |
**| categoria | abap.char(2) | Categoría |
**| prioridad | abap.char(1) | Prioridad |
**| estado | abap.char(1) | Estado |
**| responsable | abap.char(40) | Persona responsable |
**| fecha_alta | abap.dats | Fecha de creación funcional |
**| fecha_limite | abap.dats | Fecha límite |
**| fecha_cierre | abap.dats | Fecha de cierre |
**
**Valores permitidos para la prioridad:
**
**text
**B = Baja
**M = Media
**A = Alta
**
**
**Valores previstos para el estado:
**
**text
**N = Nueva
**P = En proceso
**C = Cerrada
**
**
**Añadir también los campos administrativos requeridos por RAP:
**
**| Campo | Elemento de datos |
**|---|---|
**| created_by | abp_creation_user |
**| created_at | abp_creation_tstmpl |
**| last_changed_by | abp_lastchange_user |
**| local_last_changed_at | abp_locinst_lastchange_tstmpl |
**| last_changed_at | abp_lastchange_tstmpl |
**
**La tabla debe ser dependiente de mandante, de categoría transparente y con clase de entrega #A.
**
**---
**
**## 2. Generación del Business Object
**
**Utilizar el asistente RAP para generar una aplicación a partir de ZINCIDENCIA_XX.
**
**El escenario debe tener estas características:
**
**- implementación managed;
**- soporte de borradores;
**- servicio para interfaz de usuario;
**- protocolo OData V4;
**- aplicación basada en Fiori Elements.
**
**Utilizar una nomenclatura coherente para distinguir:
**
**text
**Tabla de persistencia
**Tabla draft
**CDS Root
**Behavior Definition raíz
**Behavior Pool
**CDS Projection
**Projection Behavior
**Metadata Extension
**Service Definition
**Service Binding
**
**
**Publicar el Service Binding y comprobar que la aplicación permite:
**
**- crear una incidencia;
**- guardar el borrador;
**- editarla;
**- activarla;
**- eliminarla.
**
**---
**
**## 3. Reglas de los campos
**
**Modificar la Behavior Definition raíz para conseguir lo siguiente:
**
**- IdIncidencia debe ser obligatorio al crear.
**- Titulo debe ser obligatorio al crear.
**- IdIncidencia no se puede modificar después de crear la incidencia.
**- Los campos administrativos deben ser de solo lectura.
**- FechaCierre debe ser de solo lectura para el consumidor, porque será calculada por la
**lógica de negocio.
**
**Comprobar en Fiori qué campos aparecen como obligatorios y cuáles no se pueden editar.
**
**---
**
**## 4. Personalización de la interfaz
**
**Modificar la Metadata Extension para que la lista principal muestre únicamente:
**
**1. Identificador.
**2. Título.
**3. Categoría.
**4. Prioridad.
**5. Estado.
**6. Responsable.
**7. Fecha límite.
**
**Los campos administrativos no deben aparecer en la lista principal ni en la barra de filtros.
**
**La barra de filtros debe contener:
**
**- identificador;
**- título;
**- categoría;
**- prioridad;
**- estado;
**- responsable.
**
**La página de detalle debe organizarse en dos secciones:
**
**### Información general
**
**- identificador;
**- título;
**- descripción;
**- categoría;
**- prioridad;
**- estado;
**- responsable.
**
**### Fechas
**
**- fecha de alta;
**- fecha límite;
**- fecha de cierre.
**
**La cabecera del objeto debe mostrar:
**
**text
**Título principal: Titulo
**Descripción: IdIncidencia
**
**
**La lista inicial debe aparecer ordenada por prioridad y, a continuación, por fecha límite.
**
**Utilizar etiquetas comprensibles para el usuario. No deben mostrarse nombres técnicos
**como IdIncidencia o FechaLimite.
**
**---
**
**## 5. Determinación automática
**
**Crear una determinación llamada:
**
**text
**InicializarIncidencia
**
**
**Debe ejecutarse al crear una incidencia.
**
**Su comportamiento será:
**
**- Si Estado está vacío, asignar N.
**- Si FechaAlta está vacía, asignar la fecha actual.
**
**La lógica debe implementarse en la Behavior Pool utilizando EML.
**
**La determinación debe trabajar con todas las instancias recibidas, sin asumir que siempre
**llegará una única incidencia.
**
**Después de implementarla, crear una incidencia sin informar estado ni fecha de alta
**y comprobar que ambos valores se calculan automáticamente.
**
**---
**
**## 6. Acción de negocio
**
**Crear una acción llamada:
**
**text
**CerrarIncidencia
**
**
**La acción debe modificar la incidencia seleccionada:
**
**text
**Estado      = C
**FechaCierre = fecha actual
**
**
**La acción debe:
**
**- estar declarada en la Behavior Definition raíz;
**- implementarse en la Behavior Pool;
**- exponerse en la Projection Behavior;
**- mostrarse como botón en la aplicación mediante la Metadata Extension.
**
**El botón debe aparecer con el texto:
**
**text
**Cerrar incidencia
**
**
**Ejecutar la acción sobre una incidencia y comprobar que se actualizan el estado y la fecha de cierre.
**
**---
**
**## 7. Comprobaciones finales
**
**La aplicación se considerará terminada cuando cumpla estas pruebas:
**
**1. Se puede crear una incidencia mediante draft.
**2. Identificador y título son obligatorios.
**3. El identificador no puede modificarse posteriormente.
**4. Los campos administrativos no aparecen en la interfaz principal.
**5. Al crear, el estado inicial se establece en N.
**6. Al crear, la fecha de alta se completa automáticamente.
**7. La acción CerrarIncidencia establece el estado en C.
**8. La acción informa automáticamente la fecha de cierre.
**9. Las columnas, filtros y secciones respetan el diseño solicitado.
**10. La aplicación continúa funcionando mediante el Service Binding OData V4.
**
**---
**
**## Preguntas para el alumnado
**
**Al finalizar, cada alumno debe poder explicar:
**
**1. ¿Qué diferencia existe entre la tabla activa y la tabla draft?
**2. ¿Qué responsabilidad tiene la CDS Root?
**3. ¿Qué diferencia existe entre la Behavior Definition raíz y la Projection Behavior?
**4. ¿Dónde se declara una determinación y dónde se programa?
**5. ¿Por qué la implementación utiliza EML en lugar de modificar directamente la tabla?
**6. ¿Qué responsabilidad tiene la Metadata Extension?
**7. ¿Qué diferencia existe entre una determinación y una acción?
**8. ¿Qué función cumplen la Service Definition y el Service Binding?



