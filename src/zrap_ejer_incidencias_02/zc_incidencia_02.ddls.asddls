@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZINCIDENCIA_02'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_INCIDENCIA_02
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_INCIDENCIA_02
  association [1..1] to ZR_INCIDENCIA_02 as _BaseEntity on $projection.IDINCIDENCIA = _BaseEntity.IDINCIDENCIA
{
  key IdIncidencia,
  Titulo,
  Descripcion,
  Categoria,
  Prioridad,
  Estado,
  Responsable,
  FechaAlta,
  FechaLimite,
  FechaCierre,
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
    Systemdatetime.Localinstancelastchangedat: true
  }
  LocalLastChangedAt,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LastChangedAt,
  _BaseEntity
}
