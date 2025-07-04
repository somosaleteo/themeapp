# Changelog

Todos los cambios notables en este proyecto serán documentados en este archivo.

El formato de este changelog está basado en [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), y el proyecto sigue [SemVer](https://semver.org/lang/es/).

## [0.8.0] - 2025-05-08

### Agregado
- Se añadió sección completa de cobertura de pruebas al `README.md`, detallando los componentes cubiertos y las herramientas utilizadas.
- Validación completa con `Mocktail` de todos los componentes del módulo de temas (`ThemeModel`, Bloc, Gateway, Repository, UseCases).
- Aclaración del uso de fallback y validación de `Stream`s.

### Resultado
- 100% de cobertura en todos los archivos clave de la arquitectura del tema.


## [0.7.0] - 2025-05-08

### Añadido
- `ProjectorWidget`: nuevo widget para escalar dinámicamente el contenido basado en dimensiones de diseño (600x800).
- Soporte de diseño responsivo para dispositivos de escritorio y móviles usando `AspectRatio` y `FittedBox`.

### Cambios
- `HomePage` ahora está contenido dentro de `ProjectorWidget`, lo que mejora la experiencia visual al presentar el `ThemeModelCardWidget`.

### Comentario
Se habilitó este comportamiento como parte del ejercicio educativo para mostrar cómo escalar interfaces sin necesidad de media queries o cálculos manuales por componente. Se espera integrar el diseño final proporcionado por la diseñadora para la siguiente versión.


## [0.6.0] - 2025-05-08
### Agregado
- Archivo `README.md` con descripción completa del proyecto, instalación, estructura, y licencias.
- Configuración de Firebase Hosting para despliegue web.
- Inclusión de licencia MIT en el proyecto.
- Estructura clara para contribuyentes, preparada para presentaciones y talleres.


## [0.5.0] - 2025-05-08

### Agregado
- Implementación del servicio `ServiceFirebaseFirestoreDatabase` para interactuar con Cloud Firestore.
- Nueva clase `ThemeGatewayFirebaseImpl` que usa Firestore como backend persistente para `ThemeModel`.
- Se actualizó la inyección de dependencias en `main.dart` para utilizar el nuevo gateway basado en Firestore.
- Se configuró la base de datos en modo público para pruebas de laboratorio hasta el 7 de junio de 2025.
- Firestore acepta ahora `ThemeModel` como documento persistente, permitiendo sincronización en tiempo real vía `snapshots()`.

### Cambiado
- Reemplazada la implementación de pruebas basada en memoria (`ThemeGatewayFakeImpl`) por el backend real en Firestore.

## [0.4.0] - 2024-07-05

### Changed
- Se refactoriza la implementación de `ThemeGatewayFirebaseImpl` para delegar toda interacción con Firebase en una nueva clase `ServiceFirebaseDatabase`
- Se crea la abstracción `ServiceFirebaseDatabase` con los métodos `write`, `read` y `onValue` para desacoplar la lógica del tipo de base de datos
- Se implementa `ServiceFirebaseRealtimeDatabase` para gestionar la comunicación con Realtime Database
- Se facilita la sustitución futura por Firestore, REST o implementaciones mockeadas

### Notes
- Esta mejora responde al principio de inversión de dependencias en Clean Architecture
- Las funciones principales de la demo no cambian; se conserva la misma estructura de datos (`theme_model/current`)

## [0.3.0] - 2024-07-05

### Added
- Integración del `BlocTheme` con los casos de uso de `save`, `load` y `listen` al `ThemeModel`
- Funcionalidad para cambiar el tema dinámicamente de forma aleatoria desde la UI
- Visualización del modelo actual de tema (`ThemeModel`) en la interfaz principal
- Inyector de dependencias implementado mediante `AppStateManager`
- Implementación del `ThemeGatewayFakeImpl` como origen emulado de datos

### Changed
- Estructura del `BlocTheme` extendida para incluir `BlocGeneral<ThemeModel>` además de `ThemeData`
- Manejo reactivo visual comprobado mediante `StreamBuilder` en el `MaterialApp`

### Notes
- Esta versión omite el manejo de errores con `Either<ErrorItem, T>` por simplicidad didáctica.
- Se planea agregar visualización mediante `Card` y conexión real con Firebase en próximas versiones.

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
