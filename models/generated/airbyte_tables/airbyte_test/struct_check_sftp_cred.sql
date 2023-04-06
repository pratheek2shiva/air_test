{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "airbyte_test",
    post_hook = ["
                    {%
                        set scd_table_relation = adapter.get_relation(
                            database=this.database,
                            schema=this.schema,
                            identifier='struct_check_sftp_cred_scd'
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
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('struct_check_sftp_cred_ab3') }}
select
    _airbyte_struct_check_hashid,
    hostname,
    password,
    port,
    username,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_sftp_cred_hashid
from {{ ref('struct_check_sftp_cred_ab3') }}
-- sftp_cred at struct_check/sftp_cred from {{ ref('struct_check') }}
where 1 = 1

