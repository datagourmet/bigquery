CREATE OR REPLACE TABLE `namastecita.lookerstudio.events2023` AS

WITH sessions AS (
  SELECT DISTINCT
    user_pseudo_id,
    CONCAT(user_pseudo_id, (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id')) AS session_id
  FROM `namastecita.analytics_322272818.events_2023*`
)



SELECT
  f.user_pseudo_id,
  s.session_id,
  event_date,
  TIMESTAMP_MICROS(event_timestamp) as event_timestamp,
  event_name,
  event_params.key parametro,
  event_params.value.string_value,
  event_params.value.int_value

FROM `namastecita.analytics_322272818.events_2023*` f ,unnest(event_params) event_params

JOIN sessions s ON f.user_pseudo_id = s.user_pseudo_id AND s.session_id = CONCAT(f.user_pseudo_id, (SELECT value.int_value FROM UNNEST(f.event_params) WHERE key = 'ga_session_id'))


GROUP BY 1,2,3,4,5,6,7,8
