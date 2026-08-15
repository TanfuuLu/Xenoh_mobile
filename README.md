# Xenoh Mobile

Flutter client for Xenoh.

## Social sign-in

Google and Facebook authentication uses the backend-owned OAuth flow. Run the
app with the appropriate API origin, for example:

```powershell
flutter run --dart-define=API_BASE_URL=https://10.0.2.2:7017/api
```

The backend must expose `GET /api/auth/external/{provider}?client=mobile` and
set `Authentication:MobileCallbackUrl` to
`xenoh://auth/social-callback`. Android and iOS are configured to return that
URI to GoRouter, which exchanges the one-time ticket for the normal Xenoh
session.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
