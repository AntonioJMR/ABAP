@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZJUEGO_02'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_JUEGO_02
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_JUEGO_02
  association [1..1] to ZR_JUEGO_02 as _BaseEntity on $projection.ID = _BaseEntity.ID
{
  key ID,
  Jugador1,
  Jugador2,
  Resultado,
  @Semantics: {
    User.Createdby: true
  }
  CreatedBy,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  CreatedAt,
  @Semantics: {
    User.Lastchangedby: true
  }
  LastChangedBy,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LastChangedAt,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LocalLastChangedAt,
  _BaseEntity
}
