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
    {{ json_extract_scalar('path_to', ['disnt'], ['disnt']) }} as disnt,
    {{ json_extract_scalar('path_to', ['it'], ['it']) }} as it,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('struct_check') }} as table_alias
-- path_to at struct_check/path_to
where 1 = 1
and path_to is not null

