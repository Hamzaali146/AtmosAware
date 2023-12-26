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
json_file="weather_data.json"

temperature=$(jq -r '.weather.temperature' "$json_file")

threshold_temperature_high=30
threshold_temperature_low=10

# Display temperature to the user
echo "Temperature: $temperature"

# Check if the temperature is higher than the threshold
if [ "$temperature" -gt "$threshold_temperature_high" ]; then
    # Send email
    subject="High Temperature Alert"
    body="The current temperature ($temperature) is higher than the threshold ($threshold_temperature_high)."
    echo "$body" | mail -s "$subject" aaly.galy@gmail.com
    echo "Email sent."
elif ["$temperature" -lt "threshold_temperature_low"];then
    subject="Low Temperature Alert"
    body="The current temperature ($temperature) is lower than the threshold ($threshold_temperature_low)."
    echo "$body" | mail -s "$subject" aaly.galy@gmail.com
    echo "Email sent."
else
    echo "Temperature is within the normal range."
fi