@EndUserText.label: 'Ayuda de valores - Estado'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZI_ESTADOVH_02
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T(
    p_domain_name: 'ZDE_ESTADO_02'
  )
{
  @UI.hidden: true
  key domain_name    as DomainName,
  @UI.hidden: true
  key value_position as ValuePosition,
  @UI.hidden: true
  key language       as Language,
  @EndUserText.label: 'Estado'
  @ObjectModel.text.element: [ 'Description' ]
  value_low          as StatusValue,
  @EndUserText.label: 'Descripción'
  @Semantics.text: true
  text               as Description
}
where language = $session.system_language
