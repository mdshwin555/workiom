Workiom Technical Task - Sign Up Flow

A fully functional Sign-Up and Authentication flow developed as a technical assessment for Workiom. This project demonstrates a complete user registration cycle including checking tenant availability, password validation, and persistent authentication state management.

📱 Screenshots

Splash & Check

Sign Up Form

Password Validation

Success

<img src="screenshots/splash.jpg" width="200"/>

<img src="screenshots/signup.jpg" width="200"/>

<img src="screenshots/password.jpg" width="200"/>

<img src="screenshots/success.jpg" width="200"/>

🚀 Key Features

Complete Authentication Cycle:

Dynamic Edition Fetching: Fetches the first registrable edition ID from the server dynamically (no hardcoded IDs).

Tenant Validation: Checks if the workspace/tenant name is available in real-time.

Password Strength: robust password validation based on server configurations.

Token Persistence: Saves the authentication token securely using flutter_secure_storage.

Session Validation: Verifies the user session on app start via the Splash screen.

UI/UX:

Pixel-perfect implementation matching the Figma design.

Responsive design using sizer package.

Custom top-aligned Snackbar using Overlay.

🛠 Tech Stack & Architecture

This project follows the Feature-First architecture combined with Clean Architecture principles to ensure scalability and testability.

Architecture Breakdown:

Core: Contains shared utilities, constants, network clients (Dio), and routing.

Features (Auth):

Data Layer: AuthApiService (Dio calls) and Models.

Logic Layer: Cubit for state management (SplashCubit, PasswordCubit, TenantFormCubit).

Presentation Layer: Stateless Pages and reusable Widgets.

Libraries Used:

State Management: flutter_bloc (Cubit).

Networking: dio (with interceptors and error handling).

Routing: go_router for declarative routing.

Storage: flutter_secure_storage for secure token persistence.

UI: sizer for responsive UI.

📂 Project Structure

lib/
├── core/
│   ├── constants/       # API routes, Colors, Images
│   ├── network/         # Dio Client setup
│   └── routes/          # App Router configuration
└── features/
    └── auth/
        ├── data/
        │   ├── models/  # Data models
        │   └── services/# API Service classes
        ├── logic/       # Cubits (State Management)
        └── presentation/
            ├── pages/   # Application Screens
            └── widgets/ # Reusable UI Components


⚙️ Setup & Run

Clone the repository:

git clone [https://github.com/YOUR_USERNAME/workiom-task.git](https://github.com/YOUR_USERNAME/workiom-task.git)


Install dependencies:

flutter pub get


Run the app:

flutter run


Note for Android: Ensure your minSdkVersion is set to 19 or higher in android/app/build.gradle to support secure storage.

👨‍💻 Author

Mouayad Shwin

Demonstrating proficiency in Flutter, State Management, and Clean Code practices.
