{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_airbyte_test",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('airbyte_test', '_airbyte_raw_struct_check') }}
select
    {{ json_extract_scalar('_airbyte_data', ['updated_at'], ['updated_at']) }} as updated_at,
    {{ json_extract('table_alias', '_airbyte_data', ['path_to'], ['path_to']) }} as path_to,
    {{ json_extract_scalar('_airbyte_data', ['name'], ['name']) }} as name,
    {{ json_extract_scalar('_airbyte_data', ['active'], ['active']) }} as active,
    {{ json_extract_scalar('_airbyte_data', ['created_at'], ['created_at']) }} as created_at,
    {{ json_extract_scalar('_airbyte_data', ['_id'], ['_id']) }} as _id,
    {{ json_extract_scalar('_airbyte_data', ['is_central_plaza'], ['is_central_plaza']) }} as is_central_plaza,
    {{ json_extract_scalar('_airbyte_data', ['ban_id'], ['ban_id']) }} as ban_id,
    {{ json_extract('table_alias', '_airbyte_data', ['sftp_cred'], ['sftp_cred']) }} as sftp_cred,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('airbyte_test', '_airbyte_raw_struct_check') }} as table_alias
-- struct_check
where 1 = 1

