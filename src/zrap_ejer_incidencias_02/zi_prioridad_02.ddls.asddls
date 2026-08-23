@EndUserText.label: 'Ayuda de valores - Prioridad'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZI_PRIORIDAD_02
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T(
    p_domain_name: 'ZDE_PRIORIDAD_02'
  )
{
  @UI.hidden: true
  key domain_name    as DomainName,
  @UI.hidden: true
  key value_position as ValuePosition,
  @UI.hidden: true
  key language       as Language,
  @EndUserText.label: 'Prioridad'
  @ObjectModel.text.element: [ 'Description' ]
  value_low          as PriorityLevel,
  @EndUserText.label: 'Descripción'
  @Semantics.text: true
  text               as Description
}
where language = $session.system_language
