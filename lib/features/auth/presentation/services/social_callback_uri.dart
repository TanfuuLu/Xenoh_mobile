bool isSupportedSocialCallbackUri(Uri uri) {
  if (!uri.hasScheme) {
    final supportedPath =
        uri.path == '/auth/social-callback' || uri.path == '/social-callback';
    return supportedPath && !uri.hasAuthority && !uri.hasFragment;
  }

  return uri.scheme == 'xenoh' &&
      uri.host == 'auth' &&
      uri.path == '/social-callback' &&
      uri.userInfo.isEmpty &&
      !uri.hasPort &&
      (!uri.hasFragment || uri.fragment == '_=_');
}

String? internalSocialCallbackLocation(Uri uri) {
  if (!isSupportedSocialCallbackUri(uri)) return null;

  return Uri(
    path: '/auth/social-callback',
    query: uri.hasQuery ? uri.query : null,
  ).toString();
}
