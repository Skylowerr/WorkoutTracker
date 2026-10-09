# Security Policy

## Supported Versions

Only the latest commit on the `main` branch is actively supported with security fixes and updates.

| Version | Supported          |
| ------- | ------------------ |
| main    | :white_check_mark: |
| < 1.0   | :x:                |

---

## Reporting a Vulnerability

We appreciate responsible disclosure of security issues. If you discover a vulnerability or security-related flaw:

1. **Do not create a public GitHub issue.**
2. Send an email to the project maintainer at `gokceemirhan23@gmail.com` (or contact via GitHub profile: [@Skylowerr](https://github.com/Skylowerr)).
3. Include the following details:
   - A clear description of the potential vulnerability.
   - Exact steps or proof-of-concept payload to reproduce the behavior.
   - Potential impact on the backend API, database layer, or client application.
4. You will receive an initial response within 48 to 72 hours.
5. Once a fix is validated and released, appropriate credit will be acknowledged in the release notes unless you prefer to remain anonymous.

---

## Best Security Practices for Local Deployment
- Never commit actual production database credentials or hardcoded connection strings to version control.
- In production deployments, disable debug endpoints, enforce HTTPS (`UseHttpsRedirection`), and restrict CORS policies to trusted origins.
