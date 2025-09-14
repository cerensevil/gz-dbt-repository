with src as (
  select * from {{ source('raw','bing') }}
)
select
  cast(date_date as date)            as date,
  camPGN_name                        as campaign_name,
  safe_cast(ads_cost as float64)     as ads_cost,
  safe_cast(impression as int64)     as ads_impression,
  safe_cast(click as int64)          as ads_clicks,
  paid_source                        as paid_source,
  campaign_key                       as campaign_key
from src
