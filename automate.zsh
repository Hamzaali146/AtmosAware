#!/bin/zsh

# Set the path to your main code file
main_code_file="main.c"

# Set the time interval between executions (in seconds)
time_interval=5  # Adjust this value as needed

# Counter to keep track of the number of times the program has run
run_counter=0

while true; do
    # Compile the C code
    gcc "$main_code_file" -o main_program -lcurl

    # Check if the compilation was successful
    if [ $? -eq 0 ]; then
        # Run the compiled program
        ./main_program

        # Increment the run counter
        ((run_counter++))

        # If the counter reaches 7, calculate the report
        if [ $run_counter -eq 2 ]; then
            
            #FIRST COMPILE
            gcc stats.c -o stats
            # Call the stats program with temperature and humidity files
            ./stats temperature.txt humidity.txt
            echo
            echo "REPORT GENERATED"
            echo

            # Reset the counter
            run_counter=0
        fi
    else
        echo "Compilation failed. Check for errors in your C code."
    fi

    # Sleep for the specified time interval
    sleep $time_interval
done
