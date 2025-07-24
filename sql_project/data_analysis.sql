-- data cleaning

-- removing product with price and dsp = 0
select * from zepto
where mrp = 0 or discountedSellingPrice = 0;

Delete from zepto
where mrp = 0 or discountedSellingPrice = 0;

-- convert paise to rupee
update zepto
set mrp = mrp / 100,
discountedSellingPrice = discountedSellingPrice / 100;

select mrp, discountedSellingPrice from zepto;

-- data analysis

-- 1.sales analysis

-- total sales revenue
select round(sum(quantity * discountedSellingPrice), 2) as net_revenue from zepto;

-- discount impact analysis
select round(discountPercent, -1) as discount_bracket, sum(quantity) as total_sold
from zepto
group by discount_bracket
order by discount_bracket;

-- total revenue for each Category
select Category, sum(discountedSellingPrice * quantity) as revenue
from zepto
group by Category
order by revenue desc;

-- categories with highest average discount percentage
select Category, round(avg(discountPercent), 2) as avg_discount
from zepto
group by Category
order by avg_discount desc
limit 5;

-- 2.Inventory analysis

-- total inventory value (current stock)
select round(sum(availableQuantity * discountedSellingPrice), 2) as current_invetory_value 
from zepto;

-- out of stock summary
select Category, count(*) as total_product, 
sum(case when outOfStock = "TRUE" then 1 else 0 end) as out_of_stock_count,
round(sum(case when outOfStock = "TRUE" then 1 else 0 end) / count(*) * 100, 2) as out_of_stock_rate
from zepto
group by Category
order by out_of_stock_rate desc;

-- products with high mrp but out of stock
select name as Name, mrp
from zepto
where outOfStock = "TRUE"
order by mrp Desc;

-- slow moving inventory
select name, Category, availableQuantity, quantity
from zepto
where quantity < 3 and availableQuantity > 5
order by availableQuantity desc;

-- stock vs sales ratio
select 
  Category,
  sum(availableQuantity) as total_stock,
  sum(quantity) as total_sold,
  round(sum(availableQuantity) / nullif(sum(quantity), 0), 2) as stock_to_sales_ratio
from zepto
group by Category
order by stock_to_sales_ratio desc;