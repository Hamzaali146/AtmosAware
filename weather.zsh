#!/bin/zsh
file="weather_data.json"

# Extract and display values
latitude=$(jq -r '.latitude' "$file")
longitude=$(jq -r '.longitude' "$file")
temperature=$(jq -r '.current.temperature_2m' "$file")
humidity=$(jq -r '.current.relative_humidity_2m' "$file")

# Display values to the user
echo "The Weather of KARACHI is:"
echo 
echo "Latitude: $latitude"
echo "Longitude: $longitude"
echo "Temperature: $temperature"
echo "Humidity: $humidity"
echo 


# Append values to a new file
echo "$temperature" >> temperature.txt
echo "$humidity" >> humidity.txt

# weather api is from mateo.com
#"https://api.open-meteo.com/v1/forecast?latitude=24.8608&longitude=67.0104&current=temperature_2m,relative_humidity_2m,apparent_temperature,is_day,pressure_msl"
