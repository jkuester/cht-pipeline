-- add any indexes specific to this form
{%- set form_indexes = []-%}
-- add columns specific to this form
{% set form_columns %}
  couchdb.doc->'fields' ->> 'hello' AS hello
END AS jkuester
{% endset %}

-- call the macro with the form name, the columns and indexes to create the actual model
{{ cht_form_model('jkuester', form_columns, form_indexes) }}
