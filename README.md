# Workout Tracker Full-Stack Project 🏋️‍♂️

This is a comprehensive **Object-Oriented Programming (OOP)** project developed for my university course. It is a full-stack workout management system that allows users to track exercises, manage muscle groups, and organize their fitness routines.

## 🚀 Project Overview

The project consists of two main components:
1.  **Mobile Application:** A modern iOS app built with SwiftUI.
2.  **Backend API:** A robust RESTful API built with C# and .NET.

## 🛠 Tech Stack

### Frontend (iOS App)
* **Language:** Swift
* **Framework:** SwiftUI
* **Architecture:** MVVM (Model-View-ViewModel)
* **Networking:** URLSession for REST API integration
* **UI Components:** SF Symbols, Custom Views, and Animations

### Backend (API)
* **Language:** C#
* **Framework:** .NET 8 (Minimal APIs)
* **Database:** Microsoft SQL Server (MSSQL)
* **Features:** Entity Framework Core, Repository Pattern, and Dependency Injection

## 🏗 OOP Principles Applied

This project was built with a strong focus on core OOP principles:
* **Encapsulation:** Used to hide the internal state of models and view models.
* **Abstraction:** Leveraged through interfaces in the backend to decouple database logic from endpoints.
* **Inheritance & Polymorphism:** Utilized within the database models and UI components to promote code reusability.
* **Separation of Concerns:** Clearly separated the UI, business logic, and data access layers.

## 📱 Features

* **Muscle Group Management:** Create, Read, Update, and Delete (CRUD) muscle groups.
* **Exercise Tracking:** Link exercises to specific muscle groups with detailed sets, reps, and descriptions.
* **Real-time Filtering:** Filter exercises dynamically based on selected muscle group chips.
* **Cardio Integration:** Dedicated support for cardio-based movements.
* **Unique Constraints:** UI-level and backend-level checks to prevent duplicate data.

## ⚙️ Setup & Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/Skylowerr/WorkoutTracker.git
    ```

2.  **Backend Setup:**
    * Navigate to `/Backend_API`.
    * Update the connection string in `appsettings.json` to point to your SQL Server.
    * Run `dotnet run` to start the API.

3.  **iOS Setup:**
    * Navigate to `/iOS_App`.
    * Open `WorkoutTracker.xcodeproj` in Xcode.
    * Ensure the `APIService` URL matches your backend's local address.
    * Press `Cmd + R` to run on Simulator.

---
*Developed by [Emirhan Gökce] as a University OOP Project.*
