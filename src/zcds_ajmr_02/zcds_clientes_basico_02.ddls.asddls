@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'zcds_clientes_basico_02 AJMR 02'
@Metadata.ignorePropagatedAnnotations: true

//## Ejercicio 1 — Nivel Básico
//
//*Objetivo:* primer contacto con un CDS view simple, sin joins ni agregación.
//
//Dentro del mismo paquete, crea un CDS view entity llamado zcds_clientes_basico que:
//
//- Seleccione de la tabla /DMO/CUSTOMER (clientes).
//- Muestre el ID de cliente, nombre (first_name, last_name), ciudad (city) y país (country_code).
//- Añade las anotaciones básicas de cabecera.
//- Sin JOIN, sin agregación: solo selección directa de campos.


define view entity zcds_clientes_basico_02 as select from /dmo/customer
{
    key customer_id as CustomerId,
        concat_with_space( first_name,  last_name , 1) as Nombe, //Concatenacion
        postal_code as PostalCode,
        city as City,
        country_code as CountryCode          
}


///////////////////////////////////  EJEMPLO LUISCA usando tabla vista que no se podia,/////////////////////////////////////////////////////////////

//@AbapCatalog.viewEnhancementCategory: [#NONE]
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'CDS Básico de Clientes'
//@Metadata.ignorePropagatedAnnotations: true
//define view entity zcds_clientes_basico_00
//  as select from /dmo/customer as c
//   inner join I_CountryText as t
//   on c.country_code = t.Country
//{
//  c.customer_id                                as Identificador,
//  concat_with_space( c.first_name, c.last_name, 1 ) as Nombre,
//  c.city as Ciudad, 
//  c.country_code as CodPais,
//  t.CountryName as NombrePais
//} where t.Language = 'S'
