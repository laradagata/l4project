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
output_dir_quic="/home/laradagata/l4project/data/PacketCaptures_test/testdata/quic"
output_dir_tcp="/home/laradagata/l4project/data/PacketCaptures_test/testdata/tcp"

# Iterate over websited and gather only QUIC-related information
for website in "${websites[@]}"; do

	# Extract the domain to use as the filename
	filename=( $(awk -F'/' '{print $3}' <<< "$website"))
	echo "$website"
	
	# Make new directory to store files relating to this webiste
	mkdir -p "$output_dir_quic/$filename"
	
	# Set QLOGDIR
	export QLOGDIR="$output_dir_quic/$filename"
	
	# Start tcpdump to capture QUIC network traffic 
	# Backgrounding this block to establish two threads
	{
		sudo tcpdump -n udp -SX -i any port 443 -w "$output_dir_quic/$filename/$filename-tcpdump.pcap"
	} &

	# allow backgrounded block to start running before curl command
	sleep 1
	
	# Use curl to fetch the web page
	sudo docker run -it --rm ymuski/curl-http3 curl --http3 -IL "$website" > "$output_dir_quic/$filename/$filename-curl.html"
	
	# Get qlog information for the web page
	cd $HOME/quiche && cargo run --bin quiche-client -- "$website"
	
	# Kill tcpdump
	kill -HUP $1
	
done

# Iterate over websited and gather only TCP-related information
for website in "${websites[@]}"; do

	# Extract the domain to use as the filename
	filename=( $(awk -F'/' '{print $3}' <<< "$website"))
	echo "$website"
	
	# Make new directory to store files relating to this webiste
	mkdir -p "$output_dir_tcp/$filename"
	
	# Start tcpdump to capture TCP network traffic 
	# Backgrounding this block to establish two threads
	{
		sudo tcpdump -i enp0s3 tcp -w "$output_dir_tcp/$filename/$filename-tcpdump.pcap"
	} &

	# allow backgrounded block to start running before curl command
	sleep 1
	
	# Use curl to fetch the web page
	sudo curl -D "$output_dir_tcp/$filename/$filename-curl.html" -vs "$website"
	
	# Kill tcpdump
	kill -HUP $1
done

echo "Packet Capture Complete"
