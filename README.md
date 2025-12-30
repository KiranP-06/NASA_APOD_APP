# NASA APOD Viewer

A native iOS application that fetches and displays NASA's Astronomy Picture of the Day (APOD). Built with SwiftUI, MVVM architecture, and robust error handling.

## 🚀 Features
- **Daily Content:** Fetches the latest astronomy picture and explanation using NASA's public API.
- **Smart Date Selection:** - Native `DatePicker` with validation constraints.
  - Automatically handles timezone differences to prevent 404 errors (defaults to "yesterday" if the US API hasn't updated for the current local day).
- **Detail View:** - Full-screen image viewing.
  - **Pinch-to-Zoom** capability with double-tap reset.
  - Metadata overlay (Title & Description) accessible via info button.
- **Unit Testing:** Comprehensive unit tests for the ViewModel using **Dependency Injection** and **Mocking**.

## 🛠 Tech Stack
- **Language:** Swift 5
- **UI:** SwiftUI
- **Architecture:** MVVM (Model-View-ViewModel)
- **Networking:** Swift Concurrency (Async/Await)
- **Testing:** XCTest

## 🏗 Architecture & Testing
The app uses a clean MVVM architecture to separate logic from UI.
- **Dependency Injection:** The `HomeViewModel` accepts an `APIService` via its initializer.
- **Unit Tests:** Located in the `NASA_APOD_APPTests` target. I used a `MockAPIService` to simulate network success and failure scenarios without hitting the live API, ensuring reliable and fast tests.

## 🔑 Configuration
I developed and tested the app using my personal NASA API key to ensure stability. 
However, for this submission, I have reverted the configuration to `DEMO_KEY` so you can run the project immediately without needing to set up environment variables or secret files.

## 🧪 How to Run
### Run the App
1. Open `NASA_APOD_APP.xcodeproj`.
2. Select a Simulator (e.g., iPhone 15 Pro).
3. Press `Cmd + R`.

### Run Unit Tests
1. Press `Cmd + U` to execute the test suite.
2. Verify results in the Test Navigator (Command + 6).
2. Verify results in the Test Navigator (Command + 6).
