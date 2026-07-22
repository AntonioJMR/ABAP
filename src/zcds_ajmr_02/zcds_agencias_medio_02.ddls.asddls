
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK

//## Ejercicio 2 — Nivel Medio
//
//*Objetivo:* join entre tablas + agregación + parámetro de entrada.
//
//Crea un CDS view entity llamado zcds_agencias_medio que:
//
//- Haga un INNER JOIN entre /DMO/TRAVELAGENCY (agencias de viaje) y /DMO/BOOKING (reservas), 
//  a través del campo de agencia común.
//- Reciba un parámetro p_pais (tipo abap.char(3)) para filtrar agencias de un país concreto (country_code).
//- Muestre, agrupado por nombre de agencia:
//  - Número total de reservas gestionadas (count).
//  - Importe medio de las reservas (avg).
//  - Importe total gestionado (sum), con su anotación de moneda correspondiente.
//- Filtra usando where con el parámetro p_pais.


define view entity zcds_agencias_medio_02
  with parameters
    p_pais : abap.char(3)

  as select from /dmo/agency  as a
    inner join   /dmo/travel  as t on a.agency_id = t.agency_id
    inner join   /dmo/booking as b on t.travel_id = b.travel_id
{
  key a.name                                        as nombre_agencia,

      count(*)                                      as num_reservas,

      @Semantics.amount.currencyCode: 'moneda'
      avg(  b.flight_price  as abap.curr( 16,2 )  ) as importe_medio,

      @Semantics.amount.currencyCode: 'moneda'
      sum( b.flight_price)                          as importe_total,

      b.currency_code                               as moneda

}
where
  a.country_code = $parameters.p_pais

group by
  a.name,
  b.currency_code
