#!/bin/bash

# Verificar si httpx está instalado
if ! command -v httpx &> /dev/null; then
    echo "Instalando httpx..."
    go get -u github.com/projectdiscovery/httpx/cmd/httpx
fi

# Verificar si go está instalado
if ! command -v go &> /dev/null; then
    echo "Go no está instalado. Por favor, instala Go antes de ejecutar este script."
    exit 1
fi
  

run_httpx_with_progress() {
    total_commands=$#
    current_command=0

    for command in "$@"; do
        current_command=$((current_command + 1))
        echo "Ejecutando comando $current_command de $total_commands..."
        eval "$command"

        # Verificar si el archivo resultante está vacío y eliminarlo si es necesario
        output_file=$(echo "$command" | awk -F ">>" '{print $2}' | tr -d ' ')
        if [ ! -s "$output_file" ]; then
            rm "$output_file"
        fi
    done
}


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
                           888                                                           v 2.0
                           888
                           888                                                             
                           
"

echo -e "${GREEN}$banner${ENDCOLOR}"

url=$1

mkdir httpxfinder

run_httpx_with_progress \
    "httpx -l $url -silent ports 80,81,300,443,591,593,832,981,1010,1311,2082,2087,2095,2096,2480,3000,3128,3333,4243,4567,4711,49003,5,5104,5108,5800,6543,7000,7396,7474,8000,8001,8008,8014,8042,8069,8080,8081,8088,8090,8091,8118,8123,8172,8222,8243,8280,8281,8333,8443,8500,8834,8880,8888,8983,9000,9043,9060,9080,9090,9091,9200,9443,9800,9981,12443,16080,18091,28081,28091,28091,7 >> httpxfinder/lives.txt" \
    "httpx -l $url --status-code --content-length -title -td -silent -ports 80,81,300,443,591,593,832,981,1010,1311,2082,2087,2095,2096,2480,3000,3128,3333,4243,4567,4711,49003,5,5104,5108,5800,6543,7000,7396,7474,8000,8001,8008,8014,8042,8069,8080,8081,8088,8090,8091,8118,8123,8172,8222,8243,8280,8281,8333,8443,8500,8834,8880,8888,8983,9000,9043,9060,9080,9090,9091,9200,9443,9800,9981,12443,16080,18091,28081,28091,28091,7  >> httpxfinder/vivos.txt" \
    "httpx -l httpxfinder/lives.txt -silent -path /server-status?full=true -status-code -content-length -title -mc 200  >> httpxfinder/apache-server.txt" \
    "httpx -l httpxfinder/lives.txt -silent -t 50 -ports 80,443,8080,8443,8081,8180,8090,8009 -path /web-console -status-code -content-length -title -mc 200 >> httpxfinder/web-console.txt" \
    "httpx -l httpxfinder/lives.txt -silent -t 50 -ports 80,443,8080,8443 -path '/?xss=\"</script><script>alert(\"XSS\")</script>\"' -mr '<script>alert(\"XSS\")</script>' >> httpxfinder/xss.txt" \
    "httpx -l httpxfinder/lives.txt -silent -t 50 -path /phpinfo.php --status-code --content-length -title -mc 200  >> httpxfinder/phpinfo.txt" \
    "httpx -l httpxfinder/lives.txt -silent -t 50 -path /swagger-api --status-code --content-length -title -mc 200 >> httpxfinder/swagger.txt" \
    #"httpx -l httpxfinder/lives.txt -silent -t 50 -path /HttpxFinder/sql.txt -title -status-code --content-length -mc 200 >> httpxfinder/sql_olvidado.txt" \
    #"httpx -l httpxfinder/lives.tx  -silent -t 50 -path /HttpxFinder/403_url_payloads.txt -title -status-code --content-length -mc 200 >> httpxfinder/403bypass.txt"

