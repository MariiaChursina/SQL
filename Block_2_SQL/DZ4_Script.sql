with google_CTE as (
with facebook_CTE AS (
select fabd.ad_date, 
       'Facebook Ads' as media_source,
       fc.campaign_name, 
       fa.adset_name, 
       spend, impressions, reach, clicks, leads, value
from facebook_ads_basic_daily fabd 
inner join facebook_campaign fc on fc.campaign_id = fabd.campaign_id 
inner join facebook_adset fa on fa.adset_id = fabd.adset_id 
)
select * from facebook_CTE
union
SELECT gabd.ad_date,
       'Google Ads' as media_source, 
       gabd.campaign_name, 
       gabd.adset_name,  
       spend, impressions, reach, clicks, leads, value
FROM google_ads_basic_daily gabd 
)
select ad_date, media_source, campaign_name,
       sum(spend) as total_spend,
	   sum (impressions)as total_impressions,
	   sum (clicks) as total_clicks,
	   sum (value) as total_value
from google_CTE
group by ad_date, media_source, campaign_name, adset_name
order by ad_date;

















/*
with facebook_ads_basic_daily_CTE AS (
select fabd.ad_date, 
       'Facebook Ads' as media_source,
       fc.campaign_name, 
       fa.adset_name, 
       spend, impressions, reach, clicks, leads, value
from facebook_ads_basic_daily fabd 
inner join facebook_campaign fc on fc.campaign_id = fabd.campaign_id 
inner join facebook_adset fa on fa.adset_id = fabd.adset_id 
union
SELECT gabd.ad_date,
       'Google Ads' as media_source, 
       gabd.campaign_name, 
       gabd.adset_name,  
       spend, impressions, reach, clicks, leads, value
FROM google_ads_basic_daily gabd 
)
select ad_date, media_source, 
       sum(spend) as total_spend,
	   sum (impressions)as total_impressions,
	   sum (clicks) as total_clicks,
	   sum (value) as total_value
from facebook_ads_basic_daily_CTE
group by ad_date, media_source, campaign_name, adset_name
order by ad_date;*/
