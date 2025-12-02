<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Workiom Technical Task - Sign Up Flow</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            color: #333;
        }
        h1, h2 {
            color: #0e0f12;
        }
        .container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 20px;
        }
        .section {
            margin-bottom: 30px;
        }
        .images img {
            width: 200px;
            margin: 10px;
            border-radius: 8px;
        }
        .images {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            justify-content: center;
        }
        .key-features ul {
            list-style-type: none;
            padding-left: 20px;
        }
        .key-features li {
            margin-bottom: 10px;
        }
        .key-features li:before {
            content: "✔️";
            margin-right: 10px;
        }
        .tech-stack ul {
            list-style-type: none;
            padding-left: 20px;
        }
        .tech-stack li {
            margin-bottom: 10px;
        }
        .code-block {
            background-color: #333;
            color: #fff;
            padding: 10px;
            border-radius: 5px;
            font-family: 'Courier New', Courier, monospace;
            margin: 20px 0;
            white-space: pre-wrap;
        }
        .project-structure {
            background-color: #f4f4f4;
            padding: 20px;
            border-radius: 8px;
            font-family: 'Courier New', Courier, monospace;
        }
        .setup-run {
            margin-top: 20px;
        }
        .footer {
            margin-top: 30px;
            text-align: center;
            font-size: 14px;
            color: #777;
        }
        .author {
            font-size: 16px;
            font-weight: bold;
            color: #0e0f12;
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="section">
            <h1>Workiom Technical Task - Sign Up Flow</h1>
            <p>
                تم تطوير دورة كاملة للتسجيل والدخول كجزء من اختبار تقني لـ <strong>Workiom</strong>. يوضح هذا المشروع دورة التسجيل الكاملة للمستخدم بما في ذلك التحقق من توفر المساحة، التحقق من قوة كلمة المرور، وإدارة حالة التوثيق المستمرة.
            </p>
        </div>

        <div class="section images">
            <h2>📱 Screenshots</h2>
            <p> - Splash & Check</p>
            <p> - Sign Up Form</p>
            <p> - Password Validation</p>
            <p> - Success</p>

            <img src="screenshots/splash.jpg" alt="Splash Screen" />
            <img src="screenshots/signup.jpg" alt="Sign Up Form" />
            <img src="screenshots/password.jpg" alt="Password Validation" />
            <img src="screenshots/success.jpg" alt="Success Screen" />
        </div>

        <div class="section key-features">
            <h2>🚀 Key Features</h2>
            <ul>
                <li>Complete Authentication Cycle</li>
                <li>Dynamic Edition Fetching</li>
                <li>Tenant Validation</li>
                <li>Password Strength</li>
                <li>Token Persistence</li>
                <li>Session Validation</li>
                <li>UI/UX:
                    <ul>
                        <li>Pixel-perfect implementation matching the Figma design.</li>
                        <li>Responsive design using sizer package.</li>
                        <li>Custom top-aligned Snackbar using Overlay.</li>
                    </ul>
                </li>
            </ul>
        </div>

        <div class="section tech-stack">
            <h2>🛠 Tech Stack & Architecture</h2>
            <p>يتبع هذا المشروع معمارية <strong>Feature-First</strong> مجتمعة مع مبادئ <strong>Clean Architecture</strong> لضمان القابلية للتوسع وسهولة الاختبار.</p>
            <h3>Architecture Breakdown:</h3>
            <ul>
                <li><strong>Core Layer:</strong> Contains shared utilities, constants, network clients (Dio), and routing.</li>
                <li><strong>Features (Auth):</strong>
                    <ul>
                        <li>Data Layer: AuthApiService (Dio calls) and Models.</li>
                        <li>Logic Layer: Cubit for state management (SplashCubit, PasswordCubit, TenantFormCubit).</li>
                        <li>Presentation Layer: Stateless Pages and reusable Widgets.</li>
                    </ul>
                </li>
            </ul>

            <h3>Libraries Used:</h3>
            <ul>
                <li><strong>State Management:</strong> flutter_bloc (Cubit).</li>
                <li><strong>Networking:</strong> dio (with interceptors and error handling).</li>
                <li><strong>Routing:</strong> go_router for declarative routing.</li>
                <li><strong>Storage:</strong> flutter_secure_storage for secure token persistence.</li>
                <li><strong>UI:</strong> sizer for responsive UI.</li>
            </ul>
        </div>

        <div class="section project-structure">
            <h2>📂 Project Structure</h2>
            <pre>
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
            </pre>
        </div>

        <div class="section setup-run">
            <h2>⚙️ Setup & Run</h2>
            <p>Clone the repository:</p>
            <div class="code-block">
                git clone [https://github.com/YOUR_USERNAME/workiom-task.git](https://github.com/YOUR_USERNAME/workiom-task.git)
            </div>

            <p>Install dependencies:</p>
            <div class="code-block">
                flutter pub get
            </div>

            <p>Run the app:</p>
            <div class="code-block">
                flutter run
            </div>

            <p><strong>Note for Android:</strong> Ensure your <code>minSdkVersion</code> is set to 19 or higher in <code>android/app/build.gradle</code> to support secure storage.</p>
        </div>

        <div class="footer">
            <p class="author">👨‍💻 Author: Mouayad Shwin</p>
            <p>Demonstrating proficiency in Flutter, State Management, and Clean Code practices.</p>
        </div>
    </div>

</body>
</html>
