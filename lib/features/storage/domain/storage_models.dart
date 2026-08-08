class StoredFile {
  const StoredFile({
    required this.id,
    required this.fileName,
    required this.contentType,
    required this.sizeBytes,
    required this.createdAt,
    this.sharedWith = const [],
  });
  factory StoredFile.fromJson(Map<String, dynamic> json) => StoredFile(
    id: json['id'].toString(),
    fileName: json['fileName']?.toString() ?? '',
    contentType: json['contentType']?.toString() ?? '',
    sizeBytes: (json['sizeBytes'] as num?)?.toInt() ?? 0,
    createdAt: DateTime.parse(json['createdAt'].toString()),
    sharedWith: (json['sharedWith'] as List<dynamic>? ?? const [])
        .map((item) => FileShare.fromJson(item as Map<String, dynamic>))
        .toList(),
  );
  final String id;
  final String fileName;
  final String contentType;
  final int sizeBytes;
  final DateTime createdAt;
  final List<FileShare> sharedWith;
}

class FileShare {
  const FileShare({
    required this.shareId,
    required this.sharedWithUserId,
    required this.sharedWithName,
  });
  factory FileShare.fromJson(Map<String, dynamic> json) => FileShare(
    shareId: json['shareId'].toString(),
    sharedWithUserId: json['sharedWithUserId'].toString(),
    sharedWithName: json['sharedWithName']?.toString() ?? '',
  );
  final String shareId;
  final String sharedWithUserId;
  final String sharedWithName;
}

class MyFiles {
  const MyFiles({
    required this.usedBytes,
    required this.quotaBytes,
    required this.maxFileSizeBytes,
    required this.files,
  });
  factory MyFiles.fromJson(Map<String, dynamic> json) => MyFiles(
    usedBytes: (json['usedBytes'] as num?)?.toInt() ?? 0,
    quotaBytes: (json['quotaBytes'] as num?)?.toInt() ?? 0,
    maxFileSizeBytes: (json['maxFileSizeBytes'] as num?)?.toInt() ?? 0,
    files: (json['files'] as List<dynamic>? ?? const [])
        .map((item) => StoredFile.fromJson(item as Map<String, dynamic>))
        .toList(),
  );
  final int usedBytes;
  final int quotaBytes;
  final int maxFileSizeBytes;
  final List<StoredFile> files;
}

class SharedFile {
  const SharedFile({
    required this.id,
    required this.fileName,
    required this.contentType,
    required this.sizeBytes,
    required this.createdAt,
    required this.ownerName,
  });
  factory SharedFile.fromJson(Map<String, dynamic> json) => SharedFile(
    id: json['id'].toString(),
    fileName: json['fileName']?.toString() ?? '',
    contentType: json['contentType']?.toString() ?? '',
    sizeBytes: (json['sizeBytes'] as num?)?.toInt() ?? 0,
    createdAt: DateTime.parse(json['createdAt'].toString()),
    ownerName: json['ownerName']?.toString() ?? '',
  );
  final String id;
  final String fileName;
  final String contentType;
  final int sizeBytes;
  final DateTime createdAt;
  final String ownerName;
}
