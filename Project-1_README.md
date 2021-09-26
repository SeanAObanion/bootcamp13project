## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![13 RedTeamDiagram](/home/sysadmin/Documents/GitHubRepo/bootcamp13project/Diagrams/13 RedTeamDiagram.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the  file may be used to install only certain pieces of it, such as Filebeat.

  - Ansible/install-elk.yml

This document contains the following details:
- Description of the Topologu
- Access Policies
- ELK Configuration
  - FilesBeats and MetricBeats installed.
  - Web-1 and Web-2 monitored.
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.
- The load balancer can manage and enforce session IDs in client cookies, and eliminates the need of the web servers being seen outside the internal virtual network.
- The jumpbox itself is configured to allow external access but has no internal access to other resources, except after attaching to the Docker container where the Ansible configurations that only has internal access.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the  web servers and system usage in Kibana dashboards included with each Beats installation.
- FileBeats locates and forward log file data for analysis and review. 
- MetricBeats locates and forwards metric data for analysis and review. 

The configuration details of each machine may be found below.

| Name         | Function                                        | IP Address                                  | Operating System     |
| ------------ | ----------------------------------------------- | ------------------------------------------- | -------------------- |
| Jump Box     | Gateway                                         | 10.1.0.7 , 173.27.113.65 port 22 (external) | Linux (ubuntu 20.04) |
| LoadBalancer | HTTP Load Balancer                              | 52.247.199.216 port 80 (external)           | Azure                |
| Web-1        | DVWA server                                     | 10.1.0.10                                   | Linux (ubuntu 20.04) |
| Web-2        | DVWA server                                     | 10.1.0.12                                   | Linux (ubuntu 20.04) |
| ELK          | Kibana configured with FileBeats and MeticBeats | 20.106.74.251 port 5601(external)           | Linux (ubuntu 20.04) |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

The Jumpbox and ELK machines can accept connections from the Internet. The Jumpbox is only allowed via pre-shared SSH key from the following IP addresses (corresponding to these cities where I live):
- 98.255.6.17 (Rancho Cordova)
- 173.27.113.65 (Cobb)
- The ELK server is externally only accessible as http://20.106.74.251:5601/

Machines within the network can only be accessed by SSH from the Jumpbox.

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses              |
| -------- | ------------------- | --------------------------------- |
| Jump Box | Yes                 | 98.255.6.17 173.27.113.65 port 22 |
| Web-1    | No                  | 10.1.0.x 10.2.0.x                 |
| Web-2    | No                  | 10.1.0.x 10.2.0.x                 |
| ELK      | Yes                 | 10.2.0.7 20.106.74.251 port 5601  |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- It's exactly repeatable to any number of servers number of times

The playbook implements the following tasks:
- Download and install Docker.io, Docker, and Python 3, and enable the Docker service to start on system boot.
- Configure system parameters.
- Into the Cocker container, download and install ELK, and open specific TCP ports.

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![ELK Docker screenshot](/home/sysadmin/Documents/GitHubRepo/bootcamp13project/Ansible/ELK Docker screenshot.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- 10.1.0.10, 10.1.0.12

We have installed the following Beats on these machines:
- FileBeats and MetricBeats

These Beats allow us to collect the following information from each machine:
- Errors and events in log files and System performance metrics.

### Using the Playbook
In order to use the playbooks, you will need to have an Ansible control node VM already configured, along with VMs for the webservers Web-1 & Web-2 and ELK. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the  ansible.cfg, hosts, WebDVWA-playbook.yml, and install-elk.yml files to /etc/ansible.
- Update the ansible.cfg file to set the remote user, update the hosts section name in the hosts file for [elk] and [webservers] with the target IP addresses and the location of Python on the ELK and Web servers that you want to run Beats on, and update install-elk.yml with the the remote user to match ansible.cfg.
- Run the WebDVWA-playbook.yml with "ansible-playbook WebDVWA-playbook.yml"
- Run the install-elk.yml playbook with "ansible-playbook install-elk.yml" and navigate to the Kibana web page (http://ElkIPaddress:5601/app/kibana) to check that the installation worked as expected.
- Copy the filebeat-config.yml and metricbeat-config.yml to /etc/ansible and update the Elasticserch output hosts field and Kibana host field to the IP address of the ELK server. Copy the  filebeat-playbook.yml and metricbeat-playbook.yml to /etc/ansible and from there run "ansible-playbook filebeat-playbook.yml" and "ansible-playbook metricbeat-playbook.yml" so that ELK can get logs and metrics from the web servers Web-1 and Web-2.
