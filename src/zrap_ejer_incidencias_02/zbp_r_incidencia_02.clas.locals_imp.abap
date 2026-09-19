CLASS LHC_ZR_INCIDENCIA_02 DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZrIncidencia02
        RESULT result,
      CerrarIncidencia FOR MODIFY
            keys FOR ACTION ZrIncidencia02~CerrarIncidencia RESULT result.

          METHODS InicializarIncidencia FOR DETERMINE ON MODIFY
            keys FOR ZrIncidencia02~InicializarIncidencia.
ENDCLASS.

CLASS LHC_ZR_INCIDENCIA_02 IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.

  METHOD CerrarIncidencia.

      MODIFY ENTITIES OF ZR_INCIDENCIA_02 IN LOCAL MODE
        ENTITY ZrIncidencia02
        UPDATE FIELDS ( Estado FechaCierre )
        WITH VALUE #(
          FOR key IN keys
            ( %tky = key-%tky
              Estado = 'C'
              FechaCierre = cl_abap_context_info=>get_system_date( ) )
        ).

  ENDMETHOD.

  METHOD InicializarIncidencia.

      READ ENTITIES OF ZR_INCIDENCIA_02 IN LOCAL MODE
        ENTITY ZrIncidencia02
        FIELDS ( Estado FechaAlta )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_incidencias).

      MODIFY ENTITIES OF ZR_INCIDENCIA_02 IN LOCAL MODE
        ENTITY ZrIncidencia02
        UPDATE FIELDS ( Estado FechaAlta )
        WITH VALUE #(
          FOR ls_incidencia IN lt_incidencias
            ( %tky = ls_incidencia-%tky

              Estado = COND #(
                WHEN ls_incidencia-Estado IS INITIAL
                THEN 'N'
                ELSE ls_incidencia-Estado )

              FechaAlta = COND #(
                WHEN ls_incidencia-FechaAlta IS INITIAL
                THEN cl_abap_context_info=>get_system_date( )
                ELSE ls_incidencia-FechaAlta )
            )
        ).
  ENDMETHOD.

ENDCLASS.
