# SQL <- REST API
curl -X POST http://localhost:8081/v1/sql/statements \
  -H "Content-Type: application/json" \
  -d @sql_scripts/create_table.json