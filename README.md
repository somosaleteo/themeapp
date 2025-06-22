# 🟣 ThemeApp

Demo educativa para ilustrar la integración de **programación reactiva**, **Clean Architecture** y **Firebase** en una app Flutter.  
Este proyecto fue construido en el marco de una charla para desarrolladores Flutter de nivel intermedio.

---

## 🚀 Características principales

- ✅ Programación reactiva usando `Stream` y `BlocGeneral`
- ✅ Arquitectura limpia basada en capas (`data`, `domain`, `ui`)
- ✅ Soporte multiplataforma (`web`, `windows`, etc.)
- ✅ Reactividad en tiempo real con `Cloud Firestore`
- ✅ Inyección de dependencias usando `InheritedWidget`
- ✅ Persistencia del tema activo en Firebase
- ✅ Soporte para entorno de pruebas con `FakeGateway`
- ✅ Manejo explícito de errores con `Either<ErrorItem, T>`

---

## 🆕 Refactorización: Clean Architecture y mejoras (rama `taller-2-refactor-complete-clean-architecture`)

En la rama `taller-2-refactor-complete-clean-architecture` se realizó una refactorización profunda del proyecto para adoptar **Clean Architecture** de manera completa. Los principales cambios y mejoras son:

- **Separación estricta de capas**: El código se organiza en `data`, `domain` y `ui`, permitiendo independencia y testabilidad.
- **Migración a Clean Architecture**: Los casos de uso (`usecases`) encapsulan la lógica de negocio, y los gateways/repositories abstraen el acceso a datos.
- **Manejo explícito de errores**: Se integra el patrón `Either<ErrorItem, T>` para un control robusto y seguro de errores en toda la lógica de dominio.
- **Mejora de tests**: Se amplía la cobertura y calidad de las pruebas, incluyendo mocks, fakes y validación de flujos reactivos.
- **Documentación y ejemplos**: El código y los tests incluyen comentarios y ejemplos para facilitar el aprendizaje.

Esta refactorización facilita la escalabilidad, el mantenimiento y la extensión del proyecto, y sirve como base para talleres avanzados de arquitectura en Flutter.

---

## 🏗 Estructura del proyecto

```bash
lib/
├── blocs/                # Blocs de negocio (ej. BlocTheme)
├── data/
│   ├── gateways/         # Implementaciones reales y fake de los gateways
│   ├── repositories/     # Implementaciones concretas de repositorios
│   ├── services/         # Servicios externos (ej. Firebase)
├── domain/
│   ├── entities/         # Modelos puros (ej. ThemeModel)
│   ├── gateways/         # Abstracciones de gateways
│   ├── repositories/     # Abstracciones de repositorios
│   ├── usecases/         # Casos de uso por acción
├── ui/
│   ├── pages/            # Pantallas de la app
│   ├── widgets/          # Widgets reutilizables
```

---

## 💻 ¿Cómo probarlo?

1. Clona el repo  
2. Ejecuta: `flutter pub get`
3. Lanza la app:
   - Para web: `flutter run -d chrome`
   - Para Windows: `flutter run -d windows`

> **Requiere configuración previa de Firebase.**
> Usa `flutterfire configure` para vincular tu proyecto.

---

## 🔧 Scripts útiles

```bash
flutterfire configure             # Vincula el proyecto a Firebase
flutter build web                 # Construye para producción web
firebase deploy                   # Despliega a Firebase Hosting
```

---

## 🧪 ¿Qué se puede mejorar?

- Profundizar en el uso de `Either<ErrorItem, T>` en toda la app
- Agregar más pruebas unitarias y de widgets
- Crear pantalla de administración para editar el tema vía sliders
- Soporte multiplataforma completo (iOS, Android, Linux)

---

# 📊 Resumen de Cobertura de Pruebas – Módulo de Temas (`theme`)

## ✅ Cobertura por Componente

| Componente                     | Tipo            | Cobertura | Descripción                                                                                 |
|--------------------------------|-----------------|-----------|---------------------------------------------------------------------------------------------|
| `ThemeModel`                   | Modelo          | ✅ 100%    | Se prueban: constructor, `toJson`, `fromMap`, `copyWith`, y simetría de serialización.      |
| `ThemeGatewayFakeImpl`         | Implementación  | ✅ 100%    | Se validan lectura, escritura y emisión en `Stream`.                                        |
| `ThemeGatewayFirebaseImpl`     | Implementación  | ✅ 100%    | Se verifica delegación correcta a `ServiceFirebaseDatabase` en lectura, escritura y stream. |
| `ThemeRepositoryImpl`          | Repositorio     | ✅ 100%    | Se prueba delegación correcta de métodos del gateway.                                       |
| `BlocTheme`                    | BLoC/Controller | ✅ 100%    | Se cubren todos los flujos: carga inicial, cambio de tema, tema aleatorio y escucha remota. |
| `Gateway`, `Repository` (base) | Abstracta       | ✅ 100%    | Se valida que pueden ser instanciadas con clases fake con constructor `const`.              |
| `ServiceFirebaseDatabase`      | Abstracta       | ✅ 100%    | Se prueba una implementación fake con constructor `const`.                                  |

## 📊 Cobertura técnica por tipos

| Tipo de elemento     | Archivos cubiertos | Total | Cobertura |
|----------------------|--------------------|-------|-----------|
| Modelos              | `ThemeModel`       | 1     | ✅ 100%    |
| Gateways             | 2 implementaciones | 2     | ✅ 100%    |
| Repositorios         | 1 implementación   | 1     | ✅ 100%    |
| BLoC / Controller    | `BlocTheme`        | 1     | ✅ 100%    |
| Abstract classes     | 3                  | 3     | ✅ 100%    |

## 📌 Notas adicionales

- Todos los mocks fueron correctamente stubbeados con `Mocktail`.
- Se resolvieron los errores de fallback con `registerFallbackValue(FakeThemeModel())`.
- Se probó la lógica condicional en `changeTheme`, incluyendo el uso de `createdAt` para decidir si guardar o no.
- Los streams (`Stream<ThemeModel>` y `Stream<ThemeData>`) fueron validados con `StreamController` o `Stream.empty`.
- Se validó el manejo de errores usando `Either` en los casos de uso y repositorios.

## ✅ Resultado final

¡Cobertura completa y validada! El módulo de tema está completamente probado a nivel de lógica de dominio y presentación sin dependencias de UI.

---

## 🎓 Talleres y videos recomendados

Antes o como complemento a esta demo, te recomendamos ver la saga de talleres y videos:

- [✅ Patrón Success-Failure en Flutter: Domina el Manejo de Errores con Elegancia 🚀](https://youtu.be/QAEbBIuwM1M)
- [✅ UseCases en Clean Architecture: Qué Son, Cómo Usarlos y Errores Comunes 🚀](https://youtu.be/QmH3BlwnLs0)
- [✅ Repository vs Gateway en Flutter: ¿Rivales o Aliados? 🚀](https://youtu.be/Uj_jw1sgVyQ)
- [🆕 Refactorización a Clean Architecture en Flutter 🚀](https://youtu.be/yuIQ8Wkcrlo)
- [🆕 Tests y buenas prácticas en Clean Architecture 🚀](https://youtu.be/Rt45oQUVE3E)

---

## 📜 Licencia

Este proyecto está bajo licencia [MIT](LICENSE).

---
**@somosaleteo** – desarrollando tecnología desde la comunidad ✨
