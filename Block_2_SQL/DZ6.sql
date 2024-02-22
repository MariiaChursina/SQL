with facebook_CTE AS (
select fabd.ad_date, 
       fabd.url_parameters, 
       campaign_name,
       coalesce(fabd.spend,0) as spend, 
       coalesce(fabd.impressions,0)as impressions, 
       coalesce(fabd.reach,0)as reach, 
       COALESCE (fabd.clicks,0)as clicks, 
       COALESCE(fabd.leads, 0) as leads, 
       coalesce(fabd.value,0)as value 
from facebook_ads_basic_daily fabd 
inner join facebook_campaign fc on fc.campaign_id = fabd.campaign_id 
inner join facebook_adset fa on fa.adset_id = fabd.adset_id 
union
SELECT gabd.ad_date, 
       gabd.url_parameters, 
       gabd.campaign_name,
       coalesce(gabd.spend,0) as spend, 
       coalesce(gabd.impressions,0)as impressions, 
       coalesce(gabd.reach,0)as reach, 
       COALESCE (gabd.clicks,0)as clicks, 
       COALESCE(gabd.leads, 0) as leads, 
       coalesce(gabd.value,0)as value 
FROM google_ads_basic_daily gabd 
)
select ad_date, 
coalesce(url_parameters, '0') as url_parameters, 
case 
	when LOWER(substring (url_parameters, 'utm_campaign=([\w|\d]+)')) = 'nan' then null
	else LOWER(substring (url_parameters, 'utm_campaign=([\w|\d]+)'))
end as utm_campaign, campaign_name,
       sum(spend) as total_spend,
	   sum (impressions)as total_impressions,
	   sum (clicks) as total_clicks,
	   sum (value) as total_value,
case 
	when  sum(clicks) >0 then sum(spend)/sum(clicks) else 0
end as cpc,
case
	when sum(impressions)>0 then 1000*sum (spend)/sum(impressions) else 0
end as cpm,
case
	when sum(impressions)>0 then 100*sum(clicks :: numeric)/sum(impressions)
end as ctr,
case
	when sum(spend)>0 then sum(value :: numeric)/sum(spend)
end as romi
from facebook_CTE 
group by ad_date, url_parameters,   campaign_name;
