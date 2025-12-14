# Entorno de Desarrollo: WordPress + MySQL + phpMyAdmin

Este repositorio contiene el **Entorno Mínimo Viable (MVE)** para el módulo de Entornos de Desarrollo de 1º de DAM. Utiliza Docker para desplegar un servidor web completo sin necesidad de instalar XAMPP o WAMP localmente.


## 📋 Requisitos Previos
* Tener instalado **Docker Desktop** o **Docker Engine**.
* Tener conexión a Internet (para descargar las imágenes la primera vez).

## 🚀 Instalación y Despliegue

1.  **Clonar o descargar** este proyecto en una carpeta de tu ordenador.
2.  Abrir una terminal en dicha carpeta.
3.  Ejecutar el siguiente comando para levantar los servicios en segundo plano:

    ```bash
    docker-compose up -d
    ```

4.  Esperar unos segundos a que los contenedores arranquen y la base de datos se inicie correctamente.

## 🌍 Acceso a los Servicios

Una vez desplegado, puedes acceder a las aplicaciones a través de tu navegador:

* **Web (WordPress):** [http://localhost:8080](http://localhost:8080)
* **Gestor BBDD (phpMyAdmin):** [http://localhost:8081](http://localhost:8081)

## 🔐 Credenciales del Entorno

Están definidas en el `docker-compose.yml`. Para este entorno académico son:

* **Base de datos:** `wordpress_db`
* **Usuario MySQL:** `wordpress_user`
* **Contraseña MySQL:** `wordpress_password`
* **Contraseña Root MySQL:** `root_password`

## 🛑 Parar el entorno
Para detener los contenedores sin borrar los datos:
```bash
docker-compose stop
Para detener y borrar los contenedores (los datos persisten en los volúmenes):

Bash

docker-compose down
