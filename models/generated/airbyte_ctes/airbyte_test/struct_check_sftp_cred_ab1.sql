{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_airbyte_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ ref('struct_check') }}
select
    _airbyte_struct_check_hashid,
    {{ json_extract_scalar('sftp_cred', ['hostname'], ['hostname']) }} as hostname,
    {{ json_extract_scalar('sftp_cred', ['password'], ['password']) }} as password,
    {{ json_extract_scalar('sftp_cred', ['port'], ['port']) }} as port,
    {{ json_extract_scalar('sftp_cred', ['username'], ['username']) }} as username,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('struct_check') }} as table_alias
-- sftp_cred at struct_check/sftp_cred
where 1 = 1
and sftp_cred is not null

