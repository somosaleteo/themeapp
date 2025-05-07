# Changelog

Todos los cambios notables en este proyecto serán documentados en este archivo.

El formato de este changelog está basado en [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), y el proyecto sigue [SemVer](https://semver.org/lang/es/).

## [0.2.0] - 2024-07-05

### ✨ Added
- Se implementa el modelo `ThemeModel` extendiendo de `Model`, con soporte para color en formato HEX y marcado como inmutable
- Se crea `BlocTheme` para gestionar el estado de `ThemeData` de forma reactiva
- Se definen las abstracciones de:
    - `ThemeGateway` para interacciones externas (por ejemplo, Firebase)
    - `ThemeRepository` como contrato del dominio
- Se agregan los casos de uso `SaveThemeUseCase`, `LoadThemeUseCase` y `ListenToThemeChangesUseCase`
- Se aclara en la charla que el manejo de errores con `Either<ErrorItem, T>` será incorporado en versiones futuras para mantener la simplicidad pedagógica de esta versión


## [0.1.0] - 2025-07-05

### ✨ Added
- Estructura inicial del proyecto basada en Clean Architecture
- Integración de `jocaagura_domain` para facilitar el modelado de entidades de negocio
- Integración de `jocaagura_archetype` para soporte de temas, navegación y responsividad
- Creación de carpetas por capas: `domain`, `data`, `blocs` y `ui`
