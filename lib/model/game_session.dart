import 'package:json_annotation/json_annotation.dart';

part 'game_session.g.dart';

@JsonSerializable()
class GameSession {
  final int score;
  final int starsCollected;
  final int timeInSeconds;
  final int timestampCreated;

  GameSession(this.score, this.starsCollected, this.timeInSeconds,
      this.timestampCreated);

  factory GameSession.fromJson(Map<String, dynamic> json) =>
      _$GameSessionFromJson(json);

  Map<String, dynamic> toJson() => _$GameSessionToJson(this);
}
