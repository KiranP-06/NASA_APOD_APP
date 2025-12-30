# NASA APOD Viewer

A native iOS application that displays NASA's Astronomy Picture of the Day (APOD). Built with SwiftUI using MVVM architecture.

## 🚀 Features
- **Daily Content:** Fetches the latest astronomy picture and explanation.
- **Timezone Handling:** Automatically defaults to "Day Before Yesterday" if NASA hasn't updated the API for the current US timezone yet (prevents 404 errors for international users).
- **Detail View:** Full-screen image viewing with **Pinch-to-Zoom** capability.
- **Metadata Overlay:** Tap the info button to read the full explanation.
- **Native UI:** Uses native DatePicker and async/await concurrency.

## 🛠 Tech Stack
- **Language:** Swift 5
- **UI:** SwiftUI
- **Architecture:** MVVM (Model-View-ViewModel)
- **Networking:** Swift Concurrency (Async/Await)

## 🔑 Configuration
The app is currently configured to use `DEMO_KEY` for easy testing. 
*Note: In a production environment, I would secure the API Key using a local `Secrets.swift` file (git-ignored) and inject it via CI/CD environment variables.*

## 🧪 How to Run
1. Open `NASA_APOD_APP.xcodeproj`
2. Select a Simulator (e.g., iPhone 15 Pro)
3. Press `Cmd + R` to run.
