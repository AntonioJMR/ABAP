@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK


//## Ejercicio 3 — Nivel Avanzado
//
//*Objetivo:* association, CASE con condiciones, parámetro y anotaciones semánticas.
//
//Crea un CDS view entity llamado zcds_conexiones_avanzado que:
//
//- Parta de /DMO/CONNECTION (conexiones de vuelo, ruta entre aeropuertos) y use una association (no JOIN)
//hacia /DMO/CARRIER para acceder al nombre de la aerolínea.
//- Reciba un parámetro p_distancia (tipo abap.dec(9,2)... o abap.int4 si preferís simplificar) para filtrar
//  solo conexiones con distancia superior a la indicada.
//- Calcule, agrupado por aeropuerto de origen (airport_from_id):
//  - Distancia media de las conexiones (avg).
//  - Número de conexiones (count).
//- Añada un campo calculado tipo_ruta con un CASE (sin campo delante) que clasifique la ruta según la distancia media:
//  - Menos de 1000 → 'Corta'
//  - Entre 1000 y 5000 → 'Media'
//  - Más de 5000 → 'Larga'
//- Expón la asociación _Carrier en la proyección para que el nombre de la aerolínea sea accesible desde fuera de la vista.
//
//---
//
//*Progresión pedagógica igual que antes:* de simple
//selección → join + parámetro + agregación → association + CASE + parámetro + semántica de moneda/distancia.
//Así refuerzan el mismo patrón con tablas y contexto distintos (clientes/agencias/conexiones en vez de vuelos/reservas).


define view entity zcds_conexiones_avanzado_02
  with parameters
    p_distancia : abap.int4

  as select from /dmo/connection as co
    inner join   /dmo/carrier    as ca on co.carrier_id = ca.carrier_id

{
  key co.airport_from_id                     as aeropuerto_origen,

      ca.name                                as nombre_aerolinea,

      count(*)                               as num_conexiones,

      avg( co.distance as abap.dec( 10,0 ) ) as distancia_media_avg,

      case
        when avg( co.distance as abap.dec( 10,0 ) ) < 1000                       then 'Corta'
        when avg( co.distance as abap.dec( 10,0 ) ) between 1000 and 5000        then 'Media'
    //  when avg( co.distance as abap.dec( 10,0 ) ) <= 5000                      then 'Media'
        else 'Larga'
      end                                    as tipo_ruta

}
where
  co.distance > $parameters.p_distancia

group by
  co.airport_from_id,
  ca.name
