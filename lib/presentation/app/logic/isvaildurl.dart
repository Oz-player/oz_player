bool isValidUrl(String url) {
  if (url.isEmpty) return false;
  final uri = Uri.tryParse(url);
  return uri != null && uri.hasScheme && uri.host.isNotEmpty;
}
