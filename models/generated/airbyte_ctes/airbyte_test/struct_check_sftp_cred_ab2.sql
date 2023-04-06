{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "_airbyte_airbyte_test",
    tags = [ "nested-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('struct_check_sftp_cred_ab1') }}
select
    _airbyte_struct_check_hashid,
    cast(hostname as {{ dbt_utils.type_string() }}) as hostname,
    cast(password as {{ dbt_utils.type_string() }}) as password,
    cast(port as {{ dbt_utils.type_string() }}) as port,
    cast(username as {{ dbt_utils.type_string() }}) as username,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('struct_check_sftp_cred_ab1') }}
-- sftp_cred at struct_check/sftp_cred
where 1 = 1

