#!/bin/bash
#this command will select all e-mails and save them in student-email.txt file
grep -oE '^[^,]+' students-list_0333.txt > student-emails.txt
