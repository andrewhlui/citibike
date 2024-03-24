{% macro create_stage(stage_name, integration_name, file_format) %}

{% set stage_sql %}
create stage {{ target.database }}.{{ target.schema }}.{{ stage_name }}_stage
  storage_integration = {{ integration_name }}
  url = 's3://{{ env_var("aws_bucket_name") }}/{{ stage_name }}/'
  file_format = {{ file_format }};
{% endset %}

{{ log('Beginning creation of stages.') }}
{% set results = run_query(stage_sql) %}
{{ log(results) }}


{% endmacro %}