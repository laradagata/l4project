# Measuring QUIC performance: An analysis of security, connection establishment, and data transfer for QUIC with comparison to TCP

This project aims to take various measurements of Internet connections by running a bash script which queries the top 1000 websites using both QUIC and TCP, and collects the header information of all packets across these connections. The script is run from different locations in order to investigate how the speed of QUIC connections depends on the physical location from which a request is being made. Finally, the data collected is examined to compare the security and speed of connections between TCP and QUIC.

This repository contains the following files and directories: 

* `timelog.md` An exact time log for the time spent on this project during the academic year.
* `plan.md` A week-by-week plan for the project. 
* `data/` Data acquired by running measurements over QUIC and TCP.
* `src/` Source code for the project, containing the packet capture script.
* `status_report/` The status report submitted in December.
* `meetings/` Notes taken during the meetings with the supervisor, and the meeting minutes.
* `dissertation/` The dissertation.
* `presentation/` The presentation.
