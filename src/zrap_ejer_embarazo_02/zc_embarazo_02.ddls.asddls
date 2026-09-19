@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZEMBARAZO_02'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_EMBARAZO_02
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_EMBARAZO_02
  association [1..1] to ZR_EMBARAZO_02 as _BaseEntity on $projection.IDSEGUIMIENTO = _BaseEntity.IDSEGUIMIENTO
{
  key IdSeguimiento,
  NombrePaciente,
  FechaUltimaRegla,
  FechaProbableParto,
  SemanaGestacion,
  GrupoSanguineo,
  FactorRh,
  NivelRiesgo,
  Estado,
  PesoActual,
  @Consumption: {
    Valuehelpdefinition: [ {
      Entity.Element: 'UnitOfMeasure', 
      Entity.Name: 'I_UnitOfMeasureStdVH', 
      Useforvalidation: true
    } ]
  }
  UnidadPeso,
  ProximaRevision,
  Observaciones,
  @Semantics: {
    User.Createdby: true
  }
  CreatedBy,
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
