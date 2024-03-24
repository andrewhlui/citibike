{% macro all_files(stage) %}

{# 
    Returns all files in a given path in a Snowflake stage in a specific folder structure. Useful for pulling data directly from S3 or Azure Blob.
#}

{% set list_files_sql %}
list {{ stage }};
{% endset %}

{% set file_list = run_query(list_files_sql) %}

{# check that there's actually something in the stage/key; throw error if there isn't #}
{% if results == [] and execute %}
    {{ exceptions.raise_compiler_error("Did not find any files in " ~ stage ~ ", please check spelling or case.") }}
{% endif %}

{# todo: add pattern handling to arguments #}
{{ return(stage) }}

{% endmacro %}