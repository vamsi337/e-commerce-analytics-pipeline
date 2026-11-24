select
    order_id,
    user_id,
    status,
    num_of_item,
    created_at,
    shipped_at,
    delivered_at,
    returned_at
from {{ source('thelook', 'orders') }}