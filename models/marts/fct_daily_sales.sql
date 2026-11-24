with items as (
    select *
    from {{ ref('stg_order_items') }}
    where status not in ('Cancelled', 'Returned')
),

products as (
    select product_id, cost
    from {{ ref('stg_products') }}
)

select
    date(items.created_at)                         as order_date,
    count(distinct items.order_id)                 as orders,
    count(*)                                       as items_sold,
    round(sum(items.sale_price), 2)                as revenue,
    round(sum(items.sale_price - products.cost), 2) as gross_profit
from items
left join products using (product_id)
group by order_date