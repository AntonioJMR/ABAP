@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZPENALTIS_02'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_PENALTIS_02
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_PENALTIS_02
  association [1..1] to ZR_PENALTIS_02 as _BaseEntity on $projection.NUMLANZAMIENTO = _BaseEntity.NUMLANZAMIENTO
{
  key NumLanzamiento,
  Lanzador,
  DireccionDisparo,
  Portero,
  DireccionPortero,
  Resultado,
  @Semantics: {
    User.Createdby: true
  }
  Createdby,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  Createdat,
  @Semantics: {
    User.Localinstancelastchangedby: true
  }
  Localinstancelastchangedby,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  Localinstancelastchangedat,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  Lastchangedat,
  _BaseEntity
}
