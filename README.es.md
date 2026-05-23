# Asistente de Aprendizaje de Idiomas

Un sistema interactivo de aprendizaje de idiomas para [Claude Code](https://claude.ai/code), impulsado por IA. Importa tus propios materiales didácticos, extrae contenido de aprendizaje estructurado y sigue un plan de estudios personalizado — todo mediante conversación natural.

## Características

Dos skills independientes que trabajan juntos:

| Skill | Comando | Función |
|-------|---------|---------|
| **Procesador de Materiales** | `/process-material` | Importar materiales (PDF, Word, Excel, etc.), convertir a datos estructurados |
| **Tutor de Idiomas** | `/learn-language` | Lecciones interactivas con ejercicios, seguimiento de progreso, ritmo adaptativo |

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
1. Busca materiales procesados (o usa el currículo CEFR integrado)
2. Investiga las horas de estudio necesarias para tu nivel objetivo
3. Genera una secuencia de lecciones personalizada
4. Ejecuta lecciones interactivas con ejercicios y retroalimentación
5. Guarda el progreso automáticamente después de cada lección

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
setup.py                           # Script de instalación multiplataforma
setup.sh                           # Script de instalación Linux / Mac
setup.bat                          # Script de instalación Windows
course.json                        # Plan de estudios generado
progress.json                      # Progreso de aprendizaje
```

## Cómo Funciona

### Pipeline de Procesamiento de Materiales

```
Archivo Crudo → Detección de Formato → Conversión → División en Capítulos → Extrucción Estructurada → JSON
```

Cada tipo de extracción sigue plantillas estrictas con:
- Reglas claras sobre qué extraer
- Criterios de estimación de nivel CEFR
- Referencias cruzadas entre vocabulario, gramática y pasajes
- Listas de verificación de calidad

### Motor de Aprendizaje

```
Idioma + Nivel → Análisis Curricular → Investigación de Horas → Secuencia de Lecciones → Lecciones Interactivas
```

Los tipos de lección se alternan a lo largo de la secuencia:
- **Vocabulario**: 5-10 palabras nuevas con pronunciación, ejemplos, colocaciones
- **Gramática**: Explicación de reglas, patrones, ejemplos, errores comunes
- **Lectura**: Pasajes con preguntas de comprensión
- **Cultura**: Temas culturales, materiales auténticos, juegos de rol
- **Escritura**: Análisis de textos modelo, escritura guiada, retroalimentación estructurada

### Seguimiento de Progreso

Después de cada lección, el progreso se guarda en `progress.json`:
- Palabras aprendidas con niveles de dominio
- Puntos gramaticales cubiertos
- Áreas débiles identificadas
- Historial de sesiones

El progreso persiste entre sesiones — retoma donde lo dejaste en cualquier momento.

## Niveles CEFR

El sistema utiliza el Marco Común Europeo de Referencia para las Lenguas:

| Nivel | Vocabulario | Descripción |
|-------|-------------|-------------|
| A1 | ~500 palabras | Principiante — frases y expresiones básicas |
| A2 | ~1.000 palabras | Elemental — asuntos personales y rutinarios simples |
| B1 | ~2.500 palabras | Intermedio — puntos principales sobre temas familiares |
| B2 | ~4.000 palabras | Intermedio alto — textos complejos y temas abstractos |
| C1 | ~6.000+ palabras | Avanzado — textos exigentes, significado implícito |
| C2 | ~8.000+ palabras | Dominio — prácticamente todo lo escuchado o leído |

Las horas de estudio se estiman basándose en la investigación de Cambridge English y se ajustan según:
- Dificultad de la combinación de idiomas (idiomas relacionados son más rápidos)
- Cobertura de materiales importados (reduce horas si se usan materiales)
- Nivel actual del usuario

## Licencia

Este proyecto es para uso personal. Construido como un sistema de skills para Claude Code.
