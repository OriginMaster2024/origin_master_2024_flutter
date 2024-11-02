class HotDogException implements Exception {
  const HotDogException(this.message);

  final String message;

  @override
  String toString() => 'HotDogExeption: $message';
}
