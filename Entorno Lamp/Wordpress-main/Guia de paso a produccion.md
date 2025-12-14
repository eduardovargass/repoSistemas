# ⚠️ Guía de Paso a Producción

Este entorno está configurado para **Desarrollo (Clase)**. Si quisieras subir este proyecto a un servidor real en Internet, es CRÍTICO realizar los siguientes cambios por seguridad:

## 1. Gestión de Secretos (.env)
**NUNCA** dejes las contraseñas escritas directamente en el `docker-compose.yml`.
* Crea un fichero llamado `.env` en la misma carpeta.
* Escribe dentro: `MYSQL_ROOT_PASSWORD=UnaContraseñaMuyDificil123!`
* En el `docker-compose.yml`, sustituye la contraseña por `${MYSQL_ROOT_PASSWORD}`.
* Añade el fichero `.env` a tu `.gitignore` para no subirlo a GitHub.

## 2. Eliminar PhpMyAdmin
PhpMyAdmin es una puerta de entrada habitual para atacantes. En un servidor de producción, **no** debes desplegar este contenedor. Si necesitas gestionar la BBDD, usa un túnel SSH seguro.

## 3. Puertos Estándar y Proxy Inverso
En producción, las webs no usan el puerto 8080, sino el 80 (HTTP) y 443 (HTTPS).
* No expongas el puerto de la base de datos ni el de WordPress directamente.
* Usa un contenedor "Proxy Inverso" (como **Nginx** o **Traefik**) que reciba el tráfico y lo mande a WordPress.

