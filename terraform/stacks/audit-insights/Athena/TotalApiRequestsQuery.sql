SELECT count(*) as ApiCount,  FROM "logarchive"."cloudtrail"
WHERE eventtime LIKE CONCAT('%', date_format(current_timestamp, '%Y_%m'), '%') 