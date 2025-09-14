with src as (
  select * from {{ source('raw','adwords') }}
)
select
  cast(date_date as date)                         as date,              -- DATE
  camPGN_name                                     as campaign_name,     -- standardize
  safe_cast(ads_cost as float64)                  as ads_cost,          -- STRING -> FLOAT64
  safe_cast(impression as int64)                  as ads_impression,    -- FLOAT -> INT64
  safe_cast(click as int64)                       as ads_clicks,        -- FLOAT -> INT64
  paid_source                                     as paid_source,       -- hamdaki değer
  campaign_key                                    as campaign_key       -- olası PK/iş anahtarı
from src
