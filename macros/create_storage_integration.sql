{% macro create_storage_integration(integration_name, storage_aws_role_arn, storage_allowed_locations) %}

{% set storage_integration_sql %}
create or replace storage integration {{ integration_name }}_integration
  type = external_stage
  storage_provider = 'S3'
  enabled = true
  storage_aws_role_arn = '{{ storage_aws_role_arn }}'
  storage_allowed_locations = (
    '{{ storage_allowed_locations }}'
  )
{% endset %}

{% set file_list = run_query(storage_integration_sql) %}

{% endmacro %}