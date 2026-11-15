# 1) Which telecom operator has the highest average download speed?
SELECT
    operator,
    COUNT(*) AS total_records,
    ROUND(AVG(download_speed_mbps), 2) AS avg_download_speed
FROM maharashtra_telecom_cleaned
GROUP BY operator
ORDER BY avg_download_speed DESC;

# 2) Which telecom operator receives the highest total customer complaints?
SELECT
    operator,
    SUM(complaints) AS total_complaints
FROM maharashtra_telecom_cleaned
GROUP BY operator
ORDER BY total_complaints DESC;

# 3) Which Maharashtra district has the lowest average download speed?
SELECT
    district,
    ROUND(AVG(download_speed_mbps), 2) AS lowest_average
FROM maharashtra_telecom_cleaned
GROUP BY district
ORDER BY lowest_average ASC
LIMIT 10;

# 4) Which telecom operator has the highest average network ping?
SELECT
    operator,
    ROUND(AVG(ping_ms), 2) AS avg_ping
FROM maharashtra_telecom_cleaned
GROUP BY operator
ORDER BY avg_ping DESC;

# 5) Which 10 Maharashtra districts have the highest total customer complaints?
SELECT 
    district,
    SUM(complaints) AS total_complaints
FROM maharashtra_telecom_cleaned
GROUP BY district
ORDER BY total_complaints DESC
LIMIT 10;

# 6) Which telecom operator has the strongest average signal strength?
SELECT
    operator,
    AVG(signal_dbm) AS strongest_average
FROM maharashtra_telecom_cleaned
GROUP BY operator
ORDER BY strongest_average DESC;

# 7) Which network issue type has the highest total customer complaints?
SELECT
    issue_type,
    SUM(complaints) AS total_complaints
FROM maharashtra_telecom_cleaned
WHERE issue_type != 'No Issue'
GROUP BY issue_type
ORDER BY total_complaints DESC;

# 8) Which operator has the highest percentage of pending complaints?
SELECT
    operator,

    SUM(CASE 
        WHEN status = 'Pending' THEN 1
        ELSE 0
    END) AS pending_records,

    SUM(CASE 
        WHEN status IN ('Pending', 'Resolved') THEN 1
        ELSE 0
    END) AS total_complaint_records,

    ROUND(
        100.0 * SUM(CASE 
            WHEN status = 'Pending' THEN 1
            ELSE 0
        END) /
        NULLIF(SUM(CASE 
            WHEN status IN ('Pending', 'Resolved') THEN 1
            ELSE 0
        END), 0),
        2
    ) AS pending_percentage

FROM maharashtra_telecom_cleaned
GROUP BY operator
ORDER BY pending_percentage DESC;

# 9) Which month has the highest total customer complaints?
SELECT
    DATE_FORMAT(`date`, '%Y-%m') AS complaint_month,
    SUM(complaints) AS total_complaints
FROM maharashtra_telecom_cleaned
GROUP BY DATE_FORMAT(`date`, '%Y-%m')
ORDER BY total_complaints DESC;

# 10) Which district has the highest average ping?
SELECT
    district,
    ROUND(AVG(ping_ms), 2) AS avg_ping
FROM maharashtra_telecom_cleaned
GROUP BY district
ORDER BY avg_ping DESC
LIMIT 10;

# 11) Which telecom operator has the highest average upload speed?
SELECT
    operator,
    ROUND(AVG(upload_speed_mbps), 2) AS avg_upload_speed
FROM maharashtra_telecom_cleaned
GROUP BY operator
ORDER BY avg_upload_speed DESC;

# 12) Compare 4G vs 5G network performance.?
SELECT
    network,
    COUNT(*) AS total_records,
    ROUND(AVG(download_speed_mbps), 2) AS avg_download,
    ROUND(AVG(upload_speed_mbps), 2) AS avg_upload,
    ROUND(AVG(ping_ms), 2) AS avg_ping
FROM maharashtra_telecom_cleaned
GROUP BY network
ORDER BY network;
