{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_airbyte_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('struct_check_path_to_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_struct_check_hashid',
        'disnt',
        'it',
    ]) }} as _airbyte_path_to_hashid,
    tmp.*
from {{ ref('struct_check_path_to_ab2') }} tmp
-- path_to at struct_check/path_to
where 1 = 1

