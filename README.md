# Wallet App

This iOS application displays information about a company's wallet. Using Swiftui and Clean Architecture.

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [Screenshots](#screenshots)
- [Minimum Requirements](#minimum-requirements)
- [Getting Started](#getting-started)
- [Installation](#installation)
- [Running the App](#running-the-app)
- [Running Tests](#running-tests)
- [License](#license)

## Features

- View company wallet details
- User-friendly interface
- Real-time data updates (mocked for demonstration)
- Dark mode

## Architecture

- **MVVM Architecture**: The app follows the MVVM (Model-View-ViewModel) architecture pattern.
- **Clean Architecture Patterns**: Includes use cases, data sources, and mappers for the domain and data layers.
- **State Management**: The ViewModel uses a state that includes a presentation struct to carry localizable strings for the view. A mapper transforms the state into this presentation struct for the view.
- **Modularization**: The app is organized using a modularization structure. All modules can be found in the `Packages` folder and are managed using Swift Package Manager.

<img width="191" alt="Screenshot 2024-05-28 at 00 08 50" src="https://github.com/murilloarturo/wallet_ios_app/assets/3260095/b3f58cec-3ad9-4322-8129-b2f08778e5ac">


## Screenshots

| Light Mode                          | Dark Mode                          |
| ----------------------------------- | ----------------------------------- |
| ![Home Screen](https://github.com/murilloarturo/wallet_api/assets/3260095/3279dd56-cbfe-484d-9505-3e57b7b13f7d)|![Home Screen](https://github.com/murilloarturo/wallet_api/assets/3260095/19ad3331-2670-4beb-9bac-e4f405978f9d)   |
| *Home Screen*                       | *Home Screen*                       |
| ![Home Screen](https://github.com/murilloarturo/wallet_api/assets/3260095/ca8f9192-7f2e-4e8b-baaa-6e82ad859783)|![Home Screen](https://github.com/murilloarturo/wallet_api/assets/3260095/66a0e464-cb1a-4ea3-bb4d-6be843368dff)   |
| *Home Screen Expanded*                       | *Home Screen Expanded*                       |
| ![Wallet Details](https://github.com/murilloarturo/wallet_api/assets/3260095/c76fca3d-e192-4fee-bebe-a2a4344a5f56)|![Wallet Details](https://github.com/murilloarturo/wallet_api/assets/3260095/df269979-028d-4e51-b5bc-1799a88860f6) |
| *Products Screen*                    | *Products Screen*                    |

## Minimum Requirements

- Xcode 15.2 or later
- iOS 15.0 or later

## Getting Started

Follow these instructions to set up and run the project on your local machine for development and testing purposes.

### Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/murilloarturo/wallet_ios_app.git
    ```

2. Navigate to the project directory:
    ```sh
    cd wallet-ios-app
    ```

3. Open the project in Xcode:
    ```sh
    open WalletApp.xcodeproj
    ```

### Running the App

1. Select the target device or simulator in Xcode.
2. Build and run the project by clicking the **Run** button or pressing `Cmd + R`.

## Running Tests

1. To run the tests, press `Cmd + U` in Xcode.

## Next Steps

- **Add Pull to Refresh**: Implement the ability to refresh the wallet information by pulling down on the screen.
- **Add Drawer**: Integrate a drawer component to provide easy access to additional app features.
- **Settings Option**:
  - **Obfuscate Amount of Wallets**: Add an option in settings to obfuscate the amounts displayed in the wallets.
  - **Change Dark Mode**: Allow users to toggle dark mode from within the app's settings.
  - **Change Language**: Implement language selection in the settings to support multiple languages.
- **Snapshot Testing**
