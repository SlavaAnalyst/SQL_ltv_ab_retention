--Топ-10 стран по доходу и LTV по ним за промежуток с 2023-02-27 по 2023-03-19. 


SELECT
  geo.country AS country,
  COUNT(DISTINCT user_pseudo_id) AS number_users,
  SUM(event_params.value.double_value) AS revenue, --gross_profit
  SUM(event_params.value.double_value) / COUNT(DISTINCT user_pseudo_id) AS ltv
FROM
  `memory-cleaner-junk-removal.analytics_327717448.events_*`,
  UNNEST(event_params) AS event_params
WHERE 
  (_TABLE_SUFFIX BETWEEN '20230227' AND '20230319')
  AND event_name = 'paid_ad_impression'
GROUP BY
  geo.country
ORDER BY
  revenue DESC
LIMIT
  10