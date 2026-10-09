# Contributing to WorkoutTracker

Thank you for your interest in contributing to WorkoutTracker! Contributions are welcome from developers of all skill levels. Whether you want to report a bug, suggest an enhancement, or submit a pull request, please review the guidelines below.

---

## How Can You Contribute?

### 1. Reporting Bugs
- Search existing issues to ensure the bug hasn't already been reported.
- Open a new issue with a clear, descriptive title.
- Provide step-by-step reproduction steps, expected behavior, actual behavior, and environment details (macOS/iOS version, Xcode version, .NET SDK version, SQL Server configuration).
- Include screenshots, logs, or error stack traces where applicable.

### 2. Suggesting Enhancements
- Check existing issues to see if the feature has already been proposed.
- Open an issue describing the proposed feature, the problem it solves, and potential implementation approaches.

### 3. Submitting Pull Requests (PRs)
1. Fork the repository and create your branch from `main`:
   ```bash
   git checkout -b feature/your-feature-name
Follow established coding conventions:

Backend (.NET / C#): Follow Microsoft C# coding conventions, adhere to clean architecture and OOP separation, and verify with dotnet build.

Frontend (iOS / SwiftUI): Follow standard Swift API design guidelines and maintain MVVM separation (keep views declarative, delegate business/networking logic to ViewModels).

Test all CRUD endpoints via Swagger/curl and test UI flows on the iOS Simulator before opening a PR.

Commit your changes with meaningful messages:

Bash
git commit -m "feat: add muscle group deletion cascade"
Push to your branch:

Bash
git push origin feature/your-feature-name
Open a Pull Request targeting the main branch with a concise summary of the changes introduced.

Coding Standards
Clean Commits: Keep commits atomic and self-contained.

Documentation: Add inline comments where domain logic is non-trivial.

Safety First: Never commit private credentials, local connection strings with production passwords, or sensitive environment to
