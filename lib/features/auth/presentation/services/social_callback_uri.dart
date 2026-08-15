bool isSupportedSocialCallbackUri(Uri uri) {
  if (!uri.hasScheme) {
    return uri.path == '/auth/social-callback' ||
        uri.path == '/social-callback';
  }

  return uri.scheme == 'xenoh' &&
      uri.host == 'auth' &&
      uri.path == '/social-callback' &&
      uri.userInfo.isEmpty &&
      !uri.hasPort &&
      !uri.hasFragment;
}

String? internalSocialCallbackLocation(Uri uri) {
  if (!isSupportedSocialCallbackUri(uri)) return null;

  return Uri(
    path: '/auth/social-callback',
    query: uri.hasQuery ? uri.query : null,
  ).toString();
}
