// stats.c

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main(int argc, char *argv[]) {
    // Check if the correct number of arguments is provided
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <temperature_file> <humidity_file>\n", argv[0]);
        return 1;
    }

    // Open the temperature file
    FILE *temp_file = fopen(argv[1], "r");
    if (temp_file == NULL) {
        perror("Error opening temperature file");
        return 1;
    }

    // Open the humidity file
    FILE *humid_file = fopen(argv[2], "r");
    if (humid_file == NULL) {
        perror("Error opening humidity file");
        fclose(temp_file);
        return 1;
    }

    // Open the report file for appending
    FILE *report_file = fopen("report.txt", "a");
    if (report_file == NULL) {
        perror("Error opening report file");
        fclose(temp_file);
        fclose(humid_file);
        return 1;
    }

    // Initialize variables for statistics
    double sum_temperature = 0.0;
    double sum_humidity = 0.0;
    double max_temperature = -INFINITY;
    double min_temperature = INFINITY;
    double max_humidity = -INFINITY;
    double min_humidity = INFINITY;
    int count = 0;

    // Read values from the files and update statistics
    double temperature, humidity;
    while (fscanf(temp_file, "%lf", &temperature) == 1 && fscanf(humid_file, "%lf", &humidity) == 1) {
        sum_temperature += temperature;
        sum_humidity += humidity;

        if (temperature > max_temperature) {
            max_temperature = temperature;
        }

        if (temperature < min_temperature) {
            min_temperature = temperature;
        }

        if (humidity > max_humidity) {
            max_humidity = humidity;
        }

        if (humidity < min_humidity) {
            min_humidity = humidity;
        }

        count++;
    }

    // Close the files
    fclose(temp_file);
    fclose(humid_file);

    // Calculate mean values
    double mean_temperature = sum_temperature / count;
    double mean_humidity = sum_humidity / count;

    // Append statistics to the report file
    fprintf(report_file, "STATISTICS:\n");
    fprintf(report_file, "Number of readings: %d\n", count);
    fprintf(report_file, "Mean Temperature: %.2f\n", mean_temperature);
    fprintf(report_file, "Mean Humidity: %.2f\n", mean_humidity);
    fprintf(report_file, "Max Temperature: %.2f\n", max_temperature);
    fprintf(report_file, "Min Temperature: %.2f\n", min_temperature);
    fprintf(report_file, "Max Humidity: %.2f\n", max_humidity);
    fprintf(report_file, "Min Humidity: %.2f\n", min_humidity);
    fprintf(report_file, "-------------------------------------------\n");

    // Close the report file
    fclose(report_file);

    // Clean the files
    temp_file = fopen(argv[1], "w");
    humid_file = fopen(argv[2], "w");

    fclose(temp_file);
    fclose(humid_file);

    return 0;
}
