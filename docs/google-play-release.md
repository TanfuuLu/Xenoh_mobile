# Google Play Release Requirements

## 1. Production signing

1. Generate and back up a private Android upload keystore owned by Xenoh.
2. Copy `android/key.properties.example` to `android/key.properties` and set
   the keystore values.
3. Enrol `online.xenoh.xenoh_mobile` in Play App Signing before its first
   production upload.

The project now fails a release build when the upload-key configuration is
missing, rather than silently signing with the Android debug key.

## 2. Account deletion backend contract

Implement both endpoints before shipping the mobile UI:

```http
DELETE /api/users/me
Authorization: Bearer <access token>
```

Delete the account, revoke all access and refresh tokens, delete or anonymize
associated profile, workout, nutrition, coach-client, message, community and
subscription data, and return `204 No Content`. Retain data only where legally
required and document its retention period in the public privacy policy.

```http
POST /api/auth/account-deletion-requests
Content-Type: application/json

{ "email": "user@example.com" }
```

Always return `202 Accepted` to avoid disclosing whether an email has an
account. Send a verified email link or otherwise verify ownership before
deleting data. Deploy a public web page at
`https://xenoh.online/account-deletion` that submits this request.

## 3. Website-only subscriptions

The Flutter app no longer creates payment orders, displays VietQR details, or
calls payment endpoints. It only reads `GET /api/subscriptions/me`, so accounts
subscribed on the Xenoh website retain Pro access in mobile.

Do not add a website checkout link or payment instructions to the Play Android
app without first confirming that the relevant Google Play regional program
permits it. Keep website purchasing separate from the Play-distributed app.

## 4. Public privacy policy and Data Safety

Deploy the existing public `/privacy` route at `https://xenoh.online/privacy`.
Before submitting the form, update it with the company legal name, contact
email, effective date, processor list, data-retention schedule, account
deletion process, and a full disclosure of collected data: account details,
profile data, date of birth/gender, fitness and nutrition data, photos,
messages/community content, and subscription information.

In Play Console, declare the same data accurately in Data Safety, provide the
privacy and account-deletion URLs, complete Content Rating/App Access/Target
Audience/Ads declarations, add reviewer credentials, and run closed testing.
