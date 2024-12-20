# Q1. Which designated areas (Designated_area) are most prone to disasters, and what types of disasters are most common there?
SELECT 
	designated_area, disaster_type, fy_declared, disaster_number
FROM 
	disaster_classification;

# Q2. Which Disaster_Type categories are most likely to receive FEMA declarations (Fema_declaration_type) faster?
SELECT 
	disaster_type, fema_declaration_string, designated_area
FROM 
	disaster_classification
GROUP BY 
	disaster_type, fema_declaration_string, designated_area;

# Q3. What are the emerging hotspots for disasters, based on recent spikes in (Incident_type) in previously less-affected areas (Designated_area)?
SELECT 
	disaster_type, designated_area,fy_declared
FROM 
	disaster_classification
GROUP BY 
	disaster_type, designated_area,fy_declared;

# Q4.  Is there a correlation between Place_code and the frequency or severity of disaster events?
SELECT 
	geographic_information.place_code, (disaster_classification.incident_type)
FROM 
	geographic_information
JOIN 
	disaster_classification ON disaster_classification.disaster_number = geographic_information.disaster_number
GROUP BY 
	geographic_information.place_code, disaster_classification.incident_type;

# Q5. Which states consistently have the highest (Disaster_Number) counts, and what are the common disaster types there?
SELECT 
    disaster_events.state,
    COUNT(DISTINCT disaster_events.disaster_number) AS Total_Disaster_Count,
    incident_details.incident_type,
    COUNT(incident_details.incident_type) AS Disaster_Type_Count
FROM 
    disaster_events 
JOIN 
    incident_details ON disaster_events.disaster_number = incident_details.disaster_number
GROUP BY 
    disaster_events.state,incident_details.incident_type
ORDER BY 
    Total_Disaster_Count DESC, 
    Disaster_Type_Count DESC;

# Q6. Are certain (Declaration_types) associated with quicker disaster closeouts? 
SELECT 
    disaster_events.declaration_type,
    AVG(DATEDIFF(incident_timeline.disaster_closeout_date, incident_timeline.incident_begin_date)) AS Avg_Closeout_Duration
FROM 
    disaster_events 
JOIN 
    incident_timeline ON disaster_events.disaster_number = incident_timeline.disaster_number
GROUP BY 
    disaster_events.declaration_type
ORDER BY 
    Avg_Closeout_Duration ASC;
    
# Q7.  How are disaster occurrences distributed geographically based on (Fips) codes?
SELECT 
    geographic_information.Fips,
    COUNT(DISTINCT disaster_events.disaster_number) AS Disaster_Count
FROM 
    geographic_information 
JOIN 
    disaster_events ON geographic_information.disaster_number = disaster_events.disaster_number
GROUP BY 
   geographic_information.Fips
ORDER BY 
    Disaster_Count DESC;
    
# Q8. Using historical data, can the (Incident_Begin_date) and (Geo_Id) predict the likelihood of a specific (Disaster_Type) in a region?
SELECT 
    incident_timeline.incident_begin_date, 
    geographic_information.geo_id, 
    disaster_classification.disaster_type 
FROM 
    geographic_information 
JOIN 
    disaster_classification ON geographic_information.disaster_number = disaster_classification.disaster_number 
JOIN 
    incident_timeline ON geographic_information.disaster_number = incident_timeline.disaster_number 
GROUP BY 
    incident_timeline.incident_begin_date, 
    geographic_information.geo_id, 
    disaster_classification.disaster_type 
ORDER BY 
    geographic_information.geo_id 
LIMIT 1000; 