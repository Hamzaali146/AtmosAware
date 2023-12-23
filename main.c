#include <stdio.h>
#include <curl/curl.h>

size_t write_callback(void *contents, size_t size, size_t nmemb, void *userp) {
    FILE *file = (FILE *)userp;
    return fwrite(contents, size, nmemb, file);
}

int main() {
    CURL *curl;
    CURLcode response;

    curl_global_init(CURL_GLOBAL_DEFAULT);
    curl = curl_easy_init();

    if(curl) {
        FILE *file = fopen("weather_data.json", "wb");  // Open file in binary write mode

        if(file) {
            curl_easy_setopt(curl, CURLOPT_URL, "your_weather_api_url_here");
            curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, write_callback);
            curl_easy_setopt(curl, CURLOPT_WRITEDATA, file);

            response = curl_easy_perform(curl);

            fclose(file);  // Close the file after writing

            if(response != CURLE_OK)
                fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(response));
        }

        curl_easy_cleanup(curl);
    }

    curl_global_cleanup();
    return 0;
}
