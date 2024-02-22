/*select ad_date,'Facebook Ads' as media_source,  spend, impressions, reach, clicks, leads, value
FROM facebook_ads_basic_daily
union 
SELECT ad_date,'Google Ads' as media_source,  spend, impressions, reach, clicks, leads, value
FROM google_ads_basic_daily
order by ad_date;
--group by ad_date, media_source;*/

with facebook_ads_basic_daily_CTE AS (
select ad_date,'Facebook Ads' as media_source,  spend, impressions, reach, clicks, leads, value
FROM facebook_ads_basic_daily
union 
SELECT ad_date,'Google Ads' as media_source,  spend, impressions, reach, clicks, leads, value
FROM google_ads_basic_daily
--order by ad_date
--group by ad_date, media_source
)
select ad_date, media_source, 
       sum(spend) as total_spend,
	   sum (impressions)as total_impressions,
	   sum (clicks) as total_clicks,
	   sum (value) as total_value
from facebook_ads_basic_daily_CTE
group by ad_date, media_source
order by ad_date;

