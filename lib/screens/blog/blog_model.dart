class BlogItem {
  final String image;
  final String title;
  final String subtitle;
  final String time;
  final String paragraph;

  BlogItem({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.paragraph,
  });

  // Factory constructor to create BlogItem from JSON
  factory BlogItem.fromJson(Map<String, dynamic> json) {
    return BlogItem(
      image: json['images'][0], // Use the first image in the list
      title: json['title'],
      subtitle: json['title'], // Mapping subtitle to title (or use description for subtitle)
      time: "1 min", // You can modify the time logic as needed
      paragraph: json['description'],
    );
  }
}
