@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZPENALTIS_02'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_PENALTIS_02
  as select from ZPENALTIS_02
{
  key num_lanzamiento as NumLanzamiento,
  lanzador as Lanzador,
  direccion_disparo as DireccionDisparo,
  portero as Portero,
  direccion_portero as DireccionPortero,
  resultado as Resultado,
  @Semantics.user.createdBy: true
  createdby as Createdby,
  @Semantics.systemDateTime.createdAt: true
  createdat as Createdat,
  @Semantics.user.localInstanceLastChangedBy: true
  localinstancelastchangedby as Localinstancelastchangedby,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  localinstancelastchangedat as Localinstancelastchangedat,
  @Semantics.systemDateTime.lastChangedAt: true
  lastchangedat as Lastchangedat
}
