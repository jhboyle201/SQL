SELECT
  "Day",
  "Hour",
  MAX("Average Time(s)") as "Max Avg Time",
  "Total Requests",
  "Path",
  "Type"
FROM
  (
    SELECT
      "date" as "Date",
      strftime("%d", datetime("date", "time")) as "Day",
      strftime("%H", datetime("date", "time")) as "Hour",
      COUNT(*) as "Total Requests",
      (AVG("time-taken") / 1000) as "Average Time(s)",
      "cs-uri-stem" as "Path",
      "cs-method" as "Type"
    FROM
      all_iis_logs
    GROUP BY
      "Day",
      "Hour",
      "cs-uri-stem"
  )
GROUP BY
  "Path",
  "Type"
ORDER BY
  "Max Avg Time" DESC
