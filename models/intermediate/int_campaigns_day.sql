with base as (select * from {{ ref('int_campaigns') }})
select
  date,
  sum(ads_cost)       as ads_cost,
  sum(ads_impression) as ads_impression,
  sum(ads_clicks)     as ads_clicks
from base
group by 1
order by date desc
