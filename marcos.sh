#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="calculadora-api:marcos"
CONTAINER_NAME="calculadora-api-marcos"

docker build -f marcos.Dockerfile -t "$IMAGE_NAME" .
docker rm -f "$CONTAINER_NAME" >/dev/null 2>&1 || true
docker run -d --rm --name "$CONTAINER_NAME" -p 8080:8080 "$IMAGE_NAME"

echo "Container '$CONTAINER_NAME' em execução na porta 8080."
echo "Teste com:"
echo "curl -X POST http://localhost:8080/calcular -H 'Content-Type: application/json' -d '{\"operador\":\"multiplicacao\",\"op1\":7,\"op2\":6}'"
