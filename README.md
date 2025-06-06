# PokeDex iOS

A modern iOS application built with SwiftUI that allows users to browse, search, and manage their favorite Pokémon using the PokéAPI.

## 📱 Screenshots

<!-- Add your app screenshots here -->
| Home Screen | Pokemon Detail | Favorites |
|-------------|----------------|-----------|
| ![Home](screenshots/home.png) | ![Detail](screenshots/detail.png) | ![Favorites](screenshots/favorites.png) |

## ✨ Features

- 📋 **Browse Pokémon**: Infinite scroll through the complete Pokédex with grid layout
- 🔍 **Real-time Search**: Find your favorite Pokémon instantly with live search
- ❤️ **Favorites System**: Save and manage your favorite Pokémon with persistent storage
- 🗂️ **Filter Toggle**: Switch between viewing all Pokémon or favorites only
- 🗑️ **Delete Functionality**: Remove Pokémon from your collection
- 📊 **Detailed Stats**: View comprehensive Pokémon information including:
  - Height and Weight with proper unit conversion
  - Abilities with styled presentation
  - Base Stats with visual progress bars
  - Type badges with color coding
- 🎨 **Modern UI**: Clean SwiftUI interface with:
  - Dynamic type-based color theming
  - Gradient backgrounds
  - Card-based layout
  - Pull-to-refresh functionality
- 📱 **iOS Native**: Built specifically for iOS with native performance and async/await

## 🛠 Tech Stack

- **Language**: Swift 5.5+
- **Framework**: SwiftUI + Combine
- **Architecture**: MVVM with ObservableObject pattern
- **Networking**: URLSession with async/await
- **Data Persistence**: UserDefaults for favorites
- **State Management**: @Published properties with Combine bindings
- **API**: [PokéAPI v2](https://pokeapi.co/)

## 📋 Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+

## 🚀 Installation

1. Clone the repository:
```bash
git clone https://github.com/xDhii/PokeDex.git
```

2. Open the project in Xcode:
```bash
cd PokeDex
open PokeDex.xcodeproj
```

3. Build and run the project (⌘ + R)

## 🏗 Architecture

The app follows the MVVM pattern with clear separation of concerns:

### Services Layer
- **PokemonService**: Centralized service managing Pokémon data, favorites, and pagination
- **NetworkService**: Handles all API communication with PokéAPI using singleton pattern

### ViewModels Layer
- **ContentViewModel**: Manages main screen state, search, filtering, and data binding
- **DetailViewModel**: Handles detail view logic and Pokemon-specific operations

### Views Layer
- **ContentView**: Main grid view with search and filtering capabilities
- **DetailView**: Comprehensive Pokémon detail screen with stats and actions
- **PokemonCard**: Reusable card component for grid display
- **Detail Components**: Modular UI components (Header, Types, Stats, etc.)

### Models Layer
- **Pokemon**: Main Pokémon model with favorites state
- **PokemonDetail**: Detailed information model
- **DTOs**: Data Transfer Objects for API responses

### Project Structure
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

## 🔧 Configuration

The app uses PokéAPI with the following settings:
- **Page Size**: 20 Pokémon per request
- **Base URL**: https://pokeapi.co/api/v2/
- **Pagination**: Infinite scroll with offset-based loading
- **Caching**: Favorites stored locally with UserDefaults
- **Search**: Real-time filtering with case-insensitive matching

## 📊 API Integration

This app integrates with [PokéAPI v2](https://pokeapi.co/) to fetch:
- **Pokemon List**: Paginated list with offset/limit parameters
- **Pokemon Details**: Individual Pokémon information including:
  - Physical characteristics (height/weight)
  - Abilities and types
  - Base stats (HP, Attack, Defense, etc.)
  - Sprites and artwork

### Error Handling
- Network connectivity issues
- Invalid API responses
- Missing data graceful fallbacks

## 🎯 Key Features Implementation

### Infinite Scrolling
- Automatic loading when user reaches near end of list
- Loading states with progress indicators
- Efficient memory management

### Search & Filtering
- Live search with instant results
- Toggle between all Pokémon and favorites
- Persistent search state

### Favorites Management
- Toggle favorite status with heart icon
- Persistent storage across app launches
- Synchronized state between views

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 Future Enhancements

- [ ] Pokémon comparison feature
- [ ] Offline support with Core Data
- [ ] Enhanced animations and transitions
- [ ] iPad support with adaptive layouts
- [ ] Dark mode optimization
- [ ] Pokémon evolution chain display
- [ ] Advanced filtering (by type, generation, etc.)
- [ ] Pokémon team builder

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [PokéAPI](https://pokeapi.co/) for providing the comprehensive Pokémon data
- The Pokémon Company for the amazing Pokémon universe
- Apple for SwiftUI and iOS development tools

## 📞 Contact

Adriano Valumin - [@xDhii](https://github.com/xDhii)

Project Link: [https://github.com/xDhii/PokeDex](https://github.com/xDhii/PokeDx)

---

<p align="center">Made with ❤️ and SwiftUI</p>

