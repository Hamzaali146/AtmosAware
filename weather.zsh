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

threshold_temperature_high=30
threshold_temperature_low=10
elastic_email_username="wagob90084@visignal.com"
elastic_email_password="29D627F6EC2F6E222D408489EC8F7DE13998"
from_email="gamer.khan1020@gmail.com"
to_email="aaly.galy@gmail.com"

# Check if the temperature is higher than the threshold
if [ "$temperature" -gt "$threshold_temperature_high" ]; then
    # Send email
    subject="High Temperature Alert"
    body="The current temperature ($temperature) is higher than the threshold ($threshold_temperature_high)."
    # Send email using sendemail and Elastic Email SMTP server
sendemail -f "$from_email" -t "$to_email" -u "$subject" -m "$body" \
    -s smtp.elasticemail.com:2525 -o tls=yes -xu "$elastic_email_username" -xp "$elastic_email_password"
    echo "Email sent."
elif ["$temperature" -lt "threshold_temperature_low"];then
    subject="Low Temperature Alert"
    body="The current temperature ($temperature) is lower than the threshold ($threshold_temperature_low)."
    # Send email using sendemail and Elastic Email SMTP server
sendemail -f "$from_email" -t "$to_email" -u "$subject" -m "$body" \
    -s smtp.elasticemail.com:2525 -o tls=yes -xu "$elastic_email_username" -xp "$elastic_email_password"
    echo "Email sent."
else
    echo "Temperature is within the normal range."
fi


# Send email using sendemail and Elastic Email SMTP server
sendemail -f "$from_email" -t "$to_email" -u "$subject" -m "$body" \
    -s smtp.elasticemail.com:2525 -o tls=yes -xu "$elastic_email_username" -xp "$elastic_email_password"