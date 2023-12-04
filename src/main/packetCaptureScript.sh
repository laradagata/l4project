#!/bin/bash

# Create list of top 1000 websites

top_urls="small_urls.txt"

websites=()

while IFS= read -r line; do
	# Use awk to split the line by quotation mark
	# Store the second argument (the url) into top_urls
	url_string=( $(awk -F, '{print "https://www."$2"/"}' <<< "$line") )

	# Remove quotation marks from url string
	websites+=( $(echo "$url_string" | sed 's/"//g') )  

done < "$top_urls"

# Directory to save the packet captures
output_dir="/home/laradagata/l4project/data/PacketCaptures_test/testdata"

#mkdir -p "$output_dir"

for website in "${websites[@]}"; do
	# Extract the domain to use as the filename
	filename=( $(awk -F'/' '{print $3}' <<< "$website"))
	
	echo "$website"
	
	# Start tcpdump to capture QUIC network traffic 
	# Backgrounding this block to establish two threads
	{
		sudo tcpdump -n udp -SX -i any port 443 -c 1 -w "$output_dir/$filename.pcap"
	} &

	# allow backgrounded block to start running before curl command
	sleep 1
	
	# Use curl to fetch the web page
	sudo docker run --rm ymuski/curl-http3 curl --http3 -IL "$website" > "$output_dir/$filename.html"
	
done
	
# Stop tcpdump

echo "Packet Capture Complete"
