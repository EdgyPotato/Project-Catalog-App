# Product Catalog

## Overview

This project is a simple project catalog application that retrieves product data from the DummyJSON Products API, built under a time constraint (around 3 hours++).

Users can browse a paginated product list, search for products, load additional results while scrolling, and open a detail screen to view product information and images.

## Stack Used

- Flutter
- Dart
- `http`

## How to Run

```bash
git clone https://github.com/EdgyPotato/Project-Catalog-App
cd Project-Catalog-App
flutter pub get
flutter run
```

Make sure Flutter is installed and a supported device or emulator is available. Tested on both Android and Web platforms.

## Project Structure

```text
lib/
├── main.dart
├── data/
│   ├── product.dart
│   └── product_api.dart
└── ui/
    ├── product_list_page.dart
    └── product_detail_page.dart
```

The project uses a simple two layer structure.

`data/` contains the product model, JSON parsing, and HTTP requests to DummyJSON.

`ui/` contains the product list and detail screens, UI state, and user interactions.

## Features

### Required

- [x] Product list with title, thumbnail, and price
- [x] Infinite scroll pagination
- [x] Product detail screen
- [x] Product description, price, rating, and images
- [x] Loading state
- [x] Error state with Retry
- [x] Empty state
- [x] Debounced search
- [x] Search pagination
- [x] Two-layer project organization

### Bonus

- [x] Product model unit test
- [ ] Pull-to-refresh
- [ ] Image loading/error fallback

## Testing

The application was tested manually for:

- Initial product loading
- Infinite-ish scroll pagination
- Product search
- Empty search results
- Clearing the search query
- Product detail navigation
- Detail loading
- Error and Retry behavior

Technical checks:

```bash
flutter analyze
flutter test
```

## Known Limitations / TODOs

Refer to [TODO.md](TODO.md) for a list of known limitations and unimplemented features.

## AI Disclosure

AI was only used on workflow planning, research, Flutter/Dart concept explanations, identifying relevant official documentation, code review, and debugging guidance.

## References Used

- DummyJSON Products API  
  https://dummyjson.com/docs/products

- Flutter networking  
  https://docs.flutter.dev/cookbook/networking/fetch-data

- Flutter `ListView.builder`  
  https://api.flutter.dev/flutter/widgets/ListView/ListView.builder.html

- Flutter `ScrollController`  
  https://api.flutter.dev/flutter/widgets/ScrollController-class.html

- Flutter `TextField`  
  https://api.flutter.dev/flutter/material/TextField-class.html

- Dart `Timer`  
  https://api.dart.dev/dart-async/Timer-class.html

- Flutter navigation  
  https://docs.flutter.dev/ui/navigation

- Flutter `Image.network`  
  https://api.flutter.dev/flutter/widgets/Image/Image.network.html

- Flutter testing  
  https://docs.flutter.dev/testing/overview
