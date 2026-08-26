import 'package:flutter/foundation.dart';
import 'package:project/app/app_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  SupabaseClient? get client => _isInitialized ? Supabase.instance.client : null;

  Future<void> initSupabase() async {
    try {
      final url = AppConfig.instance.supabaseUrl;
      final anonKey = AppConfig.instance.supabaseAnonKey;

      if (url.isNotEmpty && !url.contains('xyzcompany')) {
        await Supabase.initialize(
          url: url,
          anonKey: anonKey,
        );
        _isInitialized = true;
        if (kDebugMode) {
          print('Supabase initialized successfully with endpoint: $url');
        }
      } else {
        if (kDebugMode) {
          print('Supabase running in demo fallback mode. Add live credentials in AppConfig.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Supabase initialization error (falling back to local cache): $e');
      }
    }
  }

  // ---------------------------------------------------------------------------
  // AUTHENTICATION METHODS
  // ---------------------------------------------------------------------------
  Future<bool> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    if (!_isInitialized || client == null) return true;
    try {
      final res = await client!.auth.signUp(email: email, password: password);
      return res.user != null;
    } catch (e) {
      if (kDebugMode) print('Supabase signUp error: $e');
      return false;
    }
  }

  Future<bool> signInWithEmail({
    required String email,
    required String password,
  }) async {
    if (!_isInitialized || client == null) return true;
    try {
      final res = await client!.auth.signInWithPassword(email: email, password: password);
      return res.session != null;
    } catch (e) {
      if (kDebugMode) print('Supabase signIn error: $e');
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // PROFILE DATABASE SYNC
  // ---------------------------------------------------------------------------
  Future<Map<String, dynamic>?> fetchProfile(String userId) async {
    if (!_isInitialized || client == null) return null;
    try {
      final data = await client!.from('profiles').select().eq('id', userId).maybeSingle();
      return data;
    } catch (e) {
      if (kDebugMode) print('Supabase fetchProfile error: $e');
      return null;
    }
  }

  Future<bool> upsertProfile(Map<String, dynamic> profileData) async {
    if (!_isInitialized || client == null) return true;
    try {
      await client!.from('profiles').upsert(profileData);
      return true;
    } catch (e) {
      if (kDebugMode) print('Supabase upsertProfile error: $e');
      return false;
    }
  }

  // ---------------------------------------------------------------------------
  // EXPLORE SHOWCASE PROJECTS DATABASE SYNC
  // ---------------------------------------------------------------------------
  Future<List<Map<String, dynamic>>?> fetchExploreProjects() async {
    if (!_isInitialized || client == null) return null;
    try {
      final response = await client!.from('projects').select();
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      if (kDebugMode) print('Supabase fetchExploreProjects error: $e');
      return null;
    }
  }
}
