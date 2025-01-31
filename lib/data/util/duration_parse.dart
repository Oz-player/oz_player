Duration durationParse(String target) {
  List<String> parts = target.split(':');
  return Duration(
    hours: int.parse(parts[0]),
    minutes: int.parse(parts[1]),
    seconds: int.parse(parts[2].split('.')[0]),
  );
}
