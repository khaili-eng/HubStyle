class NotificationModel {
  final String id;
  final String title;
  final String body;
  final Map<String, dynamic> data;
  final String type;
  final bool isRead;
  final DateTime createdAt;
  final bool isLocal;
  final String? imageUrl;
  final String? deepLink;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    this.data = const {},
    required this.type,
    required this.isRead,
    required this.createdAt,
    this.isLocal = false,
    this.imageUrl,
    this.deepLink,
  });


  NotificationModel copyWith({
    String? id,
    String? title,
    String? body,
    Map<String, dynamic>? data,
    String? type,
    bool? isRead,
    DateTime? createdAt,
    bool? isLocal,
    String? imageUrl,
    String? deepLink,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      data: data ?? this.data,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
      isLocal: isLocal ?? this.isLocal,
      imageUrl: imageUrl ?? this.imageUrl,
      deepLink: deepLink ?? this.deepLink,
    );
  }
}