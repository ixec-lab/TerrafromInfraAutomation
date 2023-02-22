#!/bin/bash
sudo apt-get update -y
sudo apt-get install wget -y
sudo wget https://raw.githubusercontent.com/ixec-lab/simpleAppForTerraform/main/app.py -O /home/john/app.py
sudo apt-get install python3
sudo python3 /home/john/app.py&