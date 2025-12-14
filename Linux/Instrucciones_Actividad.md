# Actividad Práctica: Administración y Monitorización en Linux Remoto

## 🎯 Objetivos de la Actividad
1.  Desplegar un entorno de servidor Linux con interfaz gráfica usando Docker.
2.  Configurar un cliente de acceso remoto (VNC).
3.  Utilizar herramientas de línea de comandos para el diagnóstico del sistema (`htop`, `lsof`, `net-tools`).

---

## 🛠️ Fase 1: Preparación del Entorno Cliente

Para acceder al servidor que vamos a desplegar, necesitamos un cliente VNC ligero y compatible. Usaremos **Remote Ripple** (o TightVNC/RealVNC en su defecto).

### Paso 1.1: Instalación de Remote Ripple
1.  Descarga **Remote Ripple** desde su web oficial o la tienda de aplicaciones de tu sistema operativo (Windows/Mac).
    * *Si no está disponible, descarga "RealVNC Viewer".*
2.  Instala la aplicación aceptando los valores por defecto.


---

## 🐳 Fase 2: Despliegue del Servidor (Docker)

Utilizando los ficheros proporcionados (`docker-compose.yml`, `Dockerfile`, `entrypoint.sh`):

1.  Abre tu terminal (PowerShell o Bash).
2.  Navega hasta la carpeta del proyecto.
3.  Ejecuta el comando de construcción:
    ```bash
    docker-compose up -d --build
    ```
4.  Verifica que el contenedor está activo:
    ```bash
    docker ps
    ```
    *Deberías ver un contenedor llamado `linux_custom_user` escuchando en el puerto `0.0.0.0:5901`.*

---

## 🖥️ Fase 3: Conexión y Pruebas

1.  Abre **Remote Ripple**.
2.  Crea una nueva conexión con los siguientes datos:
    * **Host:** `localhost` (o la IP de tu máquina si usas Docker Toolbox).
    * **Port:** `5901`.
    * **Display Name:** Laboratorio Linux.
3.  Al conectar, te pedirá autenticación. Introduce la contraseña VNC definida en el compose: **`VNCpass1`**.

---

## 🧪 Fase 4: Desarrollo de la Actividad (Laboratorio)

Una vez dentro del escritorio XFCE, abre la terminal ("Terminal Emulator") y realiza las siguientes tareas como el usuario `DAMDAW`.

> **Nota:** La contraseña para `sudo` es `12345DAMDAW2526`.

### Tarea A: Monitorización de Procesos con `htop`
1.  Ejecuta `htop` en la terminal.
2.  Identifica qué proceso está consumiendo más memoria.
3.  Filtra los procesos para ver solo los del usuario `DAMDAW` (Pista: usa la tecla `u`).
4.  Toma una captura de pantalla.

### Tarea B: Análisis de Puertos con `net-tools` y `lsof`
Queremos ver en qué puertos está escuchando nuestro servidor.
1.  Ejecuta:
    ```bash
    sudo netstat -tulpn
    ```
2.  ¿Ves el puerto del servidor VNC (5901) desde *dentro* del contenedor? ¿Por qué crees que sí o que no?
3.  Usa `lsof` para ver qué ficheros tiene abiertos el proceso del escritorio:
    ```bash
    lsof | grep xfce
    ```

### Tarea C: Gestión de Discos con `gparted`
Aunque estamos en un contenedor, tenemos acceso a herramientas de disco.
1.  Ejecuta `sudo gparted`.
2.  Analiza las particiones que muestra. *Nota: Al ser Docker, verás el sistema de archivos superpuesto (overlay), lo cual es normal.*

---

## 📝 Entrega
Sube al aula virtual un documento PDF que contenga:
1.  Captura de pantalla de `docker ps` mostrando el contenedor corriendo.
2.  Captura de tu escritorio remoto conectado vía Remote Ripple.
3.  Respuestas y capturas de las **Tareas A, B y C**.

---

## ⚠️ Solución de Problemas Frecuentes

* **Error "Connection Refused":** Asegúrate de que el contenedor sigue corriendo y no se ha detenido (`docker ps -a`). Si se detuvo, revisa los logs con `docker logs linux_custom_user`.
* **Error "Authentication Failure":** Verifica que estás usando `VNCpass1` para el VNC y `12345DAMDAW2526` para el usuario del sistema. Son diferentes.
* **Pantalla en Negro:** A veces el escritorio tarda unos segundos en cargar. Espera 10 segundo
