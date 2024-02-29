WITH sales_agg_region AS (
    SELECT
        dim_employee.sk_employee,
        dim_address.territory_name AS region,
        COUNT(DISTINCT fct_orders.sales_order_id) AS total_orders_handled,
        SUM(fct_orders.order_qty) AS total_products_sold,
        SUM(fct_orders.product_total) AS total_sales_value,
        AVG(fct_orders.order_total) AS avg_order_value
    FROM {{ ref('fct_orders') }} AS fct_orders
    JOIN {{ ref('dim_employee') }} AS dim_employee
        ON fct_orders.sk_employee = dim_employee.sk_employee
    JOIN {{ ref('dim_address') }} AS dim_address
        ON fct_orders.sk_address = dim_address.sk_address
    GROUP BY dim_employee.sk_employee, dim_address.territory_name
)

SELECT
    sales_agg_region.sk_employee,
    sales_agg_region.region,
    dim_employee.full_name,
    sales_agg_region.total_orders_handled,
    sales_agg_region.total_products_sold,
    ROUND(sales_agg_region.total_sales_value, 2) AS total_sales,
    ROUND(sales_agg_region.avg_order_value, 2) AS avg_order_value
FROM sales_agg_region
JOIN {{ ref('dim_employee') }} AS dim_employee
    ON sales_agg_region.sk_employee = dim_employee.sk_employee
ORDER BY sales_agg_region.region, total_sales DESC

