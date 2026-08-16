# Xenoh Mobile

Flutter client for Xenoh.

## Social sign-in

Google and Facebook authentication uses the backend-owned OAuth flow. Run the
app with the appropriate API origin. For provider sign-in on an emulator or
device, use the production API or a provider-registered HTTPS development
tunnel:

```powershell
flutter run --dart-define=API_BASE_URL=https://api.xenoh.online/api
```

`https://10.0.2.2:7017/api` remains the debug default for normal local API
development, but it is not suitable for provider OAuth: Google does not accept
the emulator's raw host IP as a web redirect origin, and the external browser
does not use Flutter's development certificate override. Release builds safely
default to `https://api.xenoh.online/api` if `API_BASE_URL` is omitted.

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
