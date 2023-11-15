FROM alpine:latest

# Gerekli paketleri yükleyin (örneğin, git, curl vs.)
RUN apk add --no-cache git curl

# Action'ınızın çalıştıracağı script'i ekleyin
COPY entrypoint.sh /entrypoint.sh

# Script'in çalıştırılabilir olduğundan emin olun
RUN chmod +x /entrypoint.sh

# Docker konteyneri başladığında çalışacak komut
ENTRYPOINT ["/entrypoint.sh"]
