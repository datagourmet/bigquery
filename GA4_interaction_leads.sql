WITH sessions as (

  SELECT
  user_pseudo_id,
  CONCAT(user_pseudo_id,(select value.int_value from unnest(event_params) where key = 'ga_session_id')) as session_id
  FROM # `add your ga events table`

)


SELECT
 distinct s.session_id,
 event_timestamp,
 event_name,
 event_params.key parametro,
 event_params.value.string_value,
 event_params.value.int_value

FROM `` f ,unnest(event_params) event_params

JOIN sessions s ON f.user_pseudo_id=s.user_pseudo_id

WHERE s.session_id IN (SELECT sessions FROM ``)
