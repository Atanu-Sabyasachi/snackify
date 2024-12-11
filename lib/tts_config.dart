/// TTSConfiguration: A configuration class for managing Text-to-Speech (TTS) settings.
///
/// This class allows you to configure properties related to the TTS functionality,
/// such as whether to enable TTS, the speech rate, pitch, and language.
/// These configurations can be passed to a TTS system to customize its behavior.
class TTSConfiguration {
  /// Whether the message should be read aloud (Text-to-Speech).
  ///
  /// Set to true to enable TTS functionality when displaying a message.
  /// Default is false, meaning TTS will not be used.
  bool speakOnShow = false;

  /// Speech rate for the TTS.
  ///
  /// Controls how fast the TTS speaks the message.
  /// The default rate is 0.5 (normal speed), where values closer to 1.0 will increase the speed.
  /// A value less than 0.5 will slow down the speech.
  double? speechRate = 0.5;

  /// Pitch for the TTS.
  ///
  /// Controls the pitch of the TTS voice.
  /// The default pitch is 1.0, where higher values increase the pitch and lower values decrease it.
  double? pitch = 1.0;

  /// Language for the TTS.
  ///
  /// Defines the language in which the TTS system will speak the message.
  /// The default language is 'en-US' (English - United States),
  /// but it can be set to other language codes like 'en-GB' (English - Great Britain),
  /// 'es-ES' (Spanish - Spain), etc.
  String? language = 'en-US';

  /// Constructor for TTSConfiguration.
  ///
  /// - [speakOnShow]: Whether the message should be spoken aloud (TTS).
  /// - [speechRate]: The rate at which the TTS system speaks (optional).
  /// - [pitch]: The pitch of the TTS voice (optional).
  /// - [language]: The language of the TTS voice (optional).
  TTSConfiguration({
    required this.speakOnShow,
    this.speechRate,
    this.pitch,
    this.language,
  });
}
