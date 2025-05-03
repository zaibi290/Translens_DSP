# Translens - Mobile Text Translator App

Translens is a Flutter-based mobile application that allows users to translate text using voice input, camera (OCR), or manual text entry. It supports text-to-speech, speech-to-text, dictionary lookup, and saving favourite translations. All tools and APIs used are free and open-source.

## Features

- Extract text from images using Google ML Kit OCR
- Translate spoken input using speech-to-text
- Translate text using the Google Translate API via the `translator` package
- Listen to translations using text-to-speech
- Save favourite translations
- Onboarding screens and splash screen included
- Clean dark-themed UI

## Prerequisites

- A computer with internet access
- Android Studio installed (with Flutter and Dart plugins)
- Flutter SDK installed and added to system path
- A physical Android device or emulator
- USB debugging enabled on the device (if using a physical device)

## Installation Steps

1. **Clone the repository**
   git clone https://github.com/zaibi290/Translens-DSP-.git

Or download the ZIP and extract it manually.

2. **Open the project in Android Studio**
- Open Android Studio
- Click "Open an existing project"
- Select the `translens` folder

3. **Install Flutter and Dart plugins (if not already installed)**
- Go to Preferences > Plugins > Marketplace
- Search for Flutter and install it (Dart installs automatically)

4. **Get dependencies**
   flutter pub get

## APK Installation (Recommended)

The easiest way to run the app with camera and voice features is to install the APK directly.

APK Location:
build/app/outputs/flutter-apk/app-release.apk


- Copy the APK file to your Android device
- Enable “Install unknown apps” in the phone settings (app will be in files on the phone)
- Tap the APK file to install Translens

## License

This project is for educational purposes. All APIs, packages, and tools used were free and open-source.

## GitHub Repository

https://github.com/zaibi290/Translens_DSP
