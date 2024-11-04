#!/bin/bash

# Carregar variáveis de ambiente do arquivo .env
export $(grep -v '^#' .env | xargs)

# Criar o banco de dados
echo "Criando o banco de dados $DB_NAME..."
psql -U $DB_USER -h $DB_HOST -d postgres -c "CREATE DATABASE $DB_NAME;"

# Executa o dump.sql no esquema farmacia

psql -U "$DB_USER" -h "$DB_HOST" -d "$DB_NAME" -c "SET search_path TO farmacia;"

psql -U "$DB_USER" -h "$DB_HOST" -d "$DB_NAME" -f dump.sql


# Executa o seed.sql no esquema farmacia

 psql -U "$DB_USER" -h "$DB_HOST" -d "$DB_NAME" -c "SET search_path TO farmacia;"

 psql -U "$DB_USER" -h "$DB_HOST" -d "$DB_NAME" -f seed.sql

# Executar o seed.js
# echo "Executando o seed.js..."

 node seed.js

echo "Processo concluído."