# 🌐 EMV 2: Web Full Stack (HTML, CSS, JS, Backend, CI/CD Simulado)
Este EMV simula un escenario de desarrollo web completo con dos servicios Docker interconectados: un servidor de Frontend (Nginx) y un servidor Backend (Node.js). Esto permite simular un entorno de desarrollo con Integración Continua (CI) y un servidor de despliegue.
## 📁 Estructura del Proyectomi-emv-web-ci-cd/
```File
├── backend/               # Código del servidor backend (simula el punto de subida/API)
│   └── server.js
├── frontend/              # Código del frontend (HTML, CSS, JS)
│   └── index.html
├── docker-compose.yml     # Definición de los servicios
└── README.md
```
# 🛠️ Requisitos
Docker Desktop (o Docker Engine)
## ⚙️ Servicios Definidos en docker-compose.yml
Servicio        |       Tecnología      |       Puerto      |       Propósito
                                          (Host:Contenedor)       
frontend-dev            Nginx                   8080:80             Entorno de Desarrollo/Subida: Servidor web 
                                                                    para el código estático(HTML/CSS/JS)
backend                 Node.js                 3000:3000           Servidor Backend/API: Simula un servidor de aplicación o el                                                                  punto de staging.

## 🚀 Pasos para la Ejecución
1. Clonar el Repositorio:
```Bash
    git clone [URL_DE_TU_REPOSITORIO] mi-emv-web-ci-cd
    cd mi-emv-web-ci-cd
```
2. Levantar el Entorno: Ejecuta el comando para levantar ambos servicios en modo detached (-d):
```Bash 
    docker compose up -d
```

3. Acceso a los Entornos:
* Frontend / Desarrollo: Abre tu navegador en http://localhost:8080(Verás el contenido de frontend/index.html)
* Backend / Despliegue Simulado: Abre tu navegador en http://localhost:3000(Verás el mensaje del servidor Node.js)

Simulación CI/CD: Cualquier cambio que hagas en los archivos frontend/index.html o backend/server.js se refleja inmediatamente en los contenedores porque las carpetas están montadas como volúmenes.

4. Verificar Logs:
Puedes revisar la salida del servidor backend (Node.js) con:
```Bash
    docker logs web_backend_ci
```
## 🧹 Detener y Limpiar
Para detener y eliminar los contenedores (las imágenes base permanecerán):
```Bash
    docker compose down
```