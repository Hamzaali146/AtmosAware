// #include <stdio.h>
// #include <stdlib.h>
// #include <curl/curl.h>
// #include "cJSON.h"

// size_t WriteCallback(void *contents, size_t size, size_t nmemb, void *userp) {
//     size_t realsize = size * nmemb;
//     cJSON *json = (cJSON *)userp;

//     // Parse the received data as JSON
//     cJSON_ParseWithOpts((const char *)contents, &json, 0);

//     return realsize;
// }

// int main(void) {
//     CURL *curl;
//     CURLcode res;

//     curl_global_init(CURL_GLOBAL_DEFAULT);
//     curl = curl_easy_init();
//     if(curl) {
//         // Set the URL
//         curl_easy_setopt(curl, CURLOPT_URL, "http://calapi.inadiutorium.cz/api/v0/en/calendars/general-en/2021/03");

//         // Set the write callback function to parse JSON
//         cJSON *json = cJSON_CreateObject();
//         curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteCallback);
//         curl_easy_setopt(curl, CURLOPT_WRITEDATA, json);

//         // Perform the request
//         res = curl_easy_perform(curl);

//         // Check for errors
//         if(res != CURLE_OK) {
//             fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
//         } else {
//             // Process the parsed JSON
//             // For example, print the parsed JSON
//             char *jsonString = cJSON_Print(json);
//             printf("Parsed JSON:\n%s\n", jsonString);

//             // Save the parsed JSON to a file
//             FILE *file = fopen("output.json", "w");
//             if (file != NULL) {
//                 fprintf(file, "%s", jsonString);
//                 fclose(file);
//                 printf("Parsed JSON saved to 'output.json'.\n");
//             } else {
//                 fprintf(stderr, "Error opening file for writing.\n");
//             }

//             free(jsonString);
//             // Clean up cJSON structure
//             cJSON_Delete(json);
//         }

//         // Clean up libcurl
//         curl_easy_cleanup(curl);
//     }

//     // Clean up libcurl global state
//     curl_global_cleanup();

//     return 0;
// }
#include <stdio.h>
#include <curl/curl.h>

size_t write_callback(void *contents, size_t size, size_t nmemb, void *userp) {
    FILE *file = (FILE *)userp;
    return fwrite(contents, size, nmemb, file);
}

int main() {
    CURL *curl;
    CURLcode res;

    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    if(curl) {
        FILE *file = fopen("weather_data.json", "wb");  // Open file in binary write mode

        if(file) {
            curl_easy_setopt(curl, CURLOPT_URL, "your_weather_api_url_here");
            curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_callback);
            curl_easy_setopt(curl, CURLOPT_WRITEDATA, file);

            res = curl_easy_perform(curl);

            fclose(file);  // Close the file after writing

            if(res != CURLE_OK)
                fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
        }

        curl_easy_cleanup(curl);
    }

    curl_global_cleanup();
    return 0;
}
