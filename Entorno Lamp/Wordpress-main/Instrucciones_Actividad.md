
# 🎓 Actividad: Mi Primer Blog con CMS en Docker

**Objetivo:** Desplegar un CMS WordPress, entender la conexión entre el servidor web y la base de datos, y personalizar un sitio web básico.

## 🚀 IMPORTANTE: Cómo ejecutar y comenzar este proyecto
1.  Clonar el repositorio.
2.  Ejecutar `docker-compose up -d`.
3.  Acceder a `http://localhost:8080`.
4.  Realiza los siguientes pazos hasta completarlos...

## Paso 1: Despliegue
Sigue las instrucciones del `README.md` principal para levantar el entorno con `docker-compose up -d`.

## Paso 2: Instalación de WordPress
1.  Abre tu navegador y ve a `http://localhost:8080`.
2.  Verás el asistente de instalación de WordPress. Selecciona "Español".
3.  **Importante:** Como hemos configurado las variables de entorno en el Docker, WordPress *no debería* preguntarte por la base de datos. Si lo hace, usa las credenciales del `docker-compose.yml` (el servidor de base de datos es `db`, no localhost).
4.  Rellena la información del sitio:
    * **Título:** [Tu Nombre] Blog 1º DAM
    * **Usuario:** admin
    * **Contraseña:** (Una que recuerdes)
    * **Email:** tu correo corporativo.

## Paso 3: Verificación Técnica (Base de Datos)
Vamos a comprobar que Docker ha creado la conexión correctamente.
1.  Entra en phpMyAdmin: `http://localhost:8081`.
2.  Usuario: `root`, Contraseña: `root_password`.
3.  En la columna izquierda, busca la base de datos `wordpress_db`.
4.  **Tarea:** Verifica que se han creado tablas como `wp_users` o `wp_posts`. Esto confirma que la aplicación (WordPress) está escribiendo datos en el contenedor de base de datos (`db`).

## Paso 4: Personalización
1.  Entra al panel de administración (`/wp-admin`) de tu nuevo blog.
2.  Instala un tema gratuito desde Apariencia > Temas.
3.  Crea una primera entrada ("Hola Mundo") explicando qué es Docker con tus propias palabras.

## Paso 5: Comprobación de Persistencia
1.  Cierra el navegador.
2.  En tu terminal, escribe: `docker-compose down` (esto destruye los contenedores).
3.  Vuelve a escribir: `docker-compose up -d` (esto crea contenedores nuevos).
4.  Entra de nuevo a `http://localhost:8080`.
5.  **Pregunta:** ¿Sigue estando tu entrada del blog y tu configuración? (Debería estarlo gracias a los *volumes*).

## Paso 6: Visibilidad de tu blog al resto de compañeros
1. Documentate sobre la Configuración de Red (Acceso desde el Aula)
2. Solicita a la IA de confianza, que realice los cambios en la configuración de red de tu docker compose para que sea visible en tu red local.
3. Con el proyecto parado, modificando tan solo los parámetros de red de tu docker compose y vuelvelo arrancar.
4. Comprueba que para la IP asignada a tu equipo, puedes acceder a tu blog desde tu navegador `http://IP_asigmada:8080`