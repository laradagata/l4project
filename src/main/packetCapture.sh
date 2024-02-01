#!/bin/bash

# Initialise list which will contain the top 1000 urls
websites=()

# Read all lines from top urls file and add each url to the websites list
while IFS="," read -r domain 
do
	websites+=( $(echo $(awk -F, '{print "https://www."$domain"/"}') ) )
	
done < <(cut -d "," -f3 majestic_million.csv | tail -n +1)

 << URL_NAME_LOOP
for w in "${websites[@]}"; do
	echo "$w"
done
URL_NAME_LOOP

# Directory to save the packet captures
output_dir="/home/2526633d/l4project/data/"

# Make directories to save packetCapture data into
mkdir -p "$output_dir/packetCapture_campus"
mkdir -p "$output_dir/packetCapture_campus/quic"
mkdir -p "$output_dir/packetCapture_campus/tcp"

# Store variables for different QUIC & TCP directories 
output_dir_quic="$output_dir/packetCapture_campus/quic"
output_dir_tcp="$output_dir/packetCapture_campus/tcp"

# Define initial port number
port_num=1100

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
		tcpdump -n udp -SX -i any -U port 443 and port $port_num -w "$output_dir_quic/$filename/$filename-tcpdump.pcap"
	} &

	# allow backgrounded block to start running before querying site
	sleep 1
	
	# Use curl to fetch the web page
	# sudo docker run --rm ymuski/curl-http3 curl --http3 -IL "$website" > "$output_dir_quic/$filename/$filename-curl.html"
	
	# sudo docker run --rm ymuski/curl-http3 /bin/bash -c"export QLOGDIR=/opt && curl --http3 -L "$website" && find -type f -name '*.sqlog' | xargs cat" > "$output_dir_quic/$filename/$filename-curl.sqlog"
	
	# Get qlog information for the web page
	cd $HOME/quiche && cargo run --bin quiche-client -- --source-port $port_num --idle-timeout 1000 "$website"
	
	# Kill tcpdump
	kill -HUP $1
	
	# Increase port_num
	port_num=$(($port_num+1))
	echo $port_num
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
		tcpdump -i eno2 tcp port $port_num -w "$output_dir_tcp/$filename/$filename-tcpdump.pcap"
	} &

	# allow backgrounded block to start running before curl command
	sleep 1
	
	# Use curl to fetch the web page
	curl --local-port $port_num -D "$output_dir_tcp/$filename/$filename-curl.html" -vs "$website"
	
	# Kill tcpdump
	kill -HUP $1
	
	# Increase port_num
	port_num=$(($port_num+1))
	echo $port_num
done

echo "Packet Capture Complete"
