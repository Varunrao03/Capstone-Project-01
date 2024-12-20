create database US_Disaster;

# Altering the Admin table
ALTER TABLE admin_details
RENAME COLUMN Admin_id TO admin_id;

SELECT admin_id
FROM admin_details;

# Altering the Geographic table
ALTER TABLE geographic_information
RENAME COLUMN id_number TO geo_id;

SELECT geo_id
FROM geographic_information;

# Altering the Incident table
ALTER TABLE incident_details
RENAME COLUMN id_number TO incident_id;

SELECT incident_id
FROM incident_details;

# Altering the Incident table
ALTER TABLE incident_timeline
RENAME COLUMN fy_declared TO incident_date;

# Altering the Disaster_classification
ALTER TABLE disaster_classification
RENAME COLUMN incident_type TO disaster_type;