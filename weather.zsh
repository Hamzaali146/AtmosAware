#!/bin/bash
file="weather_data.json"

# Extract and display values
latitude=$(jq -r '.latitude' "$file")
longitude=$(jq -r '.longitude' "$file")
temperature=$(jq -r '.current.temperature_2m' "$file")
humidity=$(jq -r '.current.humidity' "$file")

# Display values to the user
echo "The Weather of karachi is:"
echo "Latitude: $latitude"
echo "Longitude: $longitude"
echo "Temperature: $temperature"
echo "Humidity: $humidity"

# weather api is from mateo.com
#"https://api.open-meteo.com/v1/forecast?latitude=24.8608&longitude=67.0104&current=temperature_2m,relative_humidity_2m,apparent_temperature,is_day,pressure_msl"
