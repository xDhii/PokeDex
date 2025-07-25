
# ✨ PokeDex iOS App ✨

[![Swift Version](https://img.shields.io/badge/Swift-6.2%2B-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/platform-iOS%2026.0%2B-lightgrey.svg)](https://developer.apple.com/ios/)
[![Xcode Version](https://img.shields.io/badge/Xcode-26.0%2B-blue.svg)](https://developer.apple.com/xcode/)
[![Architecture](https://img.shields.io/badge/Architecture-MVVM%20(ObservableObject)-blueviolet.svg)](https://developer.apple.com/documentation/swiftui/managing-model-data-in-your-app)
[![API](https://img.shields.io/badge/API-PokeAPI%20v2-red.svg)](https://pokeapi.co/)
[![UI Framework](https://img.shields.io/badge/UI-SwiftUI%20%26%20Combine-green.svg)](https://developer.apple.com/documentation/swiftui)

Welcome to the PokeDex iOS application repository! This is a modern, native iOS application built with SwiftUI and Combine, providing a clean, feature-rich, and intuitive interface for exploring the fascinating world of Pokémon. It leverages the power of the **PokeAPI** for comprehensive data and incorporates features like real-time search and favorites management.

---

## 🚀 Overview

This application serves as a robust digital encyclopedia for Pokémon enthusiasts. Users can seamlessly browse through a dynamically loaded grid of Pokémon, utilize real-time search, view detailed information (including stats with visual progress bars, abilities, types with dynamic color theming), and manage their favorite Pokémon with persistent storage.

The project emphasizes clean code, scalability, and modern iOS development practices, structured around the MVVM architecture using `ObservableObject` and Combine for state management.

## 🎨 Key Features

*   📱 **Modern UI (SwiftUI):** Clean, card-based layout with gradient backgrounds and dynamic type-based color theming.
*   🔍 **Browse Pokémon:** Infinite scroll through the complete Pokédex with a grid layout.
*   ⚡ **Real-time Search:** Find your favorite Pokémon instantly with live search functionality.
*   ❤️ **Favorites System:** Save and manage your favorite Pokémon with persistent storage (using `UserDefaults`).
*   ⚖️ **Filter Toggle:** Easily switch between viewing all Pokémon or only your favorites.
*   🗑️ **Delete Functionality:** Remove Pokémon from your favorites collection.
*   📊 **Detailed Stats View:** Comprehensive Pokémon information including:
    *   Height and Weight with proper unit conversion.
    *   Abilities with styled presentation.
    *   Base Stats with visual progress bars.
    *   Type badges with color coding.
*   🔄 **Pull-to-refresh:** Update the Pokémon list easily.
*   🔌 **PokeAPI Integration:** Fetches live data from the official [PokeAPI v2](https://pokeapi.co/).
*   🏗️ **MVVM Architecture:** Clean separation of concerns using the Model-View-ViewModel pattern with `ObservableObject`.
*   ⚙️ **Swift Concurrency & Combine:** Built using modern Swift features like `async/await` and the Combine framework for handling asynchronous operations and state management.
*   🖼️ **Asynchronous Image Loading:** Efficiently loads Pokémon images.
*    natively for iOS with optimal performance.

### Screenshots

| Home Screen (Grid & Search) | Pokemon Detail (Stats & Info) | Favorites Screen |
|---|---|---|
| ![image](https://github.com/user-attachments/assets/726aecf6-8c09-4d3c-b6de-a627612869f5) | ![image](https://github.com/user-attachments/assets/1a8d4e8d-7385-4e55-a20a-ea30ffd5763c) | ![image](https://github.com/user-attachments/assets/79dcb3b8-1f6d-4cc9-939c-1212b26ad856) |

---

## 🔌 API Integration: PokeAPI

This application relies heavily on the [**PokeAPI (v2)**](https://pokeapi.co/) to fetch Pokémon data. The PokeAPI is a free and open-source RESTful API providing comprehensive data for the Pokémon universe.

*   **Base URL:** `https://pokeapi.co/api/v2/`
*   **Primary Endpoint Used:** `/pokemon` (for listing and details)
*   **Data Fetching:** The `NetworkService.swift` class handles the API requests using Swift's native `URLSession` with `async/await`. It fetches lists of Pokémon using pagination (`offset` and `limit` parameters) and retrieves detailed data for individual Pokémon.
    *   Example List Fetch URL: `https://pokeapi.co/api/v2/pokemon?offset=0&limit=20`
*   **Data Parsing:** Fetched JSON data is decoded into Swift `struct` models (defined in the `Models` directory, including DTOs) using `JSONDecoder`.

For more details on the available endpoints and data structures, please refer to the [official PokeAPI v2 Documentation](https://pokeapi.co/docs/v2).

---

## 🏗️ Architecture & Project Structure

The project strictly follows the **Model-View-ViewModel (MVVM)** pattern using `ObservableObject` for state management, ensuring a clean and maintainable codebase:

*   **Model:** (`Models/`) Defines data structures (e.g., `Pokemon`, `PokemonDetail`, DTOs) mirroring API responses and app data.
*   **View:** (`Views/`) SwiftUI views responsible for rendering the UI and capturing user interactions (e.g., `ContentView`, `DetailView`, `PokemonCard`). Views are kept declarative and reactive.
*   **ViewModel:** (`ViewModels/`) Contains presentation logic, fetches data via Services, manages state using `@Published` properties, and handles user actions.
*   **Service:** (`Services/`) Manages external interactions, primarily network requests (`NetworkService`, `PokemonService`) and data persistence (`UserDefaults` for favorites).
*   **Utilities:** (`Utilities/`) Contains helper functions, extensions (`Color`, `String`, `View`), constants, and reusable components like `ImageLoader`.
*   **Resources:** (`Resources/`) Includes assets (`Assets.xcassets`) and configuration files (`Info.plist`).

```
PokeDex/
├── App/
│   └── PokeDexApp.swift
├── Services/
│   ├── PokemonService.swift
│   └── NetworkService.swift
├── ViewModels/
│   ├── ContentViewModel.swift
│   └── DetailViewModel.swift
├── Views/
│   ├── ContentView.swift
│   ├── Detail/
│   │   ├── DetailView.swift
│   │   └── Components/
│   │       ├── DetailHeaderView.swift
│   │       ├── DetailTypesView.swift
│   │       ├── DetailStatsView.swift
│   │       └── DetailAbilitiesView.swift
│   └── Components/
│       ├── PokemonCard.swift
│       ├── SearchBar.swift
│       ├── LoadingView.swift
│       └── EmptyStateView.swift
├── Models/
│   ├── Pokemon.swift
│   ├── PokemonDetail.swift
│   ├── PokemonType.swift
│   ├── PokemonStats.swift
│   ├── PokemonAbility.swift
│   └── DTOs/
│       ├── PokemonListResponse.swift
│       ├── PokemonDetailResponse.swift
│       └── PokemonBasicInfo.swift
├── Utilities/
│   ├── Extensions/
│   │   ├── Color+Extensions.swift
│   │   ├── String+Extensions.swift
│   │   └── View+Extensions.swift
│   ├── Constants.swift
│   └── Helpers/
│       ├── UnitConverter.swift
│       └── ImageLoader.swift
└── Resources/
    ├── Assets.xcassets
    └── Info.plist
```

---

## 🛠️ Tech Stack

*   **Language:** Swift 6.2+
*   **Framework:** SwiftUI + Combine
*   **Architecture:** MVVM with `ObservableObject` pattern
*   **Networking:** URLSession with `async/await`
*   **Data Persistence:** `UserDefaults` for favorites
*   **State Management:** `@Published` properties with Combine bindings
*   **API:** [PokeAPI v2](https://pokeapi.co/)

---

## 📋 Requirements

*   iOS 26.0+
*   Xcode 26.0+
*   Swift 6.2+

---

## 🚀 Installation & Setup

To set up and run the project locally, follow these steps:

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/xDhii/PokeDex.git
    ```
2.  **Navigate to the project directory:**
    ```bash
    cd PokeDex
    ```
3.  **Open the Xcode Project:**
    Double-click the `PokeDex.xcodeproj` file.
4.  **Select Target Device:**
    Choose an iOS Simulator (e.g., iPhone 16 Pro) or connect a physical iOS device running iOS 26.0+.
5.  **Build & Run:**
    Press `Cmd + R` or click the Run button in Xcode.

The application will build and launch on the selected device/simulator.

---

## 📄 License

This project is distributed under the MIT License. See the `LICENSE` file for more information. (Note: Please add a `LICENSE` file to your repository if one doesn't exist).

---

## 📧 Contact

Owner: **Adriano Valumin**

Project Link: [https://github.com/xDhii/PokeDex](https://github.com/xDhii/PokeDex)

