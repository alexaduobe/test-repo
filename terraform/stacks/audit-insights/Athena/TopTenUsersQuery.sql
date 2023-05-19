SELECT useridentity.username, COUNT(*) as IdentityCount FROM "logarchive"."cloudtrail" 
WHERE eventtime LIKE CONCAT('%', date_format(current_timestamp, '%Y_%m'), '%') 
GROUP BY useridentity.username
ORDER BY IdentityCount DESC
LIMIT 10;