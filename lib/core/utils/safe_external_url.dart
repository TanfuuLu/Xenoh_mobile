/// Parses a server-provided URL only when it is safe to hand to another app.
Uri? safeExternalUri(String value, {required Set<String> allowedHosts}) {
  final uri = Uri.tryParse(value);
  if (uri == null ||
      uri.scheme != 'https' ||
      uri.host.isEmpty ||
      !allowedHosts.contains(uri.host.toLowerCase())) {
    return null;
  }
  return uri;
}
