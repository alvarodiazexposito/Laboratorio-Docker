# 🚀 Laboratorio de Infraestructura y Servicios Contenedorizados

![Ubuntu](https://img.shields.io/badge/Ubuntu_24.04-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![Docker](https://img.shields.io/badge/Docker_Compose-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Bash](https://img.shields.io/badge/Bash_Scripting-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)

Despliegue de infraestructura ligera de servicios sobre **Ubuntu Server 24.04 LTS** utilizando **Docker Compose**, automatización de copias de seguridad con **Bash/Cron** y gestión bajo buenas prácticas de Git (Conventional Commits, Least Privilege).

---

## 🛠️ Servicios Desplegados

| Servicio | Tecnología | Puerto | Descripción |
| :--- | :--- | :--- | :--- |
| **Servidor Web** | Nginx (Alpine) | `80` | Landing page estática servida mediante volumen de solo lectura. |
| **Gestión Docker** | Portainer CE | `9000` | Interfaz gráfica para gestión y monitorización de contenedores. |
| **Observabilidad** | Uptime Kuma | `3001` | Panel de monitorización de disponibilidad y estado de servicios. |

---
## 🏗️ Arquitectura del Sistema

```mermaid
graph TD
    Client([🌐 Usuario / Navegador])

    subgraph DockerNet ["Red Docker: red-laboratorio"]
        Nginx["Servidor Web (Nginx)<br>Puerto 80"]
        Portainer["Gestor (Portainer CE)<br>Puerto 9000"]
        Kuma["Monitor (Uptime Kuma)<br>Puerto 3001"]
    end

    subgraph Host ["Host: Ubuntu Server 24.04 LTS"]
        WebFiles[("./web (HTML)")]
        PVol[("portainer_data")]
        KVol[("uptime_kuma_data")]
        Script["backup.sh (Cron 02:00 AM)"]
    end

    Client -->|HTTP :80| Nginx
    Client -->|HTTP :9000| Portainer
    Client -->|HTTP :3001| Kuma

    WebFiles -->|Volumen :ro| Nginx
    PVol --> Portainer
    KVol --> Kuma
    Script -.->|Respaldo comprimido| WebFiles
```
## ⚙️ Características Técnicas

* **Seguridad & Permisos:** Configuración de volúmenes en modo *read-only* (`:ro`) y ejecución de procesos bajo usuarios sin privilegios elevadores.
* **Automatización:** Script en Bash (`backup.sh`) para compresión de datos y rotación automática de copias de seguridad de más de 7 días.
* **Planificación:** Programación diaria a las 02:00 AM mediante el demonio `cron`.
* **Persistencia:** Volúmenes administrados por Docker para preservar datos de Portainer y Uptime Kuma.

---

## 🚀 Despliegue Rápido

```bash
# Clonar repositorio
git clone git@github.com:alvarodiazexposito/Laboratorio-Docker.git
cd Laboratorio-Docker

# Desplegar la pila de contenedores
docker compose up -d# Laboratorio-Docker
