<p align="center">
  <img src="docs/logo.png" width="120" alt="CarMate logo">
</p>

<h1 align="center">CarMate</h1>
<p align="center"><b>Your vehicle management companion — an iOS app built with SwiftUI & SwiftData</b></p>

<p align="center">
  <img src="https://img.shields.io/badge/Swift-5-orange?logo=swift" alt="Swift">
  <img src="https://img.shields.io/badge/SwiftUI-iOS%2017+-blue?logo=apple" alt="SwiftUI">
  <img src="https://img.shields.io/badge/SwiftData-persistence-green" alt="SwiftData">
  <img src="https://img.shields.io/badge/MapKit-CoreLocation-lightgrey" alt="MapKit">
</p>

---

CarMate helps drivers keep track of their vehicles and service history in one place. Users can register an account, add their cars, log maintenance with cost and mileage, get reminded when the next service is due, and find nearby service centers across the UAE on a map.

Built as a solo project for the Advanced Mobile Application Development course at the Higher Colleges of Technology (HCT), Abu Dhabi.

## Features

| Area | What it does |
|------|--------------|
| **Authentication** | Register and log in with input validation (required fields, minimum password length, password confirmation). A "Remember Me" option saves the username with `@AppStorage`. |
| **Vehicles** | Add, edit, and swipe-to-delete vehicles (plate, make, model, year, mileage) and turn service reminders on or off for each car. |
| **Maintenance log** | Record services (Minor, Major, Brake, Other) with date, mileage, cost in AED, and notes. Filter the log by vehicle. |
| **Reminders** | Schedules a local notification 6 months after each service, and shows banners while the app is open. |
| **Map** | Uses MapKit and CoreLocation to show the user's location and service centers in Abu Dhabi, Dubai, and Sharjah, with quick-jump buttons, traffic, and points of interest. |
| **Settings** | Garage summary, clearing pending reminders, and logout with confirmation. |

## Tech stack

- **SwiftUI**: declarative UI, `NavigationStack`, `TabView`, `Form`, alerts
- **SwiftData**: `@Model` entities (`UserAccount`, `Vehicle`, `MaintenanceRecord`) with `@Query` and `modelContext` for CRUD
- **AppStorage**: login session and remembered username
- **UserNotifications**: permission request, scheduled local reminders, foreground banners
- **MapKit + CoreLocation**: annotations, map controls, user location

## Project structure

```
CarMate1/
├── App/              # App entry point, root TabView, landing screen
├── Authentication/   # Login & registration
├── Models/           # SwiftData models
├── Vehicles/         # Vehicle list, add/edit, row UI
├── Maintenance/      # Service log, add/edit, reminders
├── Location/         # Location manager & service-center map
├── Settings/         # Account summary & logout
└── Assets.xcassets/
```

## Getting started

Requirements: macOS with **Xcode 15+**, running iOS 17 or later.

The Xcode project is generated from `project.yml` using [XcodeGen](https://github.com/yonaskolb/XcodeGen):

```bash
brew install xcodegen
git clone https://github.com/Forge-of-Ifrit/CarMate.git
cd CarMate
xcodegen generate
open CarMate1.xcodeproj
```

Then choose an iPhone simulator and press **Run** (⌘R). Register an account on first launch.

> Tip: to test the map in the Simulator, use **Features → Location** to set a custom location.

## Possible improvements

- Hash passwords and store credentials in the Keychain instead of SwiftData
- Link maintenance records to vehicles with a SwiftData relationship instead of the plate string
- Calculate service due dates from mileage as well as time
- Sync with iCloud through CloudKit

## Author

**Abdulrahman Alkatheeri**, Bachelor of IT (Applications Development) student at HCT
