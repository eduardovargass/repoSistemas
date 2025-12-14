# 💻 Entorno de Desarrollo BBDD con Docker Compose (MVE)

[cite_start]Este proyecto define un **Entorno Mínimo Viable (MVE)** utilizando Docker Compose[cite: 1, 2]. [cite_start]Proporciona una base de datos **MySQL 8.0** y la interfaz de gestión **phpMyAdmin** lista para usar[cite: 4, 7].

---

## 📝 Instrucciones de Instalación y Uso

[cite_start]Sigue estos pasos para poner en marcha tu entorno de desarrollo[cite: 11].

### Paso 1: Guardar la Configuración
[cite_start]Crea una carpeta vacía para tu proyecto (por ejemplo, `~/proyectos/entorno-dev-bbdd/`)[cite: 13]. [cite_start]Dentro de ella, crea un archivo llamado `docker-compose.yml` con el siguiente contenido[cite: 13]:

```yaml
version: '3.8'   # Versión de Docker Compose

services:
  # 1. Servicio de Base de Datos: MySQL
  db:
    image: mysql:8.0   # Utiliza la imagen oficial de MySQL 8.0
    container_name: mysql-dev-bbdd
    restart: always       # Reinicia automáticamente si falla o se detiene
    environment:
      # Variables esenciales para la configuración inicial de MySQL
      MYSQL_ROOT_PASSWORD: rootpassword   # ¡IMPORTANTE! Cambiar en producción
      MYSQL_DATABASE: mi_bbdd_dev
      MYSQL_USER: devuser
      MYSQL_PASSWORD: devpassword
    volumes:
      # Mapea un volumen persistente para guardar los datos de la BBDD
      - db_data:/var/lib/mysql
    ports:
      # Mapea el puerto 3306 del contenedor al puerto 3306 de tu máquina
      - "3306:3306"

  # 2. Servicio de Gestión de Base de Datos: phpMyAdmin
  phpmyadmin:
    image: phpmyadmin/phpmyadmin
    container_name: phpmyadmin-dev-gui
    restart: always
    environment:
      # Configuración para conectar a nuestro servicio 'db' (MySQL)
      PMA_HOST: db
      PMA_PORT: 3306
      MYSQL_ROOT_PASSWORD: rootpassword   # Usa la misma contraseña ROOT que MySQL
    ports:
      # Mapea el puerto 80 del contenedor al puerto 8080 de tu máquina
      - "8080:80"
    depends_on:
      - db   # Asegura que el servicio 'db' se inicie antes que phpMyAdmin

# Definición de volúmenes persistentes
volumes:
  db_data:
````

[cite\_start]*[cite: 4, 5, 6, 7, 8, 9]*

### Paso 2: Levantar los Contenedores

[cite\_start]Abre tu terminal, navega hasta la carpeta donde guardaste el archivo y ejecuta el siguiente comando[cite: 15]:

```bash
docker compose up -d
```

  * [cite\_start]`docker compose up`: Construye y levanta los servicios definidos en el archivo[cite: 18].
  * [cite\_start]`-d`: Ejecuta los contenedores en modo *detached* (segundo plano) para liberar la terminal[cite: 19].

### Paso 3: Verificar el Estado

[cite\_start]Verifica que ambos contenedores se han levantado correctamente[cite: 21]:

```bash
docker compose ps
```

[cite\_start]Deberías ver los servicios `db` y `phpmyadmin` con el estado `running`[cite: 24].

### Paso 4: Acceder a phpMyAdmin

[cite\_start]Abre tu navegador web y ve a la siguiente dirección[cite: 26]:
**http://localhost:8080**
[cite\_start]*(Nota: El archivo de configuración mapea el puerto 8080 [cite: 8][cite\_start], aunque el texto original mencionaba 8082 [cite: 27]).*

[cite\_start]Inicia sesión con las credenciales definidas[cite: 28]:

  * [cite\_start]**Servidor:** `db` [cite: 29]
  * [cite\_start]**Usuario:** `devuser` [cite: 30]
  * [cite\_start]**Contraseña:** `devpassword` [cite: 31]
  * [cite\_start]*(Opcional)* Acceso root: Usuario `root` y Contraseña `rootpassword`[cite: 32].

-----

## 🛠️ Ejemplo Práctico: Acceso a MySQL desde la Terminal

[cite\_start]A continuación se muestra cómo interactuar con la base de datos directamente desde la terminal, simulando una conexión cliente[cite: 34].

### 1\. Acceder al Contenedor MySQL

[cite\_start]Utiliza el comando `exec` para acceder al shell del contenedor[cite: 36]:

```bash
docker exec -it mysql-dev-bbdd bash
```

  * [cite\_start]`-it`: Mantiene la entrada interactiva y asigna un terminal[cite: 40].
  * [cite\_start]`mysql-dev-bbdd`: Nombre del contenedor[cite: 41].
  * [cite\_start]`bash`: Comando para abrir el shell[cite: 42].

### 2\. Conectarse al Servidor MySQL

[cite\_start]Una vez dentro, conéctate como `devuser`[cite: 44]:

```bash
mysql -u devuser -p mi_bbdd_dev
```

[cite\_start]Te pedirá la contraseña: introduce `devpassword`[cite: 47].

### 3\. Ejecutar Comandos SQL

[cite\_start]Ahora puedes ejecutar comandos SQL directamente[cite: 49]:

**Crear una tabla de ejemplo:**

```sql
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2)
);
```

[cite\_start]*[cite: 52]*

**Insertar un registro:**

```sql
INSERT INTO productos (nombre, precio) VALUES ('Laptop Dev', 1200.50);
```

[cite\_start]*[cite: 55]*

**Consultar los datos:**

```sql
SELECT * FROM productos;
```

[cite\_start]*[cite: 58]*

### 4\. Salir

  * [cite\_start]Salir del cliente MySQL: escribe `exit`[cite: 61].
  * [cite\_start]Salir del contenedor (volver a tu terminal principal): escribe `exit`[cite: 64].

-----

## 🗑️ Gestión del Entorno (Detener y Eliminar)

[cite\_start]Cuando termines tu sesión de trabajo, utiliza los siguientes comandos[cite: 66]:

  * **Detener los servicios (mantiene los datos):**

    ```bash
    docker compose stop
    ```

    [cite\_start]*[cite: 67, 69]*

  * **Detener y eliminar contenedores y red (mantiene los datos):**

    ```bash
    docker compose down
    ```

    [cite\_start]*[cite: 70, 72]*

  * **⚠️ Detener y eliminar TODO (contenedores, red Y datos persistentes):**
    ¡Cuidado\! [cite\_start]Este comando eliminará todos los datos de tu base de datos[cite: 74].

    ```bash
    docker compose down -v
    ```

    [cite\_start]*[cite: 73, 76]*

-----

## ❓ Solución de Problemas (Troubleshooting)

Si encuentras errores al levantar el entorno, revisa estas soluciones comunes:

  * **Error "Port already allocated":** Si el puerto 3306 está ocupado, detén tu MySQL local o cambia el puerto en el `docker-compose.yml` (ej. `"3307:3306"`).
  * **Error de conexión en phpMyAdmin:** Si ves un error de "Connection refused", espera 30 segundos a que MySQL termine de iniciarse y recarga la página.
  * **Cambio de contraseñas:** Si modificas las contraseñas en el YAML después de la primera ejecución, deberás borrar el volumen (`docker compose down -v`) para que los cambios surtan efecto.

<!-- end list -->

```
```
