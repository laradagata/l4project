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

#mkdir -p "$output_dir"

#sudo docker run --rm -it ymuski/curl-http3 whoami

for website in "${websites[@]}"; do
	# Extract the domain to use as the filename
	filename=( $(awk -F'/' '{print $3}' <<< "$website"))
	
	echo "$website"
	
	# Start tcpdump to capture QUIC network traffic 
	# Backgrounding this block to establish two threads
	{
		sudo tcpdump -n udp -SX -i any port 443 -w "$output_dir_quic/$filename.pcap"
	} &

	# allow backgrounded block to start running before curl command
	sleep 1
	
	#export QLOGDIR="$output_dir" 
	
	# Use curl to fetch the web page
	#sudo docker run -it ymuski/curl-http3 export QLOGDIR=/opt
	sudo docker run -it --rm ymuski/curl-http3 /bin/bash -c "export QLOGDIR=/opt && curl --http3 -IL "$website" && find -type f -name '*.sqlog' | xargs cat " > "$output_dir_quic/$filename.html"
	#sudo docker run -it --rm ymuski/curl-http3 curl -V
	kill -HUP $1
	
done

for website in "${websites[@]}"; do
# Extract the domain to use as the filename
	filename=( $(awk -F'/' '{print $3}' <<< "$website"))
	
	echo "$website"
	
	# Start tcpdump to capture QUIC network traffic 
	# Backgrounding this block to establish two threads
	{
		sudo tcpdump -i enp0s3 tcp -w "$output_dir_tcp/$filename.pcap"
	} &

	# allow backgrounded block to start running before curl command
	sleep 1
	
	#export QLOGDIR="$output_dir" 
	
	# Use curl to fetch the web page
	#sudo docker run -it ymuski/curl-http3 export QLOGDIR=/opt
	sudo curl -D "$output_dir_tcp/$filename.html" -vs "$website"
	#sudo docker run -it --rm ymuski/curl-http3 curl -V
	kill -HUP $1
done

#sudo docker run -it ymuski/curl-http3 ls /opt
	
# Stop tcpdump

echo "Packet Capture Complete"
