class TtsSettings {
  final double pitch;
  final double speechRate;
  final double volume;
  final String voice;
  const TtsSettings({
    this.pitch = 0.5,
    this.speechRate = 0.5,
    this.volume = 0.5,
    this.voice = "",
  });
  TtsSettings copyWith({
    double? pitch,
    double? speechRate,
    double? volume,
    String? voice,
  }) {
    return TtsSettings(
      pitch: pitch ?? this.pitch,
      speechRate: speechRate ?? this.speechRate,
      volume: volume ?? this.volume,
      voice: voice ?? this.voice,
    );
  }
}
