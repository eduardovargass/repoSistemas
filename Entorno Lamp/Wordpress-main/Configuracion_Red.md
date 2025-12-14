# Configuración de Red (Acceso desde el Aula)
## Descripción: 
Instrucciones para que el proyecto sea visible por otros compañeros en la misma red LAN.
En el fichero docker-compose.yml que hemos usado, ya hemos incluido una configuración clave en la sección de ports:

YAML

    ports:
      - "0.0.0.0:8080:80"

## 🚀 Explicación para el aula: 
Al especificar 0.0.0.0, le estamos diciendo a Docker que no restrinja la conexión solo a "localhost" (tu propia máquina), sino que escuche peticiones desde cualquier tarjeta de red de tu ordenador.

## 🌍 Pasos para que un@ compañer@ vea tu web:

1. Averigua tu IP local. Abre una terminal (CMD o PowerShell) y escribe ipconfig (en Windows) o ip addr (en Linux/Mac).

2. Busca la dirección IPv4 de tu adaptador Wi-Fi o Ethernet (ejemplo: 192.168.1.45).

3. Dile a tu compañer@ que, en su navegador, escriba: http://192.168.1.45:8080.

## ⚠️ Solución de problemas (Firewall): 
Si tienes puesto el 0.0.0.0 y aun así tu compañer@ no puede entrar, el culpable suele ser el Firewall de Windows.

1. Solución rápida: Al arrancar Docker por primera vez, Windows suele preguntar si dar permiso en redes "Privadas" o "Públicas". Asegúrate de marcar ambas casillas.

2. Solución manual: Añadir una regla de entrada al puerto 8080 TCP en el Firewall de Windows Defender.
3. Si tuvistes que cambiar el puerto 8080 a otro puerto por estar ocupado, es importante que lo recuerdes para poder acceder desde tu navegador y que todas las referencias en la configuración de firewall, sean las del puerto realmente asignado.
