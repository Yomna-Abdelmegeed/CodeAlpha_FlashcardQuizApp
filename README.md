
<h1 align="center">
  <img src="assets/images/logo.png" alt="Flasho Demo" width="90" style="vertical-align: middle;" />
  Flasho
</h1>

<p align="center">
  <strong>Your smart way to study.</strong>
</p>

<p align="center">
  Create, organize, and review your flashcards with a simple, focused, and fully offline learning experience.
</p>


<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-5B7553?style=flat-square&logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-%5E3.12.2-3F5639?style=flat-square&logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/State%20Management-Cubit-D6A85F?style=flat-square" />
  <img src="https://img.shields.io/badge/Storage-SharedPreferences-3F5639?style=flat-square" />
   <img src="https://img.shields.io/badge/Backend-None-C96B5B?style=flat-square" />
</p>


---
<p align="center">
  <img src="assets/images/flasho_demo.gif" alt="Flasho Demo" width="650"/>
</p>

## 📖 Overview

**Flasho** is a Flutter flashcard study application built as a clean MVP. It lets users create their own study decks, fill them with flashcards, and review them in a distraction-free study mode — with **Show/Hide Answer** and **Previous/Next** navigation.

There is no backend, no authentication, and no cloud sync. Everything the user creates — decks and flashcards — is **cached locally on the device** using `SharedPreferences`, so the app works fully offline and data persists between sessions.

The project is built to demonstrate practical, real-world Flutter skills: feature-based architecture, MVVM-style separation, the repository pattern, Cubit state management, and clean local data caching — without over-engineering a simple app.

---

## ✨ Features

| | |
|---|---|
| 🗂️ Create & delete decks | Users define their own decks — no fixed categories |
| 📝 Add / edit / delete flashcards | Full CRUD on each deck's content |
| 🎓 Study Mode | One card at a time, with a progress indicator |
| 👁️ Show / Hide Answer | Reveal the answer only when ready |
| ⬅️➡️ Previous / Next | Move freely through the deck while studying |
| 💾 Local caching | Decks and flashcards persist automatically, offline |
| ⚠️ Confirmations | Delete actions require confirmation |
| 🫙 Empty states | Clear guidance when a deck or flashcard list is empty |

---
## 🎨 Design

Flasho follows a warm, minimal visual style designed to create a calm and focused study experience.

The interface combines natural green tones with warm neutral backgrounds, soft borders, rounded cards, and subtle visual elements to maintain a clean and comfortable learning environment.

### 🎨 Brand Colors

| Color | Hex |
|---|---|
| Primary | `#5B7553` |
| Primary Dark | `#3F5639` |
| Accent | `#D6A85F` |
| Background | `#F7F4EC` |
| Surface | `#FFFDF8` |
| Text | `#263127` |
| Error | `#C96B5B` |
| Success | `#6B9B68` |

The design focuses on **clarity, consistency, and simplicity**, keeping the interface visually light so users can focus on studying.

## 🏗️ Architecture

Feature-based architecture inspired by Clean Architecture and MVVM, kept intentionally simple.

```
features/
├── home/
│   ├── data/{models, repo}/
│   └── presentation/{view_model, views}/
├── deck_details/
│   ├── data/{models, repo}/
│   └── presentation/{view_model, views}/
└── study/
    ├── data/{models, repo}/
    └── presentation/{view_model, views}/
```

**Flow of responsibility:**

```
View  →  Cubit (ViewModel)  →  Repository  →  Repository Impl  →  SharedPrefService  →  SharedPreferences
```

- **View** — renders UI, forwards user actions.
- **Cubit** — manages screen state, calls the repository, exposes loading/success/error states.
- **Repository** — a clean interface between presentation and storage.
- **Repository Implementation** — performs the actual caching logic (JSON encode/decode + read/write).

---

## 💾 Local Caching

Flasho relies entirely on **on-device caching** instead of a remote backend. All persistence goes through a single reusable `SharedPrefService`, with keys centralized in `SharedPrefKeys` (no scattered string literals).

Since `SharedPreferences` only stores primitives, decks are serialized to JSON before being cached:

```
DeckModel → toJson() → jsonEncode() → SharedPreferences (String) → jsonDecode() → DeckModel.fromJson()
```

This keeps caching predictable and centralized, and keeps the UI completely unaware of how or where data is stored.

---

## 🧩 Data Models

**`DeckModel`** — `id`, `title`, `flashcardsCount`, `icon`
**`FlashcardModel`** — `id`, `question`, `answer`

Both support `toJson()` / `fromJson()` and are kept separate from the UI, so widgets never touch serialization directly.

---



## 🛠️ Tech Stack

| Technology | Purpose |
| :--- | :--- |
| **Flutter** | Cross-platform application development |
| **Dart** `^3.12.2` | Programming language |
| **Material 3** | UI foundation |
| **Cubit** | State management |
| **SharedPreferences** | Local persistence |
| **JSON** | Model serialization |
| **GoRouter** | Navigation |
| **GetIt** | Dependency injection |
| **Gap** | UI spacing |

---

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK**
- **Dart SDK** (`^3.12.2`)

Make sure your Flutter environment is properly configured:

```bash
flutter doctor
```

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Yomna-Abdelmegeed/CodeAlpha_FlashcardQuizApp.git
   ```

2. **Navigate to the project directory:**
   ```bash
   cd CodeAlpha_FlashcardQuizApp
   ```

3. **Install the dependencies:**
   ```bash
   flutter pub get
   ```

4. **Run the application:**
   ```bash
   flutter run
   ```

---

## 📂 Project Structure

```
lib/
├── core/
│   ├── di/
│   ├── routes/
│   ├── services/       # SharedPrefService
│   └── widgets/
├── features/
│   ├── home/
│   ├── deck_details/
│   └── study/
└── main.dart
```

---

## 🧠 Architecture & Design Decisions

| Decision | Rationale |
|---|---|
| **Local-First Storage** | Keeps the MVP fully offline while providing practical experience with persistent local data without introducing backend complexity. |
| **User-Created Decks** | Allows users to organize flashcards around any subject without relying on predefined or hardcoded categories. |
| **SharedPreferences** | Provides a lightweight and appropriate storage solution for the app's simple persistence requirements. |
| **JSON Serialization** | Converts structured `DeckModel` and `FlashcardModel` objects into JSON strings, making them compatible with `SharedPreferences`. |
| **Repository Pattern** | Separates data access from presentation logic, keeping the codebase maintainable and making future storage changes easier. |
| **Cubit State Management** | Provides simple and predictable state management while avoiding unnecessary complexity for the MVP. |
| **Feature-Based Architecture** | Organizes the application by feature, keeping related models, repositories, state management, and UI components together for better scalability. |
| **MVVM-Inspired Separation** | Separates UI responsibilities from state and data-handling logic, resulting in cleaner and more testable code. |
| **Centralized Storage Keys** | Keeps `SharedPrefKeys` in one place to avoid scattered string literals and reduce the risk of storage-key inconsistencies. |

---
## 👩‍💻 Author

<div align="center">

### **Yomna Abdelmegeed**
*Flutter & Cross-Platform Application Developer*

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/yomna-abdelmegeed-91759026a/)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Yomna-Abdelmegeed)

</div>