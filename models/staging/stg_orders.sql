select 
--from raw orders
o.orderid,
o.orderdate,
o.shipdate,
o.shipmode,
o.ordersellingprice - o.ordercostprice as orderprofit,
o.ordercostprice,
o.ordersellingprice,
--from raw_customer
c.customerid,
c.customername,
c.segment,
c.country,
--from raw_product
p.category,
p.productid,
p.productname,
p.subcategory,
{{ markup('ordersellingprice','ordercostprice') }} as markup,
d.delivery_team
from {{ ref('raw_orders') }} as o
left join {{ ref('raw_customer') }} as c
on o.customerid = c.customerid
left join {{ ref('raw_product') }} as p
on o.productid = p.productid
left join {{ ref('delivery_team')}} as d
on o.shipmode = d.shipmode