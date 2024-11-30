# Can you write a for loop that prints the current time and date every second, repeating 10 times?
# How can I loop through 10 iterations, printing the time and date every second?

# Loop from 1 to 10 (this will run 10 times)
for i in {1..10}; do
    # Get the current date and time, and print the first four fields:
    # $1 = Day of the week, $2 = Month, $3 = Day of the month, $4 = Time
    echo $(date) | awk '{print $1, $2, $3, $4}'
    #echo $(date) | awk -F " " {print $1, $2, $3, $4}

    # Wait for 1 second before the next iteration
    sleep 1
done
