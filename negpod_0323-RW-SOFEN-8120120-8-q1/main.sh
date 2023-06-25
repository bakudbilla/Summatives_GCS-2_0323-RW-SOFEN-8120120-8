#!/bin/bash

students_file="students-list_0333.txt"
emails_file="student-emails.txt"

# Check if students file exists, create it if not
if [[ ! -f "$students_file" ]]; then
    touch "$students_file"
fi

# Function to create a student record
create_student() {
    echo "Enter student email:"
    read email
    echo "Enter student age:"
    read age
    echo "Enter student ID:"
    read student_id

    # Check if student ID already exists
    if grep -q "^${student_id}," "$students_file"; then
        echo "Student ID already exists. Please choose a unique student ID."
    else
        echo "${email},${age},${student_id}" >> "$students_file"
        echo "Student record created successfully."
    fi
}

# Function to list all students
list_students() {
    if [[ -s "$students_file" ]]; then
        cat "$students_file"
    else
        echo "No students found."
    fi
}

# Function to delete a student record by ID
delete_student() {
    echo "Enter student ID to delete:"
    read student_id

    # Temporarily save contents excluding the student ID
    grep -v "^.*,$student_id\$" "$students_file" > temp.txt
    mv temp.txt "$students_file"

    echo "Student deleted successfully."
}

# Function to update a student record by ID
update_student() {
    echo "Enter student ID to update:"
    read student_id

    # Check if the student ID exists in the file
    if grep -q "^.*,$student_id\$" "$students_file"; then
        # Generate a unique temporary file name
        temp_file=$(mktemp)

        # Temporarily save contents excluding the student ID
        grep -v "^.*,$student_id\$" "$students_file" > "$temp_file"

        echo "Enter updated student email:"
        read email
        echo "Enter updated student age:"
        read age

        # Append the updated student record
        echo "${email},${age},${student_id}" >> "$temp_file"
        mv "$temp_file" "$students_file"

        echo "Student record updated successfully."
    else
        echo "Student ID not found."
    fi
}



# Function to select emails of all students
select_emails() {
    cut -d',' -f1 "$students_file" > "$emails_file"
    echo "Emails extracted successfully and saved in $emails_file."
}

# Main program loop
while true; do
    echo "Welcome to the Bachelor of Software Engineering cohort list application!"
    echo "Please choose an option:"
    echo "1. Create student record"
    echo "2. View all students"
    echo "3. Delete student"
    echo "4. Update student record"
    echo "5. Select emails of all students"
    echo "6. Exit"

read choice

    case $choice in
        1) create_student;;
        2) list_students;;
        3) delete_student;;
        4) update_student;;
        5) select_emails;;
        6) break;;
        *) echo "Invalid option. Please choose again.";;
    esac

    echo
done

