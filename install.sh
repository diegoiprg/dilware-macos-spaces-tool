#!/usr/bin/env bash

echo "🚀 Instalando dilware-myself-macos-tool-mission-control-spaces..."

REPO_DIR="$HOME/dilware-myself-macos-tool-mission-control-spaces"
HS_DIR="$HOME/.hammerspoon"
INIT_FILE="init.lua"

# Clonar el repositorio si no existe
if [ ! -d "$REPO_DIR" ]; then
  echo "🔧 Clonando el repositorio en $REPO_DIR..."
  git clone https://github.com/diegoiprg/dilware-myself-macos-tool-mission-control-spaces.git "$REPO_DIR"
else
  echo "📁 El repositorio ya existe en $REPO_DIR, usando el existente."
fi

# Copiar el archivo init.lua al directorio de Hammerspoon
if [ -d "$HS_DIR" ]; then
  echo "📦 Copiando $INIT_FILE a $HS_DIR..."
  cp "$REPO_DIR/$INIT_FILE" "$HS_DIR/$INIT_FILE"
  echo "✅ Configuración aplicada. Abre Hammerspoon y presiona ⌘ + R para recargar."
else
  echo "❌ Error: No se encontró la carpeta $HS_DIR. Asegúrate de tener Hammerspoon instalado y ejecutado al menos una vez."
  exit 1
fi