# EasyNews

[![Build Status](https://travis-ci.org/BrookeMa/EasyNews.svg?branch=main)](https://travis-ci.org/BrookeMa/EasyNews)
![Swift 5](https://img.shields.io/badge/Swift-5-orange)
![Platform iOS](https://img.shields.io/badge/Platform-iOS%2016.2%2B-blue)
![Architecture MVVM](https://img.shields.io/badge/Architecture-MVVM-green)

A modular iOS news reader built with **Test-Driven Development (TDD)** principles, following clean architecture patterns from [iOS Lead Essentials](https://iosleadessentials.com).

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
- [Testing](#testing)
- [Key Design Decisions](#key-design-decisions)
- [Roadmap](#roadmap)

## Features

- **Top Headlines** — Grid-based news feed via Mediastack API with image prefetching
- **Article Reader** — Full-article WKWebView with in-app browsing
- **Image Loading** — Async remote image loading with cell-level lifecycle management
- **Offline Cache** — Core Data article store with `LocalArticlesLoader` (framework-level, not yet wired to UI)
- **Localization** — English and Simplified Chinese support

## Architecture

The project is structured as a **local Swift framework** (`EasyNewsFeature`) embedded in the main app (`EasyNews`), enforcing a clean separation between the feature layer and the UI layer.

```
EasyNews (App)
├── Top Headline UI/        → UICollectionView grid + MVVM presentation
│   ├── Controllers/        → Cell controllers with prefetching
│   ├── Composers/          → Dependency injection & composition
│   ├── Presentation/       → ViewModels + localized strings (en / zh-Hans)
│   └── Views/              → Custom cells (XIB) + header view
├── WebView UI/             → WKWebView article reader
└── Shared Helpers/         → Date formatting, collection view extensions

EasyNewsFeature (Framework)
├── Article Feature/        → Domain model (Article, ArticleLoader protocol)
├── Article API/            → RemoteArticleLoader, RemoteImageDataLoader
├── Article Cache/          → Core Data store, LocalArticlesLoader, migrations
└── Shared API/             → HTTPClient protocol, URLSessionHTTPClient
```

### Data Flow

```
SceneDelegate (Composition Root)
  │
  ├─ URLSessionHTTPClient ──→ RemoteArticleLoader ──→ Mediastack API
  │                         ──→ RemoteImageDataLoader
  │
  └─ TopHeadlineUIComposer
       │
       ├─ TopHeadlineViewController (UICollectionView)
       │    ├─ TopHeadlineImageCellController
       │    └─ TopHeadlineWithoutImageViewCellController
       │
       └─ MainQueueDispatchDecorator (thread safety)
```

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Language | Swift 5 |
| UI | UIKit, Storyboard, XIB, UICollectionView |
| Networking | URLSession (custom `HTTPClient` abstraction) |
| Persistence | Core Data |
| Web Content | WebKit (WKWebView) |
| API | [Mediastack](https://mediastack.com) |
| Testing | XCTest, URLProtocol stubbing, integration & UI tests |
| Architecture | MVVM + Composition Root, protocol-oriented |
| CI | Travis CI with code coverage |

## Getting Started

### Prerequisites

- **Xcode 14.2+**
- **iOS 16.2+** simulator or device
- A [Mediastack](https://mediastack.com) API key

### Run

1. Clone the repository:

   ```bash
   git clone https://github.com/BrookeMa/EasyNews.git
   cd EasyNews
   ```

2. Open the Xcode project:

   ```bash
   open EasyNews.xcodeproj
   ```

3. Select the **EasyNews** scheme, choose a simulator, and press **⌘R** to run.

> **Note:** The project has zero third-party dependencies — no CocoaPods, SPM, or Carthage setup required.

## Testing

### Run Tests in Xcode

Select the **CI** scheme and press **⌘U**, or run from the command line:

```bash
xcodebuild clean build test \
  -project EasyNews.xcodeproj \
  -scheme "CI" \
  CODE_SIGN_IDENTITY="" \
  CODE_SIGNING_REQUIRED=NO
```

### Network Layer Test Matrix

All edge cases for the HTTP client are covered:

| Data | URLResponse | Error | State | Result |
|------|-------------|-------|-------|--------|
| nil | nil | nil | invalid | ✅ |
| nil | URLResponse | nil | invalid | ✅ |
| nil | HTTPURLResponse | nil | invalid | ✅ |
| value | nil | nil | invalid | ✅ |
| value | nil | value | invalid | ✅ |
| nil | URLResponse | value | invalid | ✅ |
| nil | HTTPURLResponse | value | invalid | ✅ |
| value | URLResponse | value | invalid | ✅ |
| value | HTTPURLResponse | value | invalid | ✅ |
| value | URLResponse | nil | invalid | ✅ |
| nil | HTTPURLResponse | nil | valid | ✅ |
| nil | nil | value | valid | ✅ |

### Test Targets

| Target | Scope |
|--------|-------|
| `EasyNewsTests` | App-layer tests (UI integration, composers) |
| `EasyNewsFeatureTests` | Framework-layer tests (HTTP client, Core Data cache, mappers) |
| `EasyNewsUITests` | End-to-end UI tests |

## Key Design Decisions

- **Protocol-based abstractions** — `HTTPClient`, `ArticleLoader`, `ArticleStore` are all protocols, enabling test doubles and composition
- **Composition Root** — All dependency wiring happens in `SceneDelegate` via `TopHeadlineUIComposer`, keeping controllers free of infrastructure concerns
- **MainQueueDispatchDecorator** — Ensures UI updates always dispatch to the main thread without polluting business logic
- **Framework separation** — `EasyNewsFeature` has zero UIKit imports, enforcing platform-agnostic domain and networking layers

## Roadmap

- [ ] Search functionality
- [ ] Settings screen
- [ ] Wire Core Data cache layer to UI composition
- [ ] Pagination support
