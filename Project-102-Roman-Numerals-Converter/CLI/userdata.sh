#! /bin/bash
yum update -y
yum install python3 -y
pip3 install flask
cd /home/ec2-user
wget -P templates https://raw.githubusercontent.com/cagatayakk/AWS_Projects/main/Project-102-Roman-Numerals-Converter/templates/index.html
wget -P templates https://github.com/cagatayakk/AWS_Projects/blob/main/Project-102-Roman-Numerals-Converter/templates/result.html
wget https://raw.githubusercontent.com/cagatayakk/AWS_Projects/main/Project-102-Roman-Numerals-Converter/app.py
python3 app.py
