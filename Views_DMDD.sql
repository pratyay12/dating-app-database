
----View_3

CREATE VIEW RATING_RANKING_BY_CITY_VIEW AS 
select user_id, city,Rate,
DENSE_RANK() OVER (PARTITION by city  ORDER BY Rate DESC) as City_Rank
from user_detail_u a
join rating_r b
on b.rate_receiver=a.user_id

--VIEW_4

CREATE VIEW RATING_RANKING_BY_STATE_VIEW  AS 
select user_id, a.state,Rate,
DENSE_RANK() OVER (PARTITION by a.state  ORDER BY Rate DESC) as STATE_RANK
      
from user_detail_u a
join rating_r b
on b.rate_receiver=a.user_id

---View_6
CREATE VIEW BLOCKED_PROFILES_PER_CITY_VIEW AS 
select count(user_id) as block_Users, city
from user_detail_u a
join Block_R b
on b.block_receiver=a.user_id
group by city

---View_7

CREATE VIEW  BLOCKED_PROFILES_PER_STATE_VIEW AS 
select count(user_id) as block_Users, state
from user_detail_u a
join Block_R b
on b.block_receiver=a.user_id
group by state

--View_10
CREATE VIEW  USER_GENDER_REPORT_VIEW  AS
select gender_id,
count(*) over (partition by gender_id order by gender_id) as total
from user_detail_u 

