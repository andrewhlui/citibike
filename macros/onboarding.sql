{% macro onboarding() %}

{{ create_integration(
    integration_name = 'citibike'
    storage_aws_role_arn = env_var("STORAGE_AWS_ROLE_ARN"), 
    storage_allowed_locations = env_var("STORAGE_ALLOWED_LOCATIONS") }}
{{ create_format() }}
{{ create_stage(
    stage_name = 'citibike', 
    integration_name = 'citibike', 
    file_format = 'csv_gzip_format'
    ) }}

{% endmacro %}