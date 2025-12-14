# 🌐 Caso de uso
# 🛠️ EJEMPLO DE USO PRÁCTICO: Web Full Stack (CI/CD Simulado)
## Caso de Uso: 
### Despliegue de una Nueva Característica y Llamada al Backend
* Objetivo: 
Modificar el frontend (puerto 8080) y simular que hace una llamada a un recurso que sería servido por nuestro backend (puerto 3000), probando la interconexión.
### Requisitos Previos
* Tener Docker Desktop instalado y en funcionamiento.
* Estar en la carpeta raíz del proyecto (mi-emv-web-ci-cd).

## Pasos para la realizar la actividad en el aula

1. Levantar el Entorno	
    * Inicia los servicios de frontend (Nginx) y backend (Node.js).	

```bash
    docker compose up -d
 ```
2. Verificar Endpoints	
    * Comprueba que ambos servicios estén accesibles.	

     ** Navegador: http://localhost:8080 (Frontend) **
     ** Navegador: http://localhost:3000 (Backend) **

3. Modificación del Backend (Simulación de API)
El servicio de backend usará Node.js para servir datos en formato JSON, imitando una API.

    1. Modificar backend/server.js: Reemplaza el contenido del archivo backend/server.js para que responda con datos estructurados y establezca las cabeceras de Content-Type:

```JavaScript

// backend/server.js
const http = require('http');
const port = 3000;

const requestHandler = (request, response) => {
  // 1. Establecer el tipo de contenido como JSON
  response.setHeader('Content-Type', 'application/json');

  // 2. Establecer cabeceras para permitir llamadas desde el frontend (CORS)
  response.setHeader('Access-Control-Allow-Origin', '*'); 

  // 3. Devolver un objeto JSON
  response.end(JSON.stringify({ 
      status: 'ok', 
      message: '¡Datos recibidos desde el Backend!',
      timestamp: new Date().toISOString()
  }));
};

const server = http.createServer(requestHandler);

server.listen(port, (err) => {
  if (err) {
    return console.log('Algo salió mal', err);
  }
  console.log(`Servidor Node.js escuchando en el puerto ${port}`);
});
```
   2. Reiniciar el Contenedor de Backend: Como hemos cambiado código de Node.js que no soporta hot-reload automáticamente, debemos reiniciar el servicio para aplicar los cambios:

```Bash
docker compose restart backend
```

   3. Verificación del Backend: 
   Abre http://localhost:3000 en tu navegador. Ahora debería mostrar un JSON formateado.

3. Modificación del Frontend (Consumo de la API)
El servicio de frontend (Nginx) está montado a la carpeta frontend/. Cualquier cambio en index.html se reflejará inmediatamente al recargar el navegador.

* Modificar frontend/index.html: Añade el siguiente bloque de JavaScript al final del <body> del archivo frontend/index.html. Este código llama a nuestro backend en http://localhost:3000.

```HTML

<hr>
<h2>Estado de la Integración (API)</h2>
<p id="api-status">Cargando datos del backend...</p>

<script>
  // Llama al servicio 'backend' a través del puerto expuesto 3000
  fetch('http://localhost:3000')
    .then(response => response.json())
    .then(data => {
      const statusElement = document.getElementById('api-status');
      statusElement.innerHTML = `Mensaje: <strong>${data.message}</strong> (${data.timestamp})`;
      statusElement.style.color = 'green';
    })
    .catch(error => {
      console.error('Error al conectar con el backend:', error);
      document.getElementById('api-status').textContent = 'Error al conectar con la API del Backend.';
      document.getElementById('api-status').style.color = 'red';
    });
</script>
```

4. Prueba Final (Integración de Servicios)
   1. Recargar Frontend: Vuelve a http://localhost:8080 y recarga la página.

   2. Resultado Esperado: La página debe mostrar los datos del mensaje de Backend (ej: Mensaje: ¡Datos recibidos desde el Backend!).

Este proceso simula un flujo real: desarrollas el backend, lo despliegas (simulado con el reinicio), desarrollas el frontend y verificas la integración de ambos servicios interconectados dentro de la red Docker.

5. 🧹 Detener y Limpiar
Para detener y eliminar los contenedores (las imágenes base permanecerán):

```bash
docker compose down
```
