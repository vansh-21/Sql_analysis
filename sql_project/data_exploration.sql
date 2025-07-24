-- data exporation

-- column description 
describe zepto;

-- sample data
select * from zepto limit 10;

-- count of rows
select count(*) as total_rows from zepto;

-- null values
SELECT 
  SUM(CASE WHEN category IS NULL THEN 1 ELSE 0 END) AS null_category,
  SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS null_name,
  SUM(CASE WHEN mrp IS NULL THEN 1 ELSE 0 END) AS null_mrp,
  SUM(CASE WHEN discountPercent IS NULL THEN 1 ELSE 0 END) AS null_discountPercent,
  SUM(CASE WHEN availableQuantity IS NULL THEN 1 ELSE 0 END) AS null_availableQuantity,
  SUM(CASE WHEN discountedSellingPrice IS NULL THEN 1 ELSE 0 END) AS null_discountedSellingPrice,
  SUM(CASE WHEN weightInGms IS NULL THEN 1 ELSE 0 END) AS null_weightInGms,
  SUM(CASE WHEN outOfStock IS NULL THEN 1 ELSE 0 END) AS null_outOfStock,
  SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS null_quantity
FROM zepto;

-- unique categories
select distinct Category from zepto;

-- count of products out of stock
select outOfStock, count(sku_id) as product_count 
from zepto
group by outOfStock; 

-- product name out of stock
select Category, count(sku_id) as out_of_stock_items 
from zepto 
where outOfStock = "TRUE"
group by Category
order by out_of_stock_items desc;

-- product names present multiple times
SELECT name, COUNT(sku_id) AS "Number of SKUs"
FROM zepto
GROUP BY name
HAVING count(sku_id) > 1
ORDER BY count(sku_id) DESC;