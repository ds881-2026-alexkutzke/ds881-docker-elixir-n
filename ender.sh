# chmod +x ender.sh
# ./ender.sh

# Nome da imagem
IMAGE_NAME="api-calculadora-ender"

echo "Construindo a imagem Docker..."
# Constrói a imagem a partir do diretório atual
docker build -t $IMAGE_NAME .

echo "Iniciando o container na porta 8080..."
# Executa o container mapeando a porta 8080:8080
docker run -p 8080:8080 $IMAGE_NAME

# bash
curl -X POST http://localhost:8080/calcular \
     -H "Content-Type: application/json" \
     -d '{"operador": "multiplicacao", "op1": 7, "op2": 6}'
