class Court {
  final String id;
  final String name;
  final bool isAvailable;
  final String imageUrl; // New field for image URL

  Court({
    required this.id,
    required this.name,
    required this.isAvailable,
    required this.imageUrl, // New field for image URL
  });
}
