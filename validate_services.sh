#!/bin/bash

# Temporary service lst file.
services_lst_output=services_lst.txt
services_lst_output_temp=services_lst_temp.txt

# Create list of all services on system.
sc queryex state=all | findstr 'SERVICE_NAME:' > $services_lst_output                    # Optional queryex parameter we can add, not necessary though I think... type=service 

# Remove the "SERVICE_NAME: " part of each file and write to temporary file.
while IFS='' read -r line; do
    echo "${line//"SERVICE_NAME: "/""}"
done < $services_lst_output > services_lst_temp.txt

# Replace old file with temporary file.
mv -f $services_lst_output_temp $services_lst_output



##########
#read -n 1 -r -s -p $'Press enter to continue...\n'
# Remove temporary files.