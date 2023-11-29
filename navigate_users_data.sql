--- First recognize the user who we suspect was a fraud sale

SELECT
DISTINCT user_pseudo_id, event_timestamp

FROM `lookerstudio.events2023`
WHERE event_date='20231117'
AND event_name = 'purchase'


--- We can know by the timestamp that matches the sale 20.07 that the user_pseudo_id is 1172063761.1699599262 (string format)
-- let's find out more about this user compared to the rest

SELECT
    CASE user_pseudo_id
        WHEN '1172063761.1699599262' THEN 'our_user'
        ELSE user_pseudo_id
    END as user_id_simpified,
  COUNT(DISTINCT session_id)
FROM
  `namastecita.lookerstudio.events2023`

WHERE user_pseudo_id IN (SELECT DISTINCT user_pseudo_id FROM `namastecita.lookerstudio.events2023` WHERE event_name='purchase')
GROUP BY 1
ORDER BY 2 DESC

-- from results we can see that this person really didn't explore our site in different sessions.
-- let's try to check something broader. Let's compare our user among the 171 parameters from GA4




