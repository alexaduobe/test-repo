SELECT recipientaccountid, COUNT(*) as AccCount FROM "logarchive"."cloudtrail" 
WHERE eventtime LIKE CONCAT('%', date_format(current_timestamp, '%Y_%m'), '%') 
GROUP BY recipientaccountid
ORDER BY AccCount DESC
LIMIT 10;