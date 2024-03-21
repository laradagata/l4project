# Readme

The structure of the `src/` folder of this repository is as follows:

* `main/` contains the code needed to run the packet capture for this project, the list of top URLs, and the setup scripts to install all necessary dependencies.
  * `packetCapture.sh` can be run to perform the packet capture.
  * `majestic_million.csv` contains the list of top 1000 URLs which are queried in the packet capture script.
  * `main/setup/` contains the two files with all dependencies necessary to run the code for this project.
    * `setup.sh` can be run to install all necessary dependencies to run the packet capture script `packetCapture.sh` in this directory.
    * `requirements.txt` can be used with `pip` to install all necessary dependencies to run the `data_analysis.ipynb` in the `/data/notebooks/` directory of this repository.

## Build instructions

### Requirements

The pre-requisites to set up the data collection aspect of this project are as follows.

* VM created with Oracle Virtualbox Platform using Linux 6.5.0 kernel of Ubuntu 22.04
* Windows 11 host machine

The requirements necessary to set up the data analysis aspect of the project are as follows.

* Python 3.11.1
* Packages listed in `requirements.txt`

### Build Packet Capture Script

To install the necessary dependencies for running the packet capture script on a Linux VM, run the following command on a Linux terminal.


```
cd ~/l4project/src/main/setup && ./setup.sh
```

### Build Data Analysis Notebook

To install the necessary requirements to run the data analysis Jupyter Notebook file, run the following commands on a Windows terminal.

NB: Replace `<local_directory>` with the path on your local machine where this repository has been cloned.

```
cd <local_directory>/l4project/src/main/setup
pip install -r requirements.txt
```

To retrieve TLS information from the *pcap* files, it is necessary to clone the `ssl_tls` branch of the *scapy* repository with the following command.

```
git clone -b py3compat https://github.com/tintinweb/scapy-ssl_tls
```

### Run Packet Capture

To run the packet capture script and collect data relating to the URLs in `majestic_million.csv`, run the following command on a Linux terminal.

```
cd ~/l4project/src/main && ./packetCapture.sh
```

