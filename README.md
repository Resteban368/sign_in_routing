# Sign In Routing

Flutter project with automatic routing depending on user sign-in status.

## Features

- Fake sign-in to simulate the user sign-in status.
- GoRouter is used to manage the routing and redirections.
- If the user is not signed in, and the user opens any URL outside the ones assigned to sign-in, the user will be redirected to the sign-in URL.
- If the user is signed in, and the user opens any URL inside the ones assigned to sign-in, the user will be redirected to the home URL.

## Demo

See this project working on web at this link:

[WebApp](https://cbau.gitlab.io/sign_in_routing/)

## Screenshots

<img src="./screenshots/sign-in.png" alt="Sign in on small screens screenshot" width="240" /> <img src="./screenshots/profile.png" alt="Profile on small screens screenshot" width="240" />

## Compile

To run this project on your device, run this command:

```bash
flutter run --release
```
