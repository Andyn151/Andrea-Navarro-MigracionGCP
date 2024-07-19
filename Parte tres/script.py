#!/bin/bash

# Configuración de variables
GROUP_IP="YOUR_GROUP_IP"  # Reemplazar con la dirección IP del grupo de instancias
REQUESTS_PER_SECOND=5     # Número de solicitudes por segundo
DURATION=3600             # Duración de la simulación en segundos (1 hora)
END_TIME=$((SECONDS + DURATION))

echo "Iniciando la simulación de autoescalado..."
echo "Enviando $REQUESTS_PER_SECOND solicitudes por segundo a $GROUP_IP durante $DURATION segundos."

# Función para enviar una solicitud HTTP
send_request() {
    curl -sS -o /dev/null $GROUP_IP
}

# Bucle para enviar solicitudes continuamente
while [ $SECONDS -lt $END_TIME ]; do
    for ((i = 0; i < $REQUESTS_PER_SECOND; i++)); do
        send_request &
    done
    sleep 1
done

echo "Simulación de autoescalado completada."
