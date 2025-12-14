# Usamos la imagen estable de consol como base
FROM consol/ubuntu-xfce-vnc:latest

# PASO DE CORRECCIÓN: Volvemos a root para instalar
# ... (Después de FROM consol/ubuntu-xfce-vnc:latest)

USER root

# 1. Instalar SUDO, utilidades y las nuevas herramientas
RUN apt-get update && \
    apt-get install -y \
    sudo \
    dos2unix \
    wget \
    # Herramientas de diagnóstico y gestión
    gparted \
    htop \
    net-tools \
    lsof \
    sysstat \
    # Limpieza de cache
    && rm -rf /var/lib/apt/lists/*

# 2. Crear tu nuevo usuario (DAMDAW)
RUN useradd -m -s /bin/bash -G sudo DAMDAW

# 3. Establecer la contraseña del nuevo usuario
RUN echo 'DAMDAW:12345DAMDAW2526' | chpasswd

# ----------------------------------------------------
# PASO FINAL Y CRÍTICO: Reemplazar Entrypoint
# ----------------------------------------------------

# 4. Copiar el script de entrada
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# 5. ¡CORREGIR EL FORMATO DE ARCHIVO!
RUN dos2unix /usr/local/bin/entrypoint.sh && chmod +x /usr/local/bin/entrypoint.sh

# 6. Establecer Entrypoint (siempre se ejecuta como root) y CMD vacío
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD []