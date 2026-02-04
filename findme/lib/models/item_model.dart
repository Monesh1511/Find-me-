class Item {
  final String id;
  final String title;
  final String description;
  final String category;
  final String type; // 'Lost' or 'Found'
  final String location;
  final String contactName;
  final String contactEmail;
  final String contactPhone;
  final String? imageUrl;
  final DateTime datePosted;
  final DateTime? dateLostOrFound;
  final String userId;

  Item({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.type,
    required this.location,
    required this.contactName,
    required this.contactEmail,
    required this.contactPhone,
    this.imageUrl,
    required this.datePosted,
    this.dateLostOrFound,
    required this.userId,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      type: json['type'] as String,
      location: json['location'] as String,
      contactName: json['contactName'] as String,
      contactEmail: json['contactEmail'] as String,
      contactPhone: json['contactPhone'] as String,
      imageUrl: json['imageUrl'] as String?,
      datePosted: DateTime.parse(json['datePosted'] as String),
      dateLostOrFound: json['dateLostOrFound'] != null
          ? DateTime.parse(json['dateLostOrFound'] as String)
          : null,
      userId: json['userId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'type': type,
      'location': location,
      'contactName': contactName,
      'contactEmail': contactEmail,
      'contactPhone': contactPhone,
      'imageUrl': imageUrl,
      'datePosted': datePosted.toIso8601String(),
      'dateLostOrFound': dateLostOrFound?.toIso8601String(),
      'userId': userId,
    };
  }

  Item copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? type,
    String? location,
    String? contactName,
    String? contactEmail,
    String? contactPhone,
    String? imageUrl,
    DateTime? datePosted,
    DateTime? dateLostOrFound,
    String? userId,
  }) {
    return Item(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      type: type ?? this.type,
      location: location ?? this.location,
      contactName: contactName ?? this.contactName,
      contactEmail: contactEmail ?? this.contactEmail,
      contactPhone: contactPhone ?? this.contactPhone,
      imageUrl: imageUrl ?? this.imageUrl,
      datePosted: datePosted ?? this.datePosted,
      dateLostOrFound: dateLostOrFound ?? this.dateLostOrFound,
      userId: userId ?? this.userId,
    );
  }
}