## 4. HTTPS (Candado de seguridad)
Es obligatorio hoy en día. Deberías configurar certificados SSL (Let's Encrypt) para que la conexión vaya cifrada.

## 5. Backups
Aunque usamos volúmenes (`wordpress_data`), en un servidor real debes configurar un script que haga copias de seguridad de esa carpeta y del volcado SQL (`mysqldump`) periódicamente y las envíe a otro lugar (ej. AWS S3).


# 📋 Ejemplo de proyecto real a producción siguiendo los pasos anteriores

Aquí tienes la transformación del ejercicio hacia un entorno de producción real.

## Concepto Clave para los Alumnos: "The 12-Factor App"
Estamos siguiendo el principio de separación de configuración y código.
* Código: El docker-compose.yml (es la estructura, no cambia).
* Configuración: El fichero .env (contiene las contraseñas y versiones, cambia según el entorno).

1. El fichero .env (Fichero de variables de entorno)
Este fichero NO se sube al repositorio (debe estar en el .gitignore). Aquí definimos los secretos y configuraciones específicas.

* Nombre del fichero: .env

* Properties

# --- CONFIGURACIÓN DE PROYECTO ---
PROJECT_NAME=blog_produccion

# --- CONFIGURACIÓN DE BASE DE DATOS ---
# ¡En producción usa contraseñas largas y complejas!
MYSQL_VERSION=8.0
DB_NAME=wordpress_prod_db
DB_USER=wp_user_prod
DB_PASSWORD=SecretPassword_123!
DB_ROOT_PASSWORD=VeryComplexRootPassword_987!

# --- CONFIGURACIÓN DE WORDPRESS ---
WORDPRESS_VERSION=latest
# Puerto externo: En producción solemos usar el 80 (HTTP estándar)
EXTERNAL_PORT=80
2. El fichero docker-compose.prod.yml
Observa los cambios importantes respecto a la versión de desarrollo:

* Sustitución de valores: Ya no hay contraseñas escritas, sino ${VARIABLES}.

* Política de reinicio: Se añade restart: always. Si el servidor se reinicia, la web arranca sola.

* Sin PhpMyAdmin: Por seguridad, eliminamos el gestor de BBDD público. En producción no queremos facilitar puertas traseras.

* Límites de recursos: (Opcional pero recomendado) Para evitar que un contenedor consuma toda la RAM del servidor.

* Nombre del fichero: docker-compose.prod.yml

YAML

version: '3.8'

services:
  wordpress:
    image: wordpress:${WORDPRESS_VERSION}
    container_name: ${PROJECT_NAME}_web
    restart: always # Si el contenedor falla o el servidor se reinicia, Docker lo levanta de nuevo
    ports:
      - "${EXTERNAL_PORT}:80"
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: ${DB_USER}
      WORDPRESS_DB_PASSWORD: ${DB_PASSWORD}
      WORDPRESS_DB_NAME: ${DB_NAME}
    volumes:
      - wordpress_data:/var/www/html
      # Opcional: Mapear un fichero de configuración PHP personalizado si fuera necesario
      # - ./uploads.ini:/usr/local/etc/php/conf.d/uploads.ini 
    depends_on:
      - db
    # Buenas prácticas: Limitar recursos en producción
    deploy:
      resources:
        limits:
          memory: 512M

  db:
    image: mysql:${MYSQL_VERSION}
    container_name: ${PROJECT_NAME}_db
    restart: always
    environment:
      MYSQL_DATABASE: ${DB_NAME}
      MYSQL_USER: ${DB_USER}
      MYSQL_PASSWORD: ${DB_PASSWORD}
      MYSQL_ROOT_PASSWORD: ${DB_ROOT_PASSWORD}
    volumes:
      - db_data:/var/lib/mysql
    # Por seguridad, en producción NO exponemos el puerto 3306 hacia fuera 
    # (no hay sección 'ports'), solo es accesible internamente por Wordpress.

volumes:
  wordpress_data:
  db_data:

3. Instrucciones de Despliegue
Para que los alumnos sepan cómo lanzar este fichero específico, ya que por defecto Docker busca el docker-compose.yml estándar.


Markdown

# 🚀 Despliegue en Producción

Este procedimiento utiliza variables de entorno para asegurar las credenciales y configura los servicios para alta disponibilidad y seguridad, simulando un entorno real.

## Paso 1: Seguridad
Antes de lanzar nada, verificamos la protección de secretos:

1.  Asegúrate de que el fichero `.env` existe en el servidor con las credenciales complejas.
2.  Verifica que `.env` está añadido a tu fichero `.gitignore`.
    > **⚠️ IMPORTANTE:** Nunca subas contraseñas reales a GitHub o GitLab.

## Paso 2: Ejecución
Al tener un nombre de fichero distinto para producción (`docker-compose.prod.yml`), debemos indicárselo explícitamente a Docker con el flag `-f`. Además, cargamos las variables de entorno:

# 🚀 Despliegue en Producción

Este procedimiento utiliza variables de entorno para asegurar las credenciales y configura los servicios para alta disponibilidad y seguridad, simulando un entorno real.

## Paso 1: Seguridad
Antes de lanzar nada, verificamos la protección de secretos:

1.  Asegúrate de que el fichero `.env` existe en el servidor con las credenciales complejas.
2.  Verifica que `.env` está añadido a tu fichero `.gitignore`.
    > **⚠️ IMPORTANTE:** Nunca subas contraseñas reales a GitHub o GitLab.

## Paso 2: Ejecución
Al tener un nombre de fichero distinto para producción (`docker-compose.prod.yml`), debemos indicárselo explícitamente a Docker con el flag `-f`. Además, cargamos las variables de entorno:

### Levantar el entorno de producción

docker-compose -f docker-compose.prod.yml --env-file .env up -d 

## Paso 3: Mantenimiento
Como no estamos usando el fichero estándar, para cualquier tarea de administración debemos seguir usando el flag -f:

### Ver logs en tiempo real (para depurar errores)
docker-compose -f docker-compose.prod.yml logs -f

### Parar el sistema y eliminar contenedores
docker-compose -f docker-compose.prod.yml down

# 🛡️ Diferencias Clave con Desarrollo (Dev)
1. PhpMyAdmin eliminado: Por seguridad, en producción no desplegamos gestores de base de datos web públicos, ya que son un objetivo frecuente de ataques. Se debe usar una conexión SSH segura o un cliente MySQL mediante túnel.

2. Reinicio Automático: Los servicios tienen configurado restart: always, lo que garantiza que si el servidor se reinicia, la web vuelva a levantar sola.

3. Puerto 80: La web escucha directamente en el puerto estándar de internet (80) en lugar del 8080.

4. Ocultación de BBDD: El puerto de la base de datos no se expone al exterior (ports), solo es visible para WordPress dentro de la red interna de Docker.


# 🎓 Actividad Extra Sugerida: "El Desastre de Seguridad"
Para reforzar el aprendizaje sobre por qué usamos el fichero .env, realiza lo siguiente:

1. Sube tu proyecto (la versión de desarrollo con las claves escritas en el código) a un repositorio público de prueba.

2. Simula ser un hacker: Busca en Google lo siguiente: site:github.com filename:docker-compose.yml password

3. Analiza: Investiga y debate en clase por qué los ciberdelincuentes tienen bots escaneando GitHub 24/7 buscando exactamente ficheros como el que acabas de subir.

4. Soluciona: Implementa el fichero .env (nuestra "vacuna") y añade el archivo al .gitignore para remediar esta vulnerabilidad crítica.

5. Investigación: Profundiza preguntando a la IA: "¿Cómo puedo hacer un script automático en Linux para hacer backup de mi volumen docker de MySQL y subirlo a la nube?".