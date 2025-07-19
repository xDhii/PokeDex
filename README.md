# ✨ PokeDex iOS App ✨

[![Swift Version](https://img.shields.io/badge/Swift-6.2%2B-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/platform-iOS%2026.0%2B-lightgrey.svg)](https://developer.apple.com/ios/)
[![Xcode Version](https://img.shields.io/badge/Xcode-26.0%2B-blue.svg)](https://developer.apple.com/xcode/)
[![Architecture](https://img.shields.io/badge/Architecture-MVVM%20(ObservableObject)-blueviolet.svg)](https://developer.apple.com/documentation/swiftui/managing-model-data-in-your-app)
[![API](https://img.shields.io/badge/API-PokeAPI%20v2-red.svg)](https://pokeapi.co/)
[![UI Framework](https://img.shields.io/badge/UI-SwiftUI%20%26%20Combine-green.svg)](https://developer.apple.com/documentation/swiftui)

Welcome to the PokeDex iOS application repository! This is a modern, native iOS app built with **Swift 6.2**, **SwiftUI 6**, and **Combine**, utilizing Swift's modern concurrency features (`async/await`). The app offers a clean, responsive, and feature-rich interface for exploring the fascinating world of Pokémon. It leverages the power of the **PokeAPI v2** for comprehensive data and is architected with a strong focus on preview-driven development and modern testing practices.

---

## 🚀 Overview

This application serves as a robust digital encyclopedia for Pokémon enthusiasts. Users can seamlessly browse through a dynamically loaded, responsive grid of Pokémon, utilize real-time search, view detailed Pokémon information (including stats with visual progress bars, abilities, and dynamic type-based color theming), and manage their favorite Pokémon with persistent storage.

The project emphasizes clean code, scalability, and modern iOS development practices, structured around the MVVM architecture using `ObservableObject` and Combine for state management, with full support for SwiftUI 6 previews and modern concurrency.

## 🎨 Key Features

*   📱 **Modern UI (SwiftUI 6):** Clean, card-based layout with gradient backgrounds and dynamic type-based color theming.
*   🔍 **Browse Pokémon:** Infinite scroll with enhanced dynamic loading indicators through the complete Pokédex, featuring an improved responsive grid that adapts seamlessly to size classes.
*   ⚡ **Real-time Search:** Instantly find your favorite Pokémon with live search functionality.
*   ❤️ **Favorites System:** Save and manage your favorite Pokémon persistently using `UserDefaults`.
*   🧭 **Floating Favorites Button:** Quick filter toggle through a floating favorites button (`FavoriteFloatingButton`) for effortless access.
*   🎛️ **Generation Selector Floating Tab:** Filter Pokémon by generation with an intuitive floating tab selector (`GenerationTabSelector`), enhancing browsing control.
*   ⚖️ **Filter Toggle:** Easily switch between viewing all Pokémon or only your favorites.
*   🗑️ **Delete Functionality:** Remove Pokémon from your favorites collection.
*   🖼️ **Rich Background Styling:** Employs a sophisticated `BackgroundView` to provide rich and immersive backgrounds consistent across screens.
*   📊 **Detailed Stats View:** Comprehensive Pokémon information including:
    *   Height and Weight with proper unit conversion.
    *   Abilities with styled presentation.
    *   Base Stats with visual progress bars.
    *   Type badges with color coding.
*   🔄 **Pull-to-refresh:** Effortlessly update the Pokémon list with native pull-to-refresh support.
*   🔌 **PokeAPI Integration:** Fetches live data from the official [PokeAPI v2](https://pokeapi.co/) using Swift’s native concurrency.
*   🏗️ **MVVM Architecture:** Clean separation of concerns using the Model-View-ViewModel pattern with `ObservableObject`.
*   ⚙️ **Swift Concurrency & Combine:** Leveraging modern Swift features like `async/await` and Combine for responsive asynchronous operations and robust state management.
*   🖼️ **Asynchronous Image Loading:** Efficient and smooth loading of Pokémon images.
*   🧪 **Modern Previews:** Utilizes SwiftUI’s updated `#Preview` macro for rich, interactive previews throughout the app.

### Screenshots

| Home Screen (Grid & Search) | Pokemon Detail (Stats & Info) | Favorites Screen |
|---|---|---|
| ![image](https://github.com/user-attachments/assets/726aecf6-8c09-4d3c-b6de-a627612869f5) | ![image](https://github.com/user-attachments/assets/1a8d4e8d-7385-4e55-a20a-ea30ffd5763c) | ![image](https://github.com/user-attachments/assets/79dcb3b8-1f6d-4cc9-939c-1212b26ad856) |

*Note: Screenshots will be updated soon to reflect the latest UI enhancements and features.*

---

## 🔌 API Integration: PokeAPI

This application relies heavily on the [**PokeAPI (v2)**](https://pokeapi.co/) to fetch Pokémon data. The PokeAPI is a free and open-source RESTful API providing comprehensive data for the Pokémon universe.

*   **Base URL:** `https://pokeapi.co/api/v2/`
*   **Primary Endpoint Used:** `/pokemon` (for listing and details)
*   **Data Fetching:** The `NetworkService.swift` class handles API requests using Swift's native `URLSession` with `async/await`. It fetches lists of Pokémon using pagination (`offset` and `limit` parameters) and retrieves detailed data for individual Pokémon.
    *   Example List Fetch URL: `https://pokeapi.co/api/v2/pokemon?offset=0&limit=20`
*   **Data Parsing:** Fetched JSON data is decoded into Swift `struct` models (defined in the `Models` directory, including DTOs) using `JSONDecoder`.

For more details on the available endpoints and data structures, please refer to the [official PokeAPI v2 Documentation](https://pokeapi.co/docs/v2).

---

## 🏗️ Architecture & Project Structure

The project strictly follows the **Model-View-ViewModel (MVVM)** pattern using `ObservableObject` for state management, ensuring a clean, maintainable, and testable codebase, leveraging SwiftUI 6 and modern concurrency:

*   **Model:** (`Models/`) Defines data structures (e.g., `Pokemon`, `PokemonDetail`, DTOs) mirroring API responses and app data.
*   **View:** (`Views/`) SwiftUI views responsible for rendering UI and capturing user interactions. Views utilize declarative syntax, preview macros (`#Preview`), and are organized into feature folders and reusable `Components`.
*   **ViewModel:** (`ViewModels/`) Contains presentation logic, fetches data via Services, manages state using `@Published` properties, and handles user actions with Combine and async/await.
*   **Service:** (`Services/`) Manages external interactions, primarily network requests (`NetworkService`, `PokemonService`) and data persistence (`UserDefaults` for favorites).
*   **Utilities:** (`Utilities/`) Contains helper functions, extensions (`Color`, `String`, `View`), constants, and reusable components like `ImageLoader`. Also includes `Helpers/` and `Extensions/` folders for clear separation.
*   **Resources:** (`Resources/`) Includes assets (`Assets.xcassets`) and configuration files (`Info.plist`).


## 🧪 Tests & Quality Assurance

This project includes a suite of automated UI tests written with **XCTest** and native Xcode tools. The tests cover key user scenarios such as:

- Searching for Pokémon by name and validating search results
- Favoriting and unfavoriting Pokémon
- Filtering Pokémon by favorites using the floating favorites button
- Verifying UI elements and state changes in search and favorites workflows

### How to Run the Tests

**Via Xcode:**
1. Open the project in Xcode (26.0+)
2. Select the desired simulator or device
3. Press `Cmd + U` or go to `Product > Test`

**Via Terminal (xcodebuild):**
```sh
xcodebuild test -scheme PokeDex -destination 'platform=iOS Simulator,name=iPhone 16 Pro'
