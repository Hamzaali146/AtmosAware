#!/bin/zsh
json_file="weather_data.json"

temperature=$(jq -r '.current.temperature_2m' "$json_file")

threshold_temperature_high=30
threshold_temperature_low=-10

# Check if the temperature is higher than the threshold
if [[ $temperature -gt $threshold_temperature_high ]]; then
    # Send email
    subject="High Temperature Alert"
    body="The current temperature ($temperature) is higher than the threshold ($threshold_temperature_high)."
    echo "$body" | mail -s "$subject" wasekid332@taobudao.com
    echo "Email sent."
elif [[ $temperature -lt $threshold_temperature_low ]]; then
    subject="Low Temperature Alert"
    body="The current temperature ($temperature) is lower than the threshold ($threshold_temperature_low)."
    echo "$body" | mail -s "$subject" wasekid332@taobudao.com
    echo "Email sent."
else
    echo "Temperature is within the normal range."
echo ---------------------------------------------------
fi
