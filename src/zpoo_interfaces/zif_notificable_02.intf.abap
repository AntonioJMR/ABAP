INTERFACE zif_notificable_02
  PUBLIC.

  METHODS notificar
    IMPORTING
      iv_mensaje TYPE string.

  METHODS consultar_coste_envio
    RETURNING
      VALUE(rv_coste) TYPE zdecimals2.

ENDINTERFACE.

