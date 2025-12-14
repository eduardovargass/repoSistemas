# Entorno de Laboratorio Linux (MVE) - DAM/DAW

Este repositorio contiene un **Entorno Mínimo Viable (MVE)** dockerizado con un escritorio XFCE accesible vía VNC. Ha sido personalizado para incluir herramientas de administración y diagnóstico de sistemas.

## 📋 Requisitos Previos

* **Docker Desktop** instalado y ejecutándose.
* Un cliente VNC (recomendado: RealVNC o Remote Ripple).
* Git (opcional, para clonar este entorno).

## 🚀 Instrucciones de Instalación y Uso

### 1. Estructura de Ficheros
Asegúrate de tener la siguiente estructura en tu carpeta de trabajo:
```text
/mi-laboratorio
├── docker-compose.yml
├── custom-data/         (Se creará automáticamente para tus datos)
└── custom-xfce-build/
    ├── Dockerfile
    └── entrypoint.sh
```

## 🛠️ Construir la imagen y levantar el contenedor en segundo plano
docker-compose up -d --build
Nota: La primera vez tardará unos minutos en descargar la imagen base de Ubuntu y compilar las herramientas.

3. Acceso al Escritorio
Una vez iniciado el contenedor:

1. Abre tu visor VNC.

2. Conéctate a: localhost:5901 (o 127.0.0.1:5901).

3. Contraseña VNC: VNCpass1 (Configurada en el docker-compose.yml).

4. Usuario del sistema: DAMDAW | Contraseña: 12345DAMDAW2526 (para comandos sudo).

## ⚙️ Personalización (Opcional)
Si necesitas persistir tus trabajos, guarda todo en el directorio /home/miusuario dentro del entorno Linux; esto se sincronizará con la carpeta custom-data en tu ordenador anfitrión.

Si deseas cambiar la resolución de pantalla, edita el fichero docker-compose.yml:

```YAML
environment:
  VNC_RESOLUTION: "1920x1080" # Ejemplo para Full HD
```

## 🔄 Siguiente paso...
Leer el documento de instrucciones de la actividad y realizarla.