#!/bin/bash

# Configuración de rutas y variables
PROJECT_DIR="$HOME/docker-lab"
BACKUP_DIR="$HOME/docker-lab/backups"
DATE=$(date +%Y-%m-%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/backup_lab_$DATE.tar.gz"

# 1. Crear directorio de backups si no existe
mkdir -p "$BACKUP_DIR"

echo "=== Inicio de copia de seguridad: $(date) ==="

# 2. Generar archivo comprimido de la web y el docker-compose
tar -czf "$BACKUP_FILE" -C "$PROJECT_DIR" web docker-compose.yml

if [ $? -eq 0 ]; then
    echo "[OK] Copia de seguridad generada con exito: $BACKUP_FILE"
else
    echo "[ERROR] Hubo un fallo al crear la copia de seguridad"
    exit 1
fi

# 3. Rotacion de backups: Eliminar copias de mas de 7 dias
echo "Limpiando backups antiguos de mas de 7 dias..."
find "$BACKUP_DIR" -type f -name "*.tar.gz" -mtime +7 -exec rm -f {} \;

echo "=== Copia de seguridad finalizada ==="
