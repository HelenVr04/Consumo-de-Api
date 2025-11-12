# Consumo seguro de API REST (NewsAPI)

## Descripción general
Proyecto de Flutter que consume la API pública de **[NewsAPI](https://newsapi.org/)** para mostrar las noticias más recientes de manera visual y atractiva.  
El proyecto implementa buenas prácticas de seguridad, manejo de errores y lectura de credenciales mediante un archivo `.env` protegido.  

---

## **Objetivo**
Consumir una API REST externa de forma **segura** y mostrar los datos en una interfaz moderna, manejando correctamente los diferentes estados de la app:  
- Cargando  
- Error  
- Sin datos  
- Éxito  

---

## **Dependencias utilizadas**

| Paquete | Descripción |
|----------|--------------|
| [`http`](https://pub.dev/packages/http) | Realiza peticiones HTTPS a la API. |
| [`flutter_dotenv`](https://pub.dev/packages/flutter_dotenv) | Maneja variables de entorno de forma segura (para la API Key). |
| [`url_launcher`](https://pub.dev/packages/url_launcher) | Abre las noticias en el navegador externo. |

---

## **Manejo de secretos**

El proyecto utiliza un archivo `.env` para almacenar la API key de **NewsAPI**, el cual **no se commitea** al repositorio por seguridad.

**Ejemplo de `.env`**
```env
NEWS_API_KEY=tu_api_key_aqui
```

**Carga en el proyecto (`main.dart`):**

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}
```

**Lectura segura en el servicio:**

```dart
final apiKey = dotenv.env['NEWS_API_KEY'];
```

---

##  **Estructura del proyecto**

```
lib/
 ┣ services/
 ┃ ┗ news_service.dart   → Lógica para consumir la API y manejar errores.
 ┣ widgets/
 ┃ ┗ news_card.dart      → Componente visual de cada noticia.
 ┣ pages/
 ┃ ┗ home_page.dart      → Pantalla principal con los estados y listado.
 ┗ main.dart             → Punto de entrada y carga del .env
```

---

##  **Características implementadas**

* Consumo seguro mediante **HTTPS**  
* Manejo de **timeouts** y **errores HTTP**  
* Estados: *cargando*, *error* y *vacío*  
* Validación visual: evita mostrar noticias sin imagen  
* Interfaz adaptativa con colores navy blue y estilo moderno  
* Uso de `flutter_dotenv` para la API Key  
* Peticiones GET con parseo JSON y control de excepciones  

---

##  **Buenas prácticas aplicadas**

* **Sanitización** de texto (evita strings vacíos o nulos en título/descripción).
* **Validación de imagen:** si la URL no es válida, usa un *placeholder*.
* **Manejo visual de errores:** muestra mensaje claro al usuario.
* **Separación lógica:** UI, servicios y componentes independientes.
* **Seguridad:** `.env` fuera del control de versiones (`.gitignore`).


##  **Cómo ejecutar el proyecto**

1. Clona el repositorio:

   ```bash
   git clone https://github.com/HelenVr04/Consumo-de-Api.git
   ```

2. Instala dependencias:

   ```bash
   flutter pub get
   ```

3. Crea el archivo `.env` en la raíz del proyecto:

   ```env
   NEWS_API_KEY=tu_api_key_aqui
   ```

4. Ejecuta la app:

   ```bash
   flutter run
   ```

---

## **Evidencias**


* Pantalla de carga
* Pantalla principal con noticias
https://github.com/user-attachments/assets/c7031b24-d290-493a-ab42-cd28795635cb

* Estado vacío
