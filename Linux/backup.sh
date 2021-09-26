#! /bin/bash/

tar -cvf /var/backup/home.tar /home
mv /var/backup/home.tar /var/backup/home.05062021.tar
ls -lh /var/backup >> /var/backup/diskreport.txt
free -h >> /var/backup/mem_report.txt
