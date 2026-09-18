@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZINCIDENCIA_02'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_INCIDENCIA_02
  as select from ZINCIDENCIA_02
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
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.lastChangedBy: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt
}
