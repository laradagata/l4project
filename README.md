# Measuring QUIC Performance: An analysis of Security and Connection Establishment in QUIC with comparison to TCP

QUIC is a new transport layer protocol which has been in development since 2016, and has recently been deployed and finalised by the IETF in 2021 (Iyengar and Thomson 2021). Consequently, there are not many studies available which analyse the performance of QUIC, and even less studies which take active measurements in a non-closed testing environment. Moreover,
only a handful of papers explore the differences between QUIC and TCP, which is the most widespread transport protocol over the Internet currently. In order to bridge the gap between the deployment of QUIC and its related research, a measurement study has been performed by querying the top 1000 most popular URLs using both QUIC and TCP from multiple vantage points. The experiment conducted in this project is among the first to investigate the effects of the QUIC transport protocol on the establishment speed and security of connections, and comparing QUIC to the more widely-used transport protocol, TCP. The results presented in this study show that QUIC generally performs better than TCP in most aspects of connection establishment. However, the difference between QUIC and TCP performance is not as large as QUIC promises, with TCP often performing better than QUIC in high latency networks.


This repository contains the following files and directories: 

* `timelog.md` An exact time log for the time spent on this project during the academic year.
* `plan.md` A week-by-week plan for the project. 
* `data/` Data acquired by running measurements over QUIC and TCP, and the data analysis script for generating visualisations from the data collected.
* `src/` Source code for the project, containing the packet capture script.
* `status_report/` The status report submitted in December.
* `meetings/` Notes taken during the meetings with the supervisor, and the meeting minutes.
* `dissertation/` The dissertation.
* `presentation/` The presentation video and PowerPoint slides used.
