#!/bin/bash
# Ejecutamos este script como root (ENTRYPOINT)

# 1. PASO CRÍTICO: Configurar la contraseña VNC manualmente
# La variable VNC_PW debe estar definida en docker-compose.yml
VNC_USER_HOME="/home/DAMDAW"
VNC_PW_PATH="$VNC_USER_HOME/.vnc/passwd"

# Creamos el directorio .vnc si no existe
mkdir -p "$VNC_USER_HOME/.vnc"

# Escribimos la contraseña VNC desde la variable de entorno
if [ ! -f "$VNC_PW_PATH" ]; then
    echo "$VNC_PW" | vncpasswd -f > "$VNC_PW_PATH"
fi
chmod 600 "$VNC_PW_PATH"
chown DAMDAW:DAMDAW "$VNC_PW_PATH"

# 2. Ejecutar el script de startup de la imagen base como root
# Esto inicia el VNC server y el escritorio (ahora usará la contraseña configurada arriba)
/dockerstartup/vnc_startup.sh -listen 0.0.0.0

# 3. Mantener el contenedor vivo ejecutando tail como el usuario DAMDAW
exec sudo -u DAMDAW /bin/bash -c "tail -f /dev/null"