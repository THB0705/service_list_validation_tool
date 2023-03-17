#!/bin/bash

# Temporary service lst file.
services_lst_output=services_lst.txt
services_lst_output_temp=services_lst_temp.txt
desired_services_lst=target_services.txt

# Create list of all services on system.
sc queryex state=all | findstr 'SERVICE_NAME:' > $services_lst_output                    # Optional queryex parameter we can add, not necessary though I think... type=service 

# Remove the "SERVICE_NAME: " part of each file and write to temporary file.
while IFS='' read -r line; do
    service=${line//"SERVICE_NAME: "/}
    service=$(echo $service|tr -d '\r')
    service="${service}*"
    
    echo $service
done < $services_lst_output > services_lst_temp.txt

# Replace old file with temporary file.
mv -f $services_lst_output_temp $services_lst_output



while IFS='' read -r line; do
    desiredService=$(echo ${line}|tr -d '\r')"*"
    
    while IFS='' read -r line2; do
        presentService=${line2}
        if [[ $presentService == *$desiredService* ]]; then
            echo ${presentService//"*"/}
        fi
    done < $services_lst_output

done < $desired_services_lst

##########
read -n 1 -r -s -p $'Press enter to continue...\n'
# Remove temporary files.