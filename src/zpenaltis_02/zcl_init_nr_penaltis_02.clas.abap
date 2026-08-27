CLASS zcl_init_nr_penaltis_02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

ENDCLASS.


CLASS zcl_init_nr_penaltis_02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA:
      lv_object   TYPE cl_numberrange_objects=>nr_attributes-object,
      lt_interval TYPE cl_numberrange_intervals=>nr_interval,
      ls_interval TYPE cl_numberrange_intervals=>nr_nriv_line.

    lv_object = 'ZR_PENA_02'.

    ls_interval-nrrangenr  = '01'.
    ls_interval-fromnumber = '001'.
    ls_interval-tonumber   = '999'.
    ls_interval-procind    = 'I'.

    APPEND ls_interval TO lt_interval.

    TRY.

        cl_numberrange_intervals=>create(
          EXPORTING
            interval  = lt_interval
            object    = lv_object
            subobject = ' '
          IMPORTING
            error     = DATA(lv_error)
            error_inf = DATA(ls_error)
            error_iv  = DATA(lt_error_iv)
            warning   = DATA(lv_warning)
        ).

        IF lv_error = abap_true.

          out->write(
            |Error al crear el intervalo 01 del Number Range|
          ).

        ELSE.

          out->write(
            |Number Range ZNR_PENALTIS_02 creado correctamente|
          ).

        ENDIF.

      CATCH cx_root INTO DATA(lx_error).

        out->write(
          |Error: { lx_error->get_text( ) }|
        ).

    ENDTRY.

  ENDMETHOD.

ENDCLASS.
