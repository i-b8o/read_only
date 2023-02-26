class AppSettings {
  final bool darkModeOn;
  final double speechRate;
  final double pitch;
  final double volume;
  final int fontWeight;
  final double fontSize;
  final String voice;
  List<String>? voices;
  AppSettings(
      {required this.darkModeOn,
      required this.speechRate,
      required this.pitch,
      required this.volume,
      required this.fontWeight,
      required this.fontSize,
      required this.voice,
      this.voices});

  AppSettings copyWith(
      {bool? darkModeOn,
      double? speechRate,
      double? pitch,
      double? volume,
      int? fontWeight,
      double? fontSize,
      String? voice,
      List<String>? voices}) {
    return AppSettings(
      darkModeOn: darkModeOn ?? this.darkModeOn,
      speechRate: speechRate ?? this.speechRate,
      pitch: pitch ?? this.pitch,
      volume: volume ?? this.volume,
      fontWeight: fontWeight ?? this.fontWeight,
      fontSize: fontSize ?? this.fontSize,
      voice: voice ?? this.voice,
      voices: voices ?? this.voices,
    );
  }
}
