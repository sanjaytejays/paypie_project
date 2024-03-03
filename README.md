

##PayPie

 Overview

This project is done to show case my flutter skills. Since I have applied for a internship. Paypie has asked me to do this task.

## Requirements

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Firebase](https://firebase.google.com/docs/flutter/setup)

## Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/sanjaytejays/paypie_project.git
   ```

2. Navigate to the project directory:

   ```bash
   cd paypie_project
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Set up Firebase:
   - Follow the [Firebase setup guide](https://firebase.google.com/docs/flutter/setup) to add Firebase to your Flutter project.
   - Enable Email/Password and Phone sign-in methods in the Firebase console.


## Running the App

```bash
flutter run
```

## Features

- **Authentication:**
  - Email and password authentication.
  - Phone number authentication with OTP.

- **User Profile:**
  - Profile creation screen after successful authentication.
  - Basic user profile form with fields: name, email, and profile picture.

- **Firebase Integration:**
  - Firestore used as the database to store user profiles.

- **Navigation:**
  - Navigation between authentication screens and the profile creation screen.
  - Proper handling of back navigation.

- **UI/UX:**
  - Clean and intuitive layout.
  - Error handling and user feedback during authentication and profile creation.

## Bonus Features

- **Profile Update:**
  - Allowing users to update their profiles after the initial creation.

- **Form Validation:**
  - Validation to ensure data integrity in form fields.

- **Sign-out Functionality:**
  - Implementing user sign-out functionality.

## Contributing

If you'd like to contribute to this project, please follow the [Contributing Guidelines](CONTRIBUTING.md).

## License

This project is licensed under the [MIT License](LICENSE).
