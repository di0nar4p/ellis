# Use uma imagem Python oficial como imagem base.
# python:3.12-slim é uma boa escolha por ser relativamente pequena e ter as ferramentas necessárias.
# A versão 3.22 que você usou não existe, então estou usando a 3.12.
FROM python:3.12-slim

# Define o diretório de trabalho no container
WORKDIR /app

# Para evitar que o Python grave arquivos .pyc no host e garantir que os logs apareçam imediatamente
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker
COPY requirements.txt .

# Instala as dependências
RUN pip install --no-cache-dir -r requirements.txt

# Copia todo o código da aplicação para o diretório de trabalho
COPY . .

# Expõe a porta em que a aplicação será executada
EXPOSE 8000

# Comando para iniciar a aplicação com Uvicorn
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]