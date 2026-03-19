#chmod +x angelo.sh
#./angelo.sh
docker build -t api-elixir:v1 -f angelo.Dockerfile .
docker run --rm -p 8080:8080 -d --name container-angelo api-elixir:v1

echo "Aguardando o servidor subir..."
for i in $(seq 1 15); do
  RESPONSE=$(curl -s http://localhost:8080 2>/dev/null)
  if [ -n "$RESPONSE" ]; then
    echo "Servidor pronto!"
    break
  fi
  echo "Tentativa $i... aguardando"
  sleep 1
done

curl -X POST http://localhost:8080/calcular \
     -H "Content-Type: application/json" \
     -d '{"operador": "multiplicacao", "op1": 20, "op2": 20}'

echo
echo "Parando o container..."
docker stop container-angelo