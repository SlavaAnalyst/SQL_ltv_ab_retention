--Расчет выручки по результатам А/В теста

SELECT
  PARSE_DATE('%Y%m%d', event_date),
  CASE user_properties.value.string_value
    WHEN "0" THEN "Baseline"
    WHEN "1" THEN "Variant A"
    WHEN "2" THEN "Variant B"
END
  AS experiment_variant,
  --event_name,
  COUNT(*) AS count,
  SUM(event_params.value.double_value) AS revenue
FROM
  `analytics_327717448.events_*`,
  UNNEST(user_properties) AS user_properties,
  UNNEST(event_params) AS event_params
WHERE
  (_TABLE_SUFFIX BETWEEN '20230317'
    AND '20230322')
  AND user_properties.key = "firebase_exp_4"
  --AND event_name = 'paid_ad_impression'
GROUP BY
  experiment_variant
  ,event_date
ORDER BY 
    experiment_variant, PARSE_DATE('%Y%m%d', event_date)