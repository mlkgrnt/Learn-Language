# Asistente de Aprendizaje de Idiomas

Un sistema interactivo de aprendizaje de idiomas para [Claude Code](https://claude.ai/code), impulsado por IA. Importa tus propios materiales didácticos, extrae contenido de aprendizaje estructurado y sigue un plan de estudios personalizado — todo mediante conversación natural.

Tres habilidades: `/process-material` (importar y extraer), `/learn-language` (aprender y practicar), y `/practise` (conversación libre). Soporta cualquier combinación de idiomas.

---

## Novedades en v2.1

- **Condiciones de activación** — guía clara sobre cuándo usar cada habilidad
- **16 ejemplos** — ejemplos detallados de entrada→salida para todos los escenarios
- **Listas de verificación de calidad** — auto-verificación después de usar cada habilidad
- **Manejo de errores** — recuperación elegante ante fallos comunes
- **Historial de versiones** — seguimiento de cambios entre versiones

### Características de v2

- **Repetición espaciada** — puntuaciones de dominio de vocabulario y programación de repaso de gramática integradas. Cada 5.ª lección es de repaso.
- **Estado unificado** — `progress.json` + `course.json` fusionados en un solo `state.json`.
- **Modo `/practise`** — conversación libre en tu idioma objetivo con corrección en tiempo real.
- **Continuación automática** — al volver a un curso, se omite la configuración y se muestra la tarjeta de progreso inmediatamente.

---

## Resumen de Habilidades

### `/process-material` — Procesador de Materiales

Importar materiales didácticos sin procesar y convertirlos en datos estructurados.

**Cuándo usar:**
- Tienes libros de texto (PDF, Word, Excel) para procesar
- Quieres extraer vocabulario, gramática o párrafos de lectura
- Estás configurando un nuevo proyecto de aprendizaje

### `/learn-language` — Tutor de Idiomas

Lecciones interactivas con repetición espaciada y seguimiento de progreso.

**Cuándo usar:**
- Quieres aprender un nuevo idioma
- Quieres continuar una sesión de aprendizaje anterior
- Quieres lecciones estructuradas de vocabulario, gramática, lectura, escritura o cultura

### `/practise` — Práctica de Conversación

Conversación libre en tu idioma objetivo con corrección en tiempo real.

**Cuándo usar:**
- Quieres practicar habla/escritura
- Quieres práctica de conversación informal
- Quieres probar tus habilidades en un entorno de baja presión

---

## Manejo de Errores

Cada habilidad maneja fallos comunes con elegancia:

- **Fallo de detección de codificación** → Retrocede a codificaciones comunes (UTF-8, GBK, Shift-JIS)
- **Fallo de conversión de PDF** → Sugiere métodos alternativos (OCR, herramientas en línea)
- **Corrupción del archivo de estado** → Se recupera automáticamente desde respaldo o comienza de nuevo
- **Materiales faltantes** → Sugiere ejecutar `/process-material` primero

---

## Inicio Rápido

**Instalación con un clic:**

```bash
# Linux / Mac
bash <(curl -s https://raw.githubusercontent.com/mlkgrnt/Learn-Language/main/setup.sh)

# Windows (PowerShell)
irm https://raw.githubusercontent.com/mlkgrnt/Learn-Language/main/setup.py | python
```

1. Coloca los materiales en `materials/input/` (PDF, Word, Excel, CSV, etc.)
2. Abre Claude Code y ejecuta `/process-material` para extraer vocabulario, gramática y párrafos
3. Ejecuta `/learn-language` para comenzar las lecciones interactivas
4. Usa `/practise` en cualquier momento para practicar conversación libre

---

## Ver También

- [Cyber-Eros.skill](https://github.com/mlkgrnt/Cyber-Eros.skill) — Sistema de roleplay inmersivo del mismo autor

---

## Licencia

MIT
