#!/bin/bash
# Get domain name
_zenity="/usr/bin/zenity"
_out="/tmp/whois.output.$$"
domain=$(${_zenity} --title  "Enter domain" \
	            --entry --text "Enter the domain you would like to see whois info" )
 
if [ $? -eq 0 ]
then
  # Display a progress dialog while searching whois database
  whois $domain  | tee >(${_zenity} --width=200 --height=100 \
  				    --title="whois" --progress \
			            --pulsate --text="Searching domain info..." \
                                    --auto-kill --auto-close \
                                    --percentage=10) >${_out}
 
  # Display back output
  ${_zenity} --width=800 --height=600  \
	     --title "Whois info for $domain" \
	     --text-info --filename="${_out}"
else
  ${_zenity} --error \
	     --text="No input provided"
fi
