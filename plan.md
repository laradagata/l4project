# Plan

*Measuring QUIC performance: An analysis of connection establishment and data transfer in QUIC with comparison to TCP*

Lara D'Agata (2526633D)

**Supervisor** - Dr. Colin Perkins

## Winter semester

* **Week 1**
  * Research and define a precise direction for the research project
  * First meeting with supervisor
  * Create GitHub repository for the project
* **Week 2**
  * Research and decide on a method for conducting the experiment
  * Start writing the *Background* section of the dissertation
* **Week 3**
  * Finalise *Background* section of the dissertation
  * Write a draft for the *Introduction* section of the dissertation
  * Contact PhD students for practical help
* **Week 4**
  * Start working on *Introduction* section of the dissertation
* **Week 5**
  * Meet PhD students and gained insight into the necessary elements for this research study.
  * Start implementing the Packet Capture script.
* **Week 6**
  * Meet PhD students again
  * Install all necessary software on host machine and Ubuntu VM
  * Perform practice measurements with tcpdump and Wireshark
* **Week 7**
  * Meet PhD students again
  * Write simple script for querying different websites using curl and tcpdump in the VM
  * Research qlog and how to use it with tcpdump
* **Week 8**
  * Meet PhD students again
  * Develop the script to make sure everything is working correctly
  * Make a list of the top 1000 websites to query for the measurements
* **Week 9**
  * Improve the script
  * Parse the list of top 1000 URLs
* **Week 10**
  * Meet PhD students to ask about DigitalOcean
  * Improve the packet capture script by implementing a separate tcpdump command for each queried URL
  * Start figuring out what is obtained from the data collected
* **Week 11**
  * Research how to resolve issue with VM not booting up
  * Contact PhD students about issue with VM
* **Week 12 [PROJECT WEEK]** Status report submitted.
  * Meet with supervisor and PhD students
  * Figure out how to improve the packet capture script
* **Week 13 [PROJECT WEEK]** Status report submitted.
  * Start taking some preliminary measurements

## Winter break
* Investigate what is causing the quiche-client command to run slowly
* Have a look at which cloud platforms can be used
* Fix the packet capture script: only quiche-client for QUIC, and only curl for TCP

## Spring Semester

* **Week 14**
  * Take more test measurements using a revised version of the docker command
* **Week 15**
  * Fix script to work without the docker image command
  * Research how to make quiche-client command run faster
* **Week 16**
  * Resolve issue of slow runtime for quiche-client command
  * Resolve issue of overlapping IPs in the pcap files
  * Take measurements from home
  * Start setting up environment on stlinux servers for taking measurements from campus
* **Week 17**
  * Resolve issue with empty pcap files created when URL does not support QUIC
  * Take measurements from home and campus
* **Week 18**
  * Fix interface issue with tcpdump on the campus server
  * Run final measurements from campus
  * Start coding data analysis
* **Week 19**
  * Generate a distribution plot for visualising the connection-establishment times in the qlog data
  * Show how many TLS handshake errors occurred
  * Show hoe many TLS Ciphers are established
  * Generate distribution plot for the connection establishment times in the pcap data
  * Start working on analysis of TLS information from pcap files
* **Week 20**
  * Keep trying to analyse TLS data from pcap files
  * Create graphs to show TCP data
  * Generate visuals for error data and TLS data using pandas dataframes
  * Make barebones draft of entire dissertation structure
* **Week 21**
  * Extract TLS data from pcap files
  * Create graphs for TCP data, RTT data, and transport vs security handshake data
  * Create tables for TLS ciphers and alerts in LateX
  * Write *Results* section of dissertation
* **Week 22**
  * Conduct relevant research necessary to write *Background* section of dissertation
  * Write *Background* section of dissertation
  * Write *Analysis & Requirements* section of dissertation
  * Make diagram of TCP/TLS vs QUIC connection establishment for *Background* section
  * Start writing *Experimental Design* section of dissertation
* **Week 23 [TERM ENDS]**
  * Finish writing *Experimental Design* section of dissertation
  * Write *Introduction* and *Conclusion* sections of dissertation
  * Make powerpoint for presentation video
* **Week 24** Dissertation submission deadline and presentations.
  * Proofread dissertation
  * Fix visualisations
  * Film presentation video
  * Sort dissertation file system and directories for GitHib repository
  * Write READMEs for GitHub repository
  * Submit dissertation

