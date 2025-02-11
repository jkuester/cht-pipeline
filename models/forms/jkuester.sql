-- add any indexes specific to this form
{%- set form_indexes = [{'columns': ['edd']}]-%}
-- add columns specific to this form
{% set form_columns %}
  couchdb.doc->'fields' ->> 'risk_factors' AS risk_factors,

  -- extract the ANC visit number
  CASE
    WHEN couchdb.doc->'fields' ->>'anc_visit_identifier' <> ''
      THEN (couchdb.doc->'fields' ->>'anc_visit_identifier')::int
    WHEN couchdb.doc->'fields' #>>'{group_repeat,anc_visit_repeat,anc_visit_identifier}' <> ''
      THEN RIGHT(couchdb.doc->'fields' #>>'{group_repeat,anc_visit_repeat,anc_visit_identifier}'::text[], 1)::int
    ELSE 0 -- if not included default to 0
END AS anc_visit
{% endset %}

-- call the macro with the form name, the columns and indexes to create the actual model
{{ cht_form_model('jkuester', form_columns, form_indexes) }}
