#!/bin/bash

# Configuración
TOKEN="15234075733:AWWWNCsr3Sw_DdlYLd4mHIrQe-Nkfnbks"  # Token del bot
CHAT_ID="-100238976115"                                # ID del grupo
FILE_PATH="subir/"                                   # Archivo a enviar

# Asociación de nombres amigables a topic IDs
declare -A TOPICS
TOPICS["general"]=1
TOPICS["Zanahorías"]=2
TOPICS["Pepinos"]=3
TOPICS["Bondiola"]=4
TOPICS["papas"]=9
TOPICS["Salame"]=10
TOPICS["Misc"]=12

# Parámetros de entrada
CAPTION=${1:-"Aquí está tu archivo"}  # Primer argumento: caption del mensaje
TOPIC_NAME=$2                           # Segundo argumento: ID del topic

# Verificación de parámetros
if [ -z "$CAPTION" ] || [ -z "$TOPIC_NAME" ]; then
  echo "Uso: $0 \"mensaje\" \"nombre_del_topic\""
  exit 1
fi

# Validar si el nombre del topic está en el diccionario
TOPIC_ID=${TOPICS[$TOPIC_NAME]}
if [ -z "$TOPIC_ID" ]; then
  echo "Error: Topic '$TOPIC_NAME' no está definido. Usa uno de los siguientes: ${!TOPICS[@]}"
  exit 1
fi

## Recorrer cada archivo en la carpeta y enviarlo
for FILE in "$FILE_PATH"*; do
  if [ -f "$FILE" ]; then
    echo "Enviando $FILE a $TOPIC_NAME..."

    # Enviar el archivo a través de la API de Telegram
    curl -F chat_id="$CHAT_ID" \
         -F document=@"$FILE" \
         -F caption="$CAPTION" \
         -F message_thread_id="$TOPIC_ID" \
         "https://api.telegram.org/bot$TOKEN/sendDocument"
    
    # Esperar 30 segundos antes de enviar el próximo archivo
    echo "Esperando 30 segundos antes de enviar el siguiente archivo..."
    sleep 30
  fi
done
