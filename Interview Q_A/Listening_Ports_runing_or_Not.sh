### Install net-tools:  sudo apt install net-tools

#!/bin/bash
# List all listening ports and the associated services
netstat -tuln | grep LISTEN

## Explanation
#### 1. netstat -tuln: This command uses netstat with the following options:
####    -t: Show TCP connections.
####    -u: Show UDP connections.
####    -l: Show only listening sockets (connections that are waiting for incoming traffic).
####    -n: Show numeric addresses and port numbers instead of resolving hostnames and service names.
#### 2. grep LISTEN: The output of netstat -tuln is piped into grep LISTEN to filter out only the lines where the state is LISTEN, indicating that the socket is actively waiting for incoming connections.
