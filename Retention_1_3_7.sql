WITH user_activity AS (
	SELECT
		l.user_id AS user_id,
		FROM_UNIXTIME(l.installed_at, '%Y-%m-%d') AS installed_at,
		FROM_UNIXTIME(r.created_at, '%Y-%m-%d') AS created_at

	FROM
		user AS l
	LEFT JOIN client_session AS r
		ON l.user_id = r.user_id
	)

SELECT
	DATE_TRUNC('month', installed_at) AS cohort_month,
	COUNT(DISTINCT user_id) AS total_installed,
	SUM(CASE WHEN DATEDIFF(created_at, installed_at) BETWEEN 1 AND 1 THEN 1 ELSE 0 END) AS retention_1day,
	SUM(CASE WHEN DATEDIFF(created_at, installed_at) BETWEEN 3 AND 3 THEN 1 ELSE 0 END) AS retention_3day,
	SUM(CASE WHEN DATEDIFF(created_at, installed_at) BETWEEN 7 AND 7 THEN 1 ELSE 0 END) AS retention_7day
FROM
	user_activity
WHERE
	installed_at >= '2020-01-01' 
GROUP BY
	cohort_month
ORDER BY
	cohort_month;
	
