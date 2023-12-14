#include <stdio.h>
#include "curl/curl.h"
int main(void) {
    CURL *curl;
    CURLcode response;

    curl_global_init(CURL_GLOBAL_ALL);

    curl = curl_easy_init();
    if(curl) {
        curl_easy_setopt(curl, CURLOPT_URL, "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&hourly=temperature_2m,relative_humidity_2m,rain,wind_speed_10m,temperature_80m,temperature_120m,temperature_180m");

        response = curl_easy_perform(curl);

        if(response != CURLE_OK) {
            fprintf(stderr, "Request failed: %s\n", curl_easy_strerror(response));
        } else {
            printf("response successfully Loaded :) %d\n",response);
        }
        curl_easy_cleanup(curl);
    }
    curl_global_cleanup();
    return 0;
}