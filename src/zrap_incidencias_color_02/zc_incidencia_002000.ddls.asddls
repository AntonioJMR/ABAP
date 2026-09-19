@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZINCIDENCIA_002'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_INCIDENCIA_002000
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_INCIDENCIA_002000
  association [1..1] to ZR_INCIDENCIA_002000 as _BaseEntity on $projection.IDINCIDENCIA = _BaseEntity.IDINCIDENCIA
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
    User.Localinstancelastchangedby: true
  }
  LastChangedBy,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LastChangedAt,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LocalLastChangedAt,
  _BaseEntity
}
