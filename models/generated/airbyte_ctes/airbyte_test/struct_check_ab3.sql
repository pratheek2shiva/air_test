{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_airbyte_test",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('struct_check_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'updated_at',
        object_to_string('path_to'),
        'name',
        boolean_to_string('active'),
        'created_at',
        '_id',
        boolean_to_string('is_central_plaza'),
        'ban_id',
        object_to_string('sftp_cred'),
    ]) }} as _airbyte_struct_check_hashid,
    tmp.*
from {{ ref('struct_check_ab2') }} tmp
-- struct_check
where 1 = 1

