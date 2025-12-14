# Python&VSCode
Proyecto Phyton de integración con VSCode

## 🚀 EMV 1: Entorno de Desarrollo Python con Visual Studio Code (Dev Containers)
Este proyecto proporciona un Entorno Mínimo Viable (EMV) para el desarrollo de aplicaciones Python, completamente aislado y configurable gracias a Docker y la extensión Remote - Containers de Visual Studio Code (VS Code).

## 📁 Estructura del Proyecto
Crea la siguiente estructura de carpetas:

```file

mi-emv-python/
├── .devcontainer/
│   └── devcontainer.json
├── app/
│   └── main.py
├── docker-compose.yml
└── README.md

```
## 🛠️ Requisitos
* Docker Desktop (o Docker Engine)

* Visual Studio Code

* Extensión de VS Code: Remote - Containers (ID: ms-vscode-remote.remote-containers)

## ⚙️ Pasos para la Configuración y Ejecución
Sigue estos pasos para levantar el entorno y comenzar a codificar:

1. Clonar el Repositorio:

```Bash

git clone [URL_DE_TU_REPOSITORIO] mi-emv-python
cd mi-emv-python
```

2. Abrir en VS Code: Abre la carpeta mi-emv-python en Visual Studio Code.

3. Adjuntar al Contenedor:

* VS Code detectará automáticamente el archivo .devcontainer/devcontainer.json.

* Verás una notificación emergente en la esquina inferior derecha: "Folder has a Dev Container configuration. Reopen in Container?"

* Haz clic en el botón "Reopen in Container".

  Alternativa: Si no ves la notificación, pulsa F1 (o Ctrl+Shift+P), busca y selecciona "Remote-Containers: Reopen in Container".

4. Desarrollo:

* El proceso tardará unos segundos en construir (la primera vez) y adjuntarse al contenedor (python_emv_dev).

* Una vez dentro, el indicador inferior izquierdo de VS Code mostrará Dev Container: Python Dev EMV.

* Ya puedes editar el código en la carpeta app/, instalar paquetes con pip, y ejecutar scripts de Python.

5. Ejecutar el Ejemplo: Abre el terminal integrado de VS Code (que ahora está dentro del contenedor) y ejecuta:

```Bash

python app/main.py
```
##🧹 Detener y Limpiar
Para cerrar la sesión de desarrollo:

* Salir del Contenedor: En VS Code, pulsa F1 y selecciona ***"Remote-Containers: Close Remote Connection"***.

* Detener el Contenedor: En tu terminal, ejecuta:

  ```Bash
    docker compose down

  ```

## 📄 Composición de Archivos
1. docker-compose.yml
Define el servicio de Python.

```YAML

version: '3.8'

services:
  python-dev:
    # Utiliza una imagen base de Python oficial
    image: python:3.11-slim
    # Asigna un nombre al contenedor para fácil referencia
    container_name: python_emv_dev
    # Monta la carpeta 'app' del host en '/workspace' del contenedor
    # Este es el código que editarás en VS Code
    volumes:
      - ./app:/workspace
    # Permanece encendido para que VS Code pueda adjuntarse a él
    command: tail -f /dev/null
    # Configuración de red (opcional, pero útil si añades más servicios)
    networks:
      - dev-network

networks:
  dev-network:
    driver: bridge
    
```

2. .devcontainer/devcontainer.json
Este archivo es crucial para que Visual Studio Code (VS Code) se conecte al contenedor y lo configure como entorno de desarrollo remoto (usando la extensión Remote - Containers).

```JSON

{
    // Nombre que aparecerá en VS Code
    "name": "Python Dev EMV",
    // Referencia al servicio definido en docker-compose.yml
    "dockerComposeFile": [
        "../docker-compose.yml"
    ],
    "service": "python-dev",
    "workspaceFolder": "/workspace",
    // Extensiones de VS Code a instalar automáticamente en el contenedor
    "extensions": [
        "ms-python.python",
        "ms-vscode.live-server"
    ],
    // Comandos de post-creación (ejecutar pip install, etc.)
    "postCreateCommand": "pip install -r /workspace/requirements.txt || echo 'No requirements.txt found, skipping install.'"
}
```

3. app/main.py (Ejemplo de Código)

```Python

# app/main.py
def saludar():
    print("¡Hola desde el contenedor Docker de Python!")

if __name__ == "__main__":
    saludar()

```

