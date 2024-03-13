class FilesListTime {
  /// 是否为文件夹
  late final bool folder;

  /// 文件名称
  late final String fileName;

  /// 文件格式
  late final String fileFormat;

  /// 新名称（默认为原文件名称）
  late String newFileName;

  FilesListTime({
    required this.folder,
    required this.fileName,
    required this.fileFormat,
    required this.newFileName,
  });

  FilesListTime.fromJson(Map<dynamic, dynamic> json) {
    folder = json['folder'];
    fileName = json['fileName'];
    fileFormat = json['fileFormat'];
    newFileName = json['fileName'];
  }
}
