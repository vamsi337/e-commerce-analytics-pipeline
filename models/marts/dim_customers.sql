with users as (
    select * from {{ ref('stg_users') }}
),

order_totals as (
    select
        user_id,
        count(distinct order_id)  as total_orders,
        round(sum(sale_price), 2) as lifetime_value,
        min(created_at)           as first_order_at,
        max(created_at)           as last_order_at
    from {{ ref('stg_order_items') }}
    where status not in ('Cancelled', 'Returned')
    group by user_id
)

select
    users.user_id,
    users.country,
    users.age,
    users.gender,
    users.traffic_source,
    users.signed_up_at,
    coalesce(order_totals.total_orders, 0)   as total_orders,
    coalesce(order_totals.lifetime_value, 0) as lifetime_value,
    order_totals.first_order_at,
    order_totals.last_order_at
from users
left join order_totals using (user_id)