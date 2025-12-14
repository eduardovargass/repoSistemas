
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