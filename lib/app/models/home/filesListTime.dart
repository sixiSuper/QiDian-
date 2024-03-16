class FilesListTime {
  /// 是否为文件夹
  late final bool folder;

  /// 文件名称
  late final String fileName;

  /// 文件格式
  late final String fileFormat;

  /// 新名称（默认为原文件名称）
  late final String newFileName;

  /// 名称重复
  late final bool isRepeat;

  /// 不符合格式要求
  late final bool invalidFormat;

  FilesListTime({
    required this.folder,
    required this.fileName,
    required this.fileFormat,
    required this.newFileName,
    required this.isRepeat,
    required this.invalidFormat,
  });

  FilesListTime.fromJson(Map<dynamic, dynamic> json) {
    folder = json['folder'];
    fileName = json['fileName'];
    fileFormat = json['fileFormat'];
    newFileName = json['newFileName'];
    isRepeat = json['isRepeat'];
    invalidFormat = json['invalidFormat'];
  }
}
