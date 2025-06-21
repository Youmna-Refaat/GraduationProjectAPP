# BeSafe App - A Flutter App for Personal Safety

BeSafe is a cutting-edge mobile application designed to enhance personal safety, built with Flutter and integrated with Firebase. 

The app boasts a real-time alerting system and secure communication channels, providing a reliable platform for users to stay connected and protected during emergencies.

## Features

* *Real-Time Alerts:* Instantly send and receive critical safety alerts.
* *User Authentication:* Secure login and registration using Firebase Authentication.
* *Emergency Response:* Notify predefined contacts or authorities with a single tap.
* *Location Tracking:* Share your real-time location with trusted contacts.
* *Push Notifications:* Receive immediate updates and emergency alerts.
* *Integration with Flask API:* Handle backend notifications and responses seamlessly.

## Technologies Used

* *Flutter:* For creating a beautiful and responsive UI.
* *Firebase:*
    * Authentication for secure login.
    * Firestore for real-time database and data synchronization.
    * Cloud Messaging for push notifications.
* *Flask:* Backend API for alert handling and responses.
* *Google Maps API:* For location services and tracking.

## Getting Started

*Prerequisites*

* Flutter SDK installed on your machine.
* Firebase project set up for the app (Firebase Authentication, Firestore, and Cloud Messaging configured).
* Google Maps API key.

*Steps to Run the Project*

1. Clone the repository:

```bash
git clone [https://github.com/Youmna-Refaat/GraduationProject-BeSafeAPP-.git](https://github.com/Youmna-Refaat/GraduationProject-BeSafeAPP-.git)
```
2. Navigate to the project directory:
```bash
cd GraduationProject-BeSafeAPP-
```
3. Install dependencies:
```bash
flutter pub get
```
4. Configure Firebase:
* Add the google-services.json file in the android/app directory for Android.
* Add the GoogleService-Info.plist file in the ios/Runner directory for iOS.
5. Add Google Maps API key:
* Open the android/app/src/main/AndroidManifest.xml file.
* Add your API key in the <meta-data> tag for com.google.android.geo.API_KEY.
6. Run the app:
```bash
flutter run
```

## Contributing

We welcome contributions! If you'd like to improve the app or fix bugs, please follow these steps:

1. *Fork the Repository:* Create a copy of the project on your GitHub account.
2. *Create a New Branch:* Make a new branch for your feature or bug fix.
3. *Make Changes:* Implement your changes, following the project's coding standards.
4. *Test Thoroughly:* Write unit tests to ensure the quality of your code.
5. *Create a Pull Request:* Submit your changes back to the main repository.
   
# Acknowledgements

* Firebase for its robust backend services.
* Flutter Community for providing excellent documentation and resources.
* Google Maps API for enabling precise location tracking.
  
## License

* This project is licensed under the MIT License.
  
