# Acuda Keys

Aplicación multiplataforma diseñada para agilizar y digitalizar los servicios de acuda realizados por vigilantes de seguridad. El proyecto ofrece una solución integral para la gestión de llaves, partes de servicio e informes, adaptándose a las necesidades reales del sector de la seguridad privada.

## 🛡️ ¿Qué es un servicio de Acuda?

Un servicio de acuda se produce cuando una Central Receptora de Alarmas (CRA) recibe un salto de alarma en un inmueble y envía un vigilante para realizar una verificación. AcudaKeys surge con el objetivo de mejorar y automatizar las tareas que el vigilante realiza durante este proceso, como la localización de llaves o la realización de partes.

---

## 📱 Características

- Inicio de sesión con roles diferenciados: **Administrador** y **Vigilante**
- Gestión de llaves (alta, baja, consulta)
- Generación de partes de servicio en formato PDF
- Envío de partes a la CRA correspondiente por correo electrónico
- Generación de informes mensuales con estadísticas
- Traducción automática (Español, Inglés, Chino y Japonés)
- Soporte para **modo oscuro**
- Interfaz adaptada a **Android** y **Windows**

---

## ⚙️ Tecnologías utilizadas

- **Flutter + Dart**: desarrollo de la aplicación multiplataforma
- **Firebase**: autenticación, base de datos en tiempo real y almacenamiento
- **Riverpod**: gestión de estados
- **SQLite**: configuración local persistente (idioma, tema)
- **Instaladores**: `InstallSimple` para versiones Windows

---

## 🧪 Funciones implementadas

- Inicio de sesión y persistencia de sesión
- Registro de llaves
- Creación y envío de partes
- Filtrado de clientes y partes
- Adaptación responsiva a diferentes dispositivos

---

## 🚀 Instalación

### Android

1. Descargar e instalar el archivo `.apk` proporcionado.
2. Abrir la app y autenticarse con las credenciales proporcionadas.

### Windows

1. Ejecutar el instalador `.exe` incluido.
2. Seguir los pasos del asistente para completar la instalación.

---

## 🔑 Credenciales de prueba

### Administrador

- Usuario: `admin@acudakeys.com`
- Contraseña: `password`

### Vigilante

- Usuario: `vigilante@acudakeys.com`
- Contraseña: `password`

---

## 📈 Estadísticas e informes

El sistema permite la generación de informes mensuales en PDF, con análisis como:

- Clientes con más servicios
- Motivos de servicios recurrentes
- Vigilantes más activos

---

## ✨ Propuestas de mejora futuras

- Notificación automática a CRA por saltos repetidos en el mismo sensor
- Integración con servicios de rondas mediante NFC
- Modo accesible para personas con dificultades visuales (letra grande, modo daltónico)

---

## 🔑 Licencia

Este proyecto no tiene una licencia de código abierto. Todos los derechos están reservados y no se permite la copia, modificación o distribución del código sin mi permiso explícito.
