# Readme

Put a brief description of your code here. This should at least describe the file structure.

## Build instructions

### Requirements

The pre-requisites to set up the data collection aspect of this project are as follows.

* VM created with Oracle Virtualbox Platform using Linux 6.5.0 kernel of Ubuntu 22.04
* Windows 11 host machine

The requirements necessary to set up the data analysis aspect of the project are as follows.

* Python 3.11.1
* Packages listed in `requirements.txt`

### Build Project

To install the necessary dependencies for running the packet capture script on a Linux VM, run the following command on a Linux terminal.


```
cd ~/l4project/src/main && ./setup.sh
```


To install the necessary requirements to run the data analysis Jupyter Notebook file, run the following commands on a Windows terminal.

NB: Replace `<local_directory>` with the path on your local machine where this repository has been cloned.

```
cd <local_directory>/l4project/data/notebooks
pip install -r requirements.txt
```

### Run Packet Capture

To run the packet capture script and collect data relating to the URLs in `majestic_million.csv`, run the following command on a Linux terminal.

```
cd ~/l4project/src/main && ./packetCapture.sh
```

