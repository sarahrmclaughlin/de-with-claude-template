-- Drop tables if they exist (for fresh runs)
DROP TABLE IF EXISTS subscriptions;
DROP TABLE IF EXISTS plans;

-- ============================================================================
-- CREATE TABLES
-- ============================================================================

-- Plans table: pricing tiers
CREATE TABLE plans (
    plan_id INT PRIMARY KEY,
    plan_name VARCHAR,
    monthly_price DECIMAL(10, 2)
);

-- Subscriptions table: customer subscriptions with lifecycle dates
CREATE TABLE subscriptions (
    subscription_id INT PRIMARY KEY,
    customer_id INT,
    plan_id INT,
    status VARCHAR,
    created_at TIMESTAMP,
    canceled_at TIMESTAMP,
    FOREIGN KEY (plan_id) REFERENCES plans(plan_id)
);

-- ============================================================================
-- INSERT SAMPLE DATA
-- ============================================================================

-- Insert plans
INSERT INTO plans VALUES
    (1, 'Starter', 29.00),
    (2, 'Professional', 79.00),
    (3, 'Enterprise', 199.00),
    (4, 'Premium', 149.00);

-- Insert subscriptions with realistic SaaS lifecycle patterns
INSERT INTO subscriptions VALUES
    -- Created in January 2025 - all still active
    (1001, 101, 1, 'active', '2025-01-05 10:30:00', NULL),
    (1002, 102, 2, 'active', '2025-01-12 14:15:00', NULL),
    (1003, 103, 3, 'active', '2025-01-20 09:45:00', NULL),
    (1004, 104, 1, 'active', '2025-01-28 16:20:00', NULL),
    
    -- Created in February 2025
    (1005, 105, 2, 'active', '2025-02-03 11:00:00', NULL),
    (1006, 106, 1, 'active', '2025-02-15 13:30:00', NULL),
    (1007, 107, 4, 'active', '2025-02-22 10:10:00', NULL),
    
    -- Created in March 2025
    (1008, 108, 3, 'active', '2025-03-05 08:45:00', NULL),
    (1009, 109, 2, 'active', '2025-03-18 15:20:00', NULL),
    (1010, 110, 1, 'active', '2025-03-25 12:00:00', NULL),
    
    -- Created in April 2025 (before cutoff date)
    (1011, 111, 2, 'active', '2025-04-01 09:30:00', NULL),
    (1012, 112, 4, 'active', '2025-04-10 14:45:00', NULL),
    
    -- Canceled subscriptions (should NOT appear in results)
    (1013, 113, 1, 'canceled', '2025-01-10 10:00:00', '2025-02-15 10:00:00'),
    (1014, 114, 2, 'canceled', '2025-02-05 11:00:00', '2025-03-10 11:00:00'),
    
    -- Inactive subscriptions (should NOT appear in results)
    (1015, 115, 3, 'inactive', '2025-01-01 08:00:00', NULL),
    
    -- Created after cutoff (should NOT appear in results)
    (1016, 116, 1, 'active', '2026-04-02 10:00:00', NULL);

-- ============================================================================
-- EDA QUERY: 
-- ============================================================================
select * from plans limit 100;
select * from subscriptions limit 100;
-- ============================================================================
-- MAIN QUERY: MRR Analysis
-- ============================================================================

SELECT 
    DATE_TRUNC('month', s.created_at) AS month,
    COUNT(DISTINCT s.subscription_id) AS active_subscriptions,
    SUM(p.monthly_price) AS mrr,
    AVG(p.monthly_price) AS avg_subscription_price
FROM subscriptions s
INNER JOIN plans p ON s.plan_id = p.plan_id
WHERE s.status = 'active'
    AND s.created_at <= '2026-03-31'
    AND s.canceled_at IS NULL
GROUP BY DATE_TRUNC('month', s.created_at)
ORDER BY month DESC;

-- ============================================================================
-- SUPPORTING QUERIES FOR LEARNING
-- ============================================================================

-- View all subscriptions with plan details (useful for debugging)
SELECT 
    s.subscription_id,
    s.customer_id,
    p.plan_name,
    p.monthly_price,
    s.status,
    s.created_at,
    s.canceled_at
FROM subscriptions s
INNER JOIN plans p ON s.plan_id = p.plan_id
ORDER BY s.created_at DESC;

-- Count active vs canceled subscriptions
SELECT 
    status,
    COUNT(*) as count
FROM subscriptions
GROUP BY status;

-- MRR breakdown by plan (bonus analysis)
SELECT 
    p.plan_name,
    COUNT(DISTINCT s.subscription_id) AS subscription_count,
    SUM(p.monthly_price) AS plan_mrr,
    AVG(p.monthly_price) AS avg_price
FROM subscriptions s
INNER JOIN plans p ON s.plan_id = p.plan_id
WHERE s.status = 'active'
    AND s.created_at <= '2026-03-31'
    AND s.canceled_at IS NULL
GROUP BY p.plan_name
ORDER BY plan_mrr DESC;




