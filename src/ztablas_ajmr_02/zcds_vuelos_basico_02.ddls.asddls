@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ajmr 02 CDS'
@Metadata.ignorePropagatedAnnotations: true


//// EJER 1

//define view entity zcds_vuelos_basico_02 as select from /dmo/carrier
//{
//     key carrier_id,
//     name               as nombre,
//     currency_code      as nombre_local
//
//}
//

//// EJER 2

//define view entity zcds_vuelos_basico_02
//  with parameters
//    p_fecha : abap.dats
//
//  as select from /dmo/flight  as f
//    inner join   /dmo/carrier as c on f.carrier_id = c.carrier_id
//{
//  key c.name                              as nombre_aerolinea,
//      count(*)                            as total_vuelos,
//      @Semantics.amount.currencyCode: 'moneda'
//      avg( f.price as abap.curr( 16, 2 )) as precio_medio,
//       @Semantics.amount.currencyCode: 'moneda'
//      max( f.price )                      as precio_maximo,
//       @Semantics.amount.currencyCode: 'moneda'
//      min( f.price )                      as precio_minimo,
//      f.currency_code as moneda
//}
//
//where
//  substring( cast( f.flight_date as abap.char(8) ), 1, 4 ) = $parameters.p_fecha
//
//group by
//  c.name,
//  f.currency_code


//// EJER 3

define view entity zcds_vuelos_basico_02
  with parameters
    p_fecha : abap.dats

  as select from /dmo/booking as b

  association [1..1] to /dmo/customer as _Customer
    on b.customer_id = _Customer.customer_id

{
  key b.customer_id                                          as cliente_id,

      count(*)                                                as num_reservas,

      @Semantics.amount.currencyCode: 'moneda'
      cast( sum( b.flight_price ) as abap.curr( 16,2 ) )      as importe_total_reservado,

      case
        when sum( b.flight_price ) < 1000                     then 'Ocasional'
        when sum( b.flight_price ) between 1000 and 5000      then 'Frecuente'
        else 'VIP'
      end                                                      as tipo_cliente,

      b.currency_code                                         as moneda,

      _Customer

}

where
  b.booking_date > $parameters.p_fecha

group by
  b.customer_id,
  b.currency_code
