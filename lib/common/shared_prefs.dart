import 'dart:async';
import 'dart:convert';

import 'package:blocks_puzzle/model/game_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlockzSharedPrefs {
  static BlockzSharedPrefs _blockzSharedPrefs;
  final String _keyHighestScore = "key_highest_score";
  final String _keyTotalStars = "key_total_stars";
  final String _keySession = "key_session";

  static BlockzSharedPrefs getInstance() {
    if (_blockzSharedPrefs == null) {
      _blockzSharedPrefs = BlockzSharedPrefs();
    }
    return _blockzSharedPrefs;
  }

  Future<int> getHighestScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyHighestScore) ?? 0;
  }

  Future<void> saveHighestScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_keyHighestScore, score);
  }

  Future<int> getTotalStars() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyTotalStars) ?? 0;
  }

  Future<void> saveTotalStars(int stars) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_keyTotalStars, stars);
  }

  Future<GameSession> getSessionStats() async {
    final prefs = await SharedPreferences.getInstance();
    String json = prefs.getString(_keySession);
    return json == null ? null : GameSession.fromJson(jsonDecode(json));
  }

  Future<void> saveSession(GameSession session) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_keySession, jsonEncode(session.toJson()).toString());
  }
}
