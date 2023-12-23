#!/bin/bash
json_file="weather_data.json"

# Extract and display values
latitude=$(jq -r '.location.coordinates.latitude' "$json_file")
longitude=$(jq -r '.location.coordinates.longitude' "$json_file")
temperature=$(jq -r '.weather.temperature' "$json_file")
humidity=$(jq -r '.weather.humidity' "$json_file")

# Display values to the user
echo "Latitude: $latitude"
echo "Longitude: $longitude"
echo "Temperature: $temperature"
echo "Humidity: $humidity"

# weather api is from mateo.com
#"https://api.open-meteo.com/v1/forecast?latitude=24.8608&longitude=67.0104&current=temperature_2m,relative_humidity_2m,apparent_temperature,is_day,pressure_msl"
