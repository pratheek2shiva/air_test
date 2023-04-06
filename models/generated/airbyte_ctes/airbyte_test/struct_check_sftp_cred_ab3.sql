{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_airbyte_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('struct_check_sftp_cred_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        '_airbyte_struct_check_hashid',
        'hostname',
        'password',
        'port',
        'username',
    ]) }} as _airbyte_sftp_cred_hashid,
    tmp.*
from {{ ref('struct_check_sftp_cred_ab2') }} tmp
-- sftp_cred at struct_check/sftp_cred
where 1 = 1

