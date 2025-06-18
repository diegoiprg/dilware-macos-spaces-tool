# dilware-myself-macos-tool-mission-control-spaces-mission-control-spaces

![Banner del proyecto](https://img.shields.io/badge/Hammerspoon%20Space%20Manager-%F0%9F%8C%90%20macOS%20automation-blueviolet?style=for-the-badge)

![Versión](https://img.shields.io/badge/version-1.0.0-green.svg)

Sistema personalizado para macOS que permite gestionar espacios virtuales (Spaces) con perfiles de uso como "personal" y "work", usando Hammerspoon.

Incluye:

- Creación de espacios por perfil
- Lanzamiento automático de aplicaciones
- Eliminación de espacios y cierre de apps
- Icono en la barra de menú para acceso rápido
- Notificaciones del sistema y logs detallados

---

## 📁 Estructura del repositorio

```
.
├── init.lua                # Script principal para Hammerspoon
├── README.md              # Instrucciones de instalación y uso
└── .hammerspoon/
    └── debug.log          # Archivo de log generado por el script
```

---

## 🚀 Instalación paso a paso

### 1. Instalar Hammerspoon

Descarga e instala desde: [https://www.hammerspoon.org](https://www.hammerspoon.org)

### 2. Configurar permisos en macOS

Ir a `Preferencias del Sistema > Seguridad y privacidad > Privacidad`, y otorgar a Hammerspoon:

- Acceso total al disco
- Accesibilidad
- Automatización (para controlar otras apps)

### 3. Clonar el repositorio

```bash
git clone https://github.com/diegoiprg/dilware-myself-macos-tool-mission-control-spaces.git
cp dilware-myself-macos-tool-mission-control-spaces/init.lua ~/.hammerspoon/init.lua
```

### 4. Ejecutar Hammerspoon

1. Abre la app Hammerspoon.
2. Presiona `Command + R` para recargar el script.
3. Aparecerá el icono “Spaces 🧭” en la barra de menú.

### Alternativa: Instalación automática

También puedes usar el script `install.sh` incluido para automatizar la instalación:

```bash
curl -sL https://raw.githubusercontent.com/diegoiprg/dilware-myself-macos-tool-mission-control-spaces/main/install.sh | bash
```

Si prefieres descargar el archivo manualmente:

1. Asegúrate de que el archivo `install.sh` esté en la raíz del proyecto.
2. Hazlo ejecutable con el siguiente comando:

   ```bash
   chmod +x install.sh
   ```

3. Luego ejecútalo:

   ```bash
   ./install.sh
   ```

---

## 🖱 Opciones disponibles en la barra de menú

- `🟢 Activar Perfil Personal`: Crea espacio y abre Safari
- `🟢 Activar Perfil Work`: Crea espacio y abre Outlook, Teams y Chrome
- `❌ Cerrar Perfil ...`: Cierra las apps y elimina el espacio
- `📝 Ver Log`: Abre los eventos en TextEdit
- `🔄 Recargar`: Recarga el script
- `❌ Salir`: Finaliza Hammerspoon

---

## ✏️ Personalización

Edita el archivo `init.lua` para:

- Cambiar las apps de cada perfil (`profiles` table)
- Agregar nuevos perfiles siguiendo la estructura

Ejemplo para agregar un perfil `estudio`:

```lua
estudio = {
  name = "Estudio",
  apps = { "Xcode", "Simulator" },
  space_id = nil,
}
```

---

## 🐞 Depuración

Verifica el archivo `~/.hammerspoon/debug.log` para revisar eventos, errores o advertencias generadas por el sistema.

---

## 🌍 Sobre el proyecto

Este script fue creado con el objetivo de mejorar la experiencia de uso en macOS, ofreciendo una forma práctica y automatizada de gestionar espacios personalizados (Spaces) según distintos perfiles de usuario.  
Es una herramienta pensada para usuarios que buscan optimizar su flujo de trabajo sin depender de aplicaciones comerciales.

Aunque parte del código fue generado con ayuda de IA, el desarrollo, pruebas y publicación fueron realizados por el autor de forma supervisada y consciente, con el deseo de aportar una solución útil y gratuita a la comunidad.

---

## 📄 Licencia

Este proyecto está licenciado bajo la **GNU General Public License v3.0**.

Puedes usarlo, estudiarlo, modificarlo y compartirlo libremente, siempre que:

- No sea utilizado con fines comerciales.
- Se mantenga la misma licencia para cualquier derivado.
- Se incluya atribución al autor original.

Esto asegura que el proyecto siga siendo software libre y accesible para todos.

---

## 🏷️ Características clave

![Libre y sin fines comerciales](https://img.shields.io/badge/uso-no%20comercial-blue.svg)
![Sin seguimiento ni anuncios](https://img.shields.io/badge/sin%20tracking%20ni%20ads-✅-brightgreen.svg)
![Hecho para macOS](https://img.shields.io/badge/plataforma-macOS-lightgrey.svg)
![Licencia GPLv3](https://img.shields.io/badge/licencia-GPLv3-important.svg)

## 🤖 Nota sobre la autoría

Este proyecto fue desarrollado con la asistencia de herramientas de inteligencia artificial para generar código, bajo la supervisión directa del autor.  
Todo el código ha sido revisado, probado y aprobado antes de su publicación.

La licencia GNU GPLv3 aplica íntegramente a todo el contenido de este repositorio.
