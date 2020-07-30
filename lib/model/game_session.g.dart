// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameSession _$GameSessionFromJson(Map<String, dynamic> json) {
  return GameSession(json['score'] as int, json['starsCollected'] as int,
      json['timeInSeconds'] as int, json['timestampCreated'] as int);
}

Map<String, dynamic> _$GameSessionToJson(GameSession instance) =>
    <String, dynamic>{
      'score': instance.score,
      'starsCollected': instance.starsCollected,
      'timeInSeconds': instance.timeInSeconds,
      'timestampCreated': instance.timestampCreated
    };
