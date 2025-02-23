# Flutter Project

## Description

This is a mobile application built using Flutter. The project supports both iOS and Android platforms and integrates various functionalities such as user authentication, data storage, and unit testing. The application utilizes the following technologies:

- **Firebase Authentication** (`firebase_auth`): Used for email/password-based authentication.
- **Cloud Firestore** (`cloud_firestore`): Stores user data.
- **Flutter Riverpod** (`flutter_riverpod`): Manages application state.
- **HTTP** (`http`): Makes API calls.
- **Logger** (`logger`): Logging important events like user login/signup attempts, api calls response and errors.
- **Flutter Test** & **Mockito**: Implements unit tests to cover all APIs and form validations.
- **Cached Network Image** (`cached_network_image`): Caches images for better performance.
- **Flutter Image Compress** (`flutter_image_compress`): Compresses images before saving.
- **Path Provider** (`path_provider`): Saves base64 images to Firebase and retrieves, decodes them.

## Technologies Used

- Flutter
- Firebase
- Firebase Authentication
- Cloud Firestore
- Riverpod
- HTTP
- Logger
- Flutter Test
- Mockito
- Cached Network Image
- Flutter Image Compress
- Path Provider

## Instructions for Cloning the Repository

To clone and run the project locally, follow these steps:

1. Clone the repository:
    ```bash
    git clone git clone https://github.com/prabathh/swivel-event-planner.git
    ```

2. Navigate to the project directory:
    ```bash
    cd <project_directory>
    ```

3. Install the dependencies:
    ```bash
    flutter pub get
    ```

4. Run the app on your desired platform (iOS/Android):
    ```bash
    flutter run
    ```

## Known Issues and Limitations

- **Firebase Cloud Messaging (FCM)**: The project is set up to send push notifications to all users daily at 8 AM, 12 noon, and 5 PM. However, this functionality is not available in Firebase's free plan, which limits the scheduling of push notifications.
  
  - The FirebaseMessaging initialization has been completed in `service/message_service.dart`, but the push notifications are currently commented out due to Firebase's restrictions on the free plan. 

- **Push Notification Messages**: The messages for the push notifications can be customized as needed. However, they are not yet functional due to the Firebase Cloud Messaging limitation on the free tier.

## Future Improvements

- Enable push notification scheduling using Firebase Cloud Messaging when a higher Firebase plan is used.
- Further optimization of the image compression and caching mechanism.
