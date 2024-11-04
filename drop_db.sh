#!/bin/bash

# Carregar variáveis de ambiente do arquivo .env
export $(grep -v '^#' .env | xargs)

#Encerrar a sessão do psql
psql -U $DB_USER -h $DB_HOST -d postgres -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname='grupo_laranja';"
# Excluir o banco de dados
echo "Excluindo o banco de dados \"$DB_NAME\"..."

psql -U $DB_USER -h $DB_HOST -d postgres -c "DROP DATABASE IF EXISTS \"$DB_NAME\";"

echo "Banco de dados \"$DB_NAME\" excluído com sucesso."