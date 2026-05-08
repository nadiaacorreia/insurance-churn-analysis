-- Early cancellation rate by campaign

SELECT 
    campaign_flag,
    AVG(CASE WHEN customer_tenure_days < 90 THEN 1.0 ELSE 0.0 END) AS early_cancel_rate
FROM cancellations
GROUP BY campaign_flag;


-- Cancellation reasons distribution by campaign

SELECT 
    campaign_flag,
    cancellation_category,
    COUNT() * 1.0 / SUM(COUNT()) OVER (PARTITION BY campaign_flag) AS percentage
FROM cancellations
GROUP BY campaign_flag, cancellation_category
ORDER BY campaign_flag, percentage DESC;


-- Early cancellation rate by product type

SELECT
    product_type,
    campaign_flag,
    AVG(CASE WHEN customer_tenure_days < 90 THEN 1.0 ELSE 0.0 END) AS early_cancel_rate
FROM cancellations
GROUP BY product_type, campaign_flag
ORDER BY product_type;