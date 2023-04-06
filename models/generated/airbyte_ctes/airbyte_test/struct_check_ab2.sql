{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_airbyte_test",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('struct_check_ab1') }}
select
    cast(updated_at as {{ dbt_utils.type_string() }}) as updated_at,
    cast(path_to as {{ type_json() }}) as path_to,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    {{ cast_to_boolean('active') }} as active,
    cast(created_at as {{ dbt_utils.type_string() }}) as created_at,
    cast(_id as {{ dbt_utils.type_string() }}) as _id,
    {{ cast_to_boolean('is_central_plaza') }} as is_central_plaza,
    cast(ban_id as {{ dbt_utils.type_string() }}) as ban_id,
    cast(sftp_cred as {{ type_json() }}) as sftp_cred,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('struct_check_ab1') }}
-- struct_check
where 1 = 1

