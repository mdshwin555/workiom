🚀 Workiom Technical Task - Sign Up Flow

A fully functional Sign-Up and Authentication flow developed as a technical assessment for Workiom. This project demonstrates a complete user registration cycle including checking tenant availability, password validation, and persistent authentication state management using Clean Architecture.

📱 App Preview

Splash & Check

Sign Up Form

Password Validation

Success

<img src="screenshots/splash.png" width="180"/>

<img src="screenshots/signup.png" width="180"/>

<img src="screenshots/password.png" width="180"/>

<img src="screenshots/success.png" width="180"/>

Note: These screenshots demonstrate the flow from session check to successful registration.

✨ Key Features

🔐 Authentication & Security

Dynamic Edition Fetching: Automatically fetches the first valid registrable edition ID from the server (no hardcoded IDs).

Tenant Validation: Real-time check for workspace/tenant name availability via API.

Password Strength: Robust validation rules fetched directly from server configurations.

Token Persistence: Securely saves the authentication token using flutter_secure_storage.

Session Management: Smart Splash screen that verifies user session on app start.

🎨 UI/UX Design

Pixel-Perfect Implementation: Matches the Figma design 100%.

Responsive Layout: Utilizes the sizer package for adaptivity across screen sizes.

Custom Overlay: Top-aligned custom Snackbar for success/error messages.

🛠 Tech Stack

This project follows the Feature-First architecture combined with Clean Architecture principles.

Category

Libraries / Tools

State Management

flutter_bloc (Cubit)

Networking

dio (Interceptors & Error Handling)

Routing

go_router (Declarative Routing)

Storage

flutter_secure_storage

UI Responsiveness

sizer

📂 Project Structure

Matches the exact structure implemented in the repository:

lib/
├── core/
│   ├── constants/
│   │   ├── api_routes.dart
│   │   ├── app_colors.dart
│   │   ├── app_images.dart
│   │   └── custom_snack_bar.dart
│   ├── network/
│   │   └── dio_client.dart
│   └── router/
│       └── app_router.dart
├── features/
│   └── auth/
│       ├── data/
│       │   ├── models/
│       │   │   └── password_complexity_model.dart
│       │   └── services/
│       │       └── auth_api_service.dart
│       ├── logic/
│       │   ├── password_cubit/
│       │   ├── splash_cubit/
│       │   └── tenant_form_cubit/
│       └── presentation/
│           ├── pages/
│           │   ├── create_account_page.dart
│           │   ├── enter_company_page.dart
│           │   ├── enter_password_page.dart
│           │   ├── splash_page.dart
│           │   └── success_page.dart
│           └── widgets/
└── main.dart


⚙️ Setup & Installation

Clone the repository:

git clone [https://github.com/mdshwin555/workiom.git](https://github.com/mdshwin555/workiom.git)


Install dependencies:

flutter pub get


Run the app:

flutter run


⚠️ Android Note: Ensure your minSdkVersion is set to 19 or higher in android/app/build.gradle to support secure storage.

👨‍💻 Author

Mouayad Shwin

Demonstrating proficiency in Flutter, State Management (Bloc), and Clean Code practices.
