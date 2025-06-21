# 📝 Task Management App (Flutter)

A simple, clean, and intuitive **Task Management App** built using **Flutter**. It allows users to sign up, log in, and manage daily tasks. The app supports profile image uploads, task persistence using `SharedPreferences`, and modern UI elements like password toggling, custom navigation drawer, and more.

---

## 🚀 Features

- 🔐 User Authentication
  - Sign up with username, email, password
  - Login with email and password
  - Password visibility toggle
  - "Forgot Password" feature to reset password locally

- 📋 Task Management
  - Add, edit, complete, and delete tasks
  - Tasks are stored persistently using `SharedPreferences`
  

- 👤 User Profile
  - View user email and profile image in the drawer

- 🧭 Navigation
  - Navigation Drawer with:
    - Profile photo and user info
    - About page
    - Logout option

- 🧪 Form Validation
  - Email and password validations
  - Rounded input fields
  - Snackbar notifications and error messages

---

## 📱 Screens

- **LoginScreen** – User login with password toggle and forgot password
- **SignupScreen** – Sign up form with rounded input, password fields
- **HomeScreen** – Task list, add button, user drawer, search
- **AddTaskScreen** – Add a new task with description
- **AboutScreen** – App info and version

---

## 📦 Packages Used

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.1
  path_provider: ^2.0.15
  image_picker: ^1.0.7
