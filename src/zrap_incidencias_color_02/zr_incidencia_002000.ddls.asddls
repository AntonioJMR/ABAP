@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZINCIDENCIA_002'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_INCIDENCIA_002000
  as select from ZINCIDENCIA_002
{
  key id_incidencia as IdIncidencia,
  titulo as Titulo,
  descripcion as Descripcion,
  categoria as Categoria,
  prioridad as Prioridad,
  estado as Estado,
  responsable as Responsable,
  fecha_alta as FechaAlta,
  fecha_limite as FechaLimite,
  fecha_cierre as FechaCierre,
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.user.localInstanceLastChangedBy: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  last_changed_at as LastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  local_last_changed_at as LocalLastChangedAt
}
