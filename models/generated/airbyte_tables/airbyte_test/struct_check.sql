{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "airbyte_test",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='struct_check_scd'
                        )
                    %}
                    {%
                        if scd_table_relation is not none
                    %}
                    {%
                            do adapter.drop_relation(scd_table_relation)
                    %}
                    {% endif %}
                        "],
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('struct_check_ab3') }}
select
    updated_at,
    path_to,
    name,
    active,
    created_at,
    _id,
    is_central_plaza,
    ban_id,
    sftp_cred,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_struct_check_hashid
from {{ ref('struct_check_ab3') }}
-- struct_check from {{ source('airbyte_test', '_airbyte_raw_struct_check') }}
where 1 = 1

