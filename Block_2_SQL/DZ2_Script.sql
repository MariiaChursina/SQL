select  ad_date , campaign_id ,
	   sum(spend) as total_spend,
	   sum (impressions)as total_impressions,
	   sum (clicks) as total_clicks,
	   sum (value) as total_value,
	   sum(spend)/ sum (clicks) as cpc,
	   1000*sum (spend)/sum(impressions) as cpm,
	   100*sum(clicks :: numeric)/sum(impressions) as ctr,
	   sum(value :: numeric)/sum(spend) as romi
from 
       facebook_ads_basic_daily
where ad_date notnull and clicks >0 and impressions >0 and spend  >0
group by campaign_id, ad_date ;



   
