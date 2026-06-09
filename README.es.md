# Asistente de Aprendizaje de Idiomas

Un sistema interactivo de aprendizaje de idiomas para [Claude Code](https://claude.ai/code), impulsado por IA. Importa tus propios materiales didácticos, extrae contenido de aprendizaje estructurado y sigue un plan de estudios personalizado — todo mediante conversación natural.

## Novedades en v2

| Característica | v1 | v2 |
|----------------|----|----|
| Archivos de estado | `progress.json` + `course.json` | Un solo `state.json` |
| Sistema de repaso | Ninguno | Repetición espaciada (puntuaciones de dominio, repasos automáticos) |
| Modo práctica | N/A | `/practise` — conversación libre + corrección en tiempo real |
| Lecciones de repaso | Ninguna | Cada 5.ª lección es de repaso |
| Volver al curso | Flujo de configuración completo otra vez | Continuación automática con tarjeta de progreso |
| Plantillas de lecciones | Formato rígido | Impulsadas por ejemplos, flexibles |
| Calentamiento de vocabulario | Ninguno | Repasar palabras antiguas antes de las nuevas |

## Características

Tres comandos que trabajan juntos:

| Comando | Función |
|---------|---------|
| `/process-material` | Importar materiales (PDF, Word, Excel, etc.), convertir a datos estructurados |
| `/learn-language` | Lecciones interactivas con ejercicios, repetición espaciada, ritmo adaptativo |
| `/practise` | Conversación libre en el idioma objetivo con corrección en tiempo real |

El sistema soporta **cualquier combinación de idiomas** — detecta tu idioma nativo a partir de la conversación y adapta todas las interacciones en consecuencia.

## Inicio Rápido

### 1. Instalar Dependencias

**Instalación con un clic (recomendado):**

```bash
# Linux / Mac
bash <(curl -s https://raw.githubusercontent.com/mlkgrnt/Learn-Language/main/setup.sh)

# Windows (PowerShell)
irm https://raw.githubusercontent.com/mlkgrnt/Learn-Language/main/setup.py | python
```

**O clonar e instalar manualmente:**

```bash
git clone https://github.com/mlkgrnt/Learn-Language.git
cd Learn-Language

# Elige uno:
python setup.py          # Multiplataforma (requiere Python)
bash setup.sh            # Linux / Mac
setup.bat                # Windows (doble clic o ejecutar en cmd)
```

**O solo instalar dependencias:**

```bash
pip install -r requirements.txt
```

Esto instala:

| Paquete | Propósito |
|---------|-----------|
| pymupdf + pymupdf4llm | Extracción de texto de PDF y conversión a markdown |
| chardet | Detección automática de codificación (UTF-8, GBK, Shift-JIS, etc.) |
| python-docx | Leer documentos Word (.docx) |
| openpyxl | Leer hojas de cálculo Excel (.xlsx) |
| easyocr | OCR para PDFs escaneados/solo imagen (80+ idiomas) |

### 2. Añadir Materiales (Opcional)

Coloca tus materiales de aprendizaje en `materials/input/`:

```
materials/input/
├── libro.pdf
├── vocabulario.xlsx
├── notas_gramatica.docx
└── lista_palabras.csv
```

### 3. Procesar Materiales (Opcional)

```
/process-material
```

El skill:
1. Detecta el formato del archivo y lo convierte (PDF → markdown, .docx → texto, etc.)
2. Divide en capítulos (para libros de texto)
3. Extrae vocabulario, puntos gramaticales y pasajes de lectura
4. Guarda datos estructurados en `materials/`

### 4. Empezar a Aprender

```
/learn-language
```

O salta directamente a un idioma y nivel específico:

```
/learn-language English B2
/learn-language Japanese N3
/learn-language French B1
```

El skill:
1. Busca progreso existente (`state.json`) — continúa automáticamente si lo encuentra
2. Para cursos nuevos: analiza materiales, investiga horas, genera secuencia de lecciones
3. Ejecuta lecciones interactivas con ejercicios y retroalimentación
4. Aplica repetición espaciada — vocabulario y gramática obtienen puntuaciones de dominio
5. Programa lecciones de repaso cada 5 lecciones
6. Guarda el progreso automáticamente después de cada lección

## Formatos de Archivo Soportados

| Formato | Extensión | Procesamiento |
|---------|-----------|---------------|
| PDF | .pdf | pymupdf4llm (auto), herramienta online, extracción directa u OCR |
| Word | .docx | Extracción de texto con python-docx |
| Excel | .xlsx | openpyxl, detecta automáticamente columnas de vocabulario/gramática |
| Texto | .txt | Lectura directa con detección automática de codificación |
| CSV | .csv | Analizado como banco de vocabulario/gramática |
| JSON | .json | Analizado como datos estructurados |
| Markdown | .md | Analizado en busca de patrones lingüísticos |

## Estructura del Proyecto

```
.claude/skills/
├── process-material/              # Skill Procesador de Materiales
│   ├── SKILL.md                   # Importar, convertir, extraer
│   └── templates/
│       ├── material-format.md     # Esquema JSON de salida
│       ├── extract-vocabulary.md  # Reglas de extracción de vocabulario
│       ├── extract-grammar.md     # Reglas de extracción de gramática
│       └── extract-reading.md     # Reglas de extracción de pasajes
│
└── learn-language/                # Skill Tutor de Idiomas
    ├── SKILL.md                   # Configuración, planificación, lecciones, progreso
    ├── levels.md                  # Referencia curricular CEFR A1-C2
    └── templates/
        ├── lesson-vocabulary.md   # Plantilla de lección de vocabulario
        ├── lesson-grammar.md      # Plantilla de lección de gramática
        ├── lesson-reading.md      # Plantilla de lección de lectura
        ├── lesson-culture.md      # Plantilla de lección cultural
        └── lesson-writing.md      # Plantilla de lección de escritura

materials/                         # Capa de datos compartida
├── input/                         # Materiales crudos aquí
├── chapters/                      # Archivos de capítulos convertidos (de PDFs)
│   └── index.json
├── vocabulary.json                # Vocabulario extraído
├── grammar.json                   # Puntos gramaticales extraídos
└── topics.json                    # Pasajes de lectura extraídos

requirements.txt                   # Dependencias de Python
state.json                         # Plan de estudios + progreso unificado (v2)
```

## Cómo Funciona

### Pipeline de Procesamiento de Materiales

```
Archivo Crudo → Detección de Formato → Conversión → División en Capítulos → Extracción Estructurada → JSON
```

Cada tipo de extracción sigue plantillas estrictas con reglas claras, estimación de nivel CEFR, referencias cruzadas y listas de verificación de calidad.

### Motor de Aprendizaje

```
Idioma + Nivel → Análisis Curricular → Investigación de Horas → Secuencia de Lecciones → Lecciones Interactivas
```

Los tipos de lección se alternan a lo largo de la secuencia:
- **Vocabulario**: 5-10 palabras nuevas con pronunciación, ejemplos, calentamiento con palabras anteriores
- **Gramática**: Explicación de reglas, patrones, ejemplos, errores comunes
- **Lectura**: Pasajes con preguntas de comprensión
- **Cultura**: Temas culturales, materiales auténticos, juegos de rol
- **Escritura**: Análisis de textos modelo, escritura guiada, retroalimentación estructurada
- **Repaso** (cada 5 lecciones): Repetición espaciada de vocabulario y gramática por debajo del umbral de dominio

### Repetición Espaciada

Cada palabra y punto gramatical tiene:
- **Puntuación de dominio**: Comienza en 0, aumenta con respuestas correctas, disminuye con errores
- **Fecha del próximo repaso**: Programada automáticamente según el rendimiento
- **Conteo de repasos**: Seguimiento de cuántas veces se ha repasado el elemento

Las palabras con dominio inferior al 80% se incluyen automáticamente en calentamientos y lecciones de repaso.

### Seguimiento de Progreso

Todo el estado vive en un solo `state.json`:
- Plan de estudios (total de lecciones, secuencia, posición actual)
- Vocabulario con puntuaciones de dominio y fechas de repaso
- Puntos gramaticales con puntuaciones de dominio y fechas de repaso
- Áreas débiles e historial de sesiones
- Continuación automática al volver — no necesitas reconfigurar

## Niveles CEFR

| Nivel | Vocabulario | Descripción |
|-------|-------------|-------------|
| A1 | ~500 palabras | Principiante — frases y expresiones básicas |
| A2 | ~1.000 palabras | Elemental — asuntos personales y rutinarios simples |
| B1 | ~2.500 palabras | Intermedio — puntos principales sobre temas familiares |
| B2 | ~4.000 palabras | Intermedio alto — textos complejos y temas abstractos |
| C1 | ~6.000+ palabras | Avanzado — textos exigentes, significado implícito |
| C2 | ~8.000+ palabras | Dominio — prácticamente todo lo escuchado o leído |

Las horas de estudio se estiman basándose en la investigación de Cambridge English y se ajustan según la dificultad de la combinación de idiomas, la cobertura de materiales importados y el nivel actual del usuario.

## Licencia

Este proyecto es para uso personal. Construido como un sistema de skills para Claude Code.
