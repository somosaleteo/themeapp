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

---

## 🏗 Estructura del proyecto

```bash
lib/
├── blocs/                # Blocs de negocio (ej. BlocTheme)
├── data/
│   ├── gateways/         # Implementaciones reales y fake de los gateways
│   ├── services/         # Servicios externos (ej. Firebase)
├── domain/
│   ├── entities/         # Modelos puros (ej. ThemeModel)
│   ├── repositories/     # Abstracciones de acceso a datos
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

- Integrar `Either<ErrorItem, T>` para control explícito de errores
- Agregar pruebas unitarias y de widgets
- Crear pantalla de administración para editar el tema vía sliders
- Soporte multiplataforma completo (iOS, Android, Linux)


---

## 🎓 Talleres recomendados

Antes o como complemento a esta demo, te recomendamos ver los siguientes talleres:

- [✅ Patrón Success-Failure en Flutter: Domina el Manejo de Errores con Elegancia 🚀](https://youtu.be/QAEbBIuwM1M)
- [✅ UseCases en Clean Architecture: Qué Son, Cómo Usarlos y Errores Comunes 🚀](https://youtu.be/QmH3BlwnLs0)
- [✅ Repository vs Gateway en Flutter: ¿Rivales o Aliados? 🚀](https://youtu.be/Uj_jw1sgVyQ)

---

## 📜 Licencia

Este proyecto está bajo licencia [MIT](LICENSE).

---
**@somosaleteo** – desarrollando tecnología desde la comunidad ✨
