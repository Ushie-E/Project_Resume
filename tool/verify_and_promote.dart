// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

void main(List<String> args) async {
  print('======================================================');
  print('🚀 Ushie Digital Resume - Environment Promotion Gate');
  print('======================================================');

  final manifestFile = File('flavor_manifest.json');
  if (!manifestFile.existsSync()) {
    print('❌ Error: flavor_manifest.json not found.');
    exit(1);
  }

  final manifestData = jsonDecode(manifestFile.readAsStringSync()) as Map<String, dynamic>;
  final String chosenRepo = manifestData['chosen_repository']?['repository_url'] ?? '';
  print('📦 Target Repository: $chosenRepo');
  print('⚙️  Flavors Configured: dev, staging, production\n');

  // Step 1: Run flutter analyze
  print('🔍 Step 1: Running Static Code Analysis (flutter analyze)...');
  final analyzeResult = await Process.run('flutter', ['analyze'], runInShell: true);
  if (analyzeResult.exitCode != 0) {
    print('❌ Static analysis failed:\n${analyzeResult.stdout}');
    manifestData['quality_gate']['flutter_analyze_passed'] = false;
    manifestData['quality_gate']['development_verified'] = false;
    manifestFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(manifestData));
    exit(1);
  }
  print('✅ Code analysis passed: 0 issues found.');

  // Step 2: Run Unit Tests
  print('\n🧪 Step 2: Running Unit Tests (flutter test)...');
  final testResult = await Process.run(
    'flutter',
    ['test', 'test/viewmodels'],
    runInShell: true,
  );
  if (testResult.exitCode != 0) {
    print('❌ Unit tests failed:\n${testResult.stdout}');
    manifestData['quality_gate']['unit_tests_passed'] = false;
    manifestData['quality_gate']['development_verified'] = false;
    manifestFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(manifestData));
    exit(1);
  }
  print('✅ All Unit tests passed.');

  // Step 3: Update Manifest JSON
  final nowIso = DateTime.now().toUtc().toIso8601String();
  manifestData['quality_gate']['flutter_analyze_passed'] = true;
  manifestData['quality_gate']['unit_tests_passed'] = true;
  manifestData['quality_gate']['development_verified'] = true;
  manifestData['quality_gate']['last_verification_timestamp'] = nowIso;
  manifestData['current_release']['updated_at'] = nowIso;
  manifestFile.writeAsStringSync(const JsonEncoder.withIndent('  ').convert(manifestData));

  print('\n======================================================');
  print('🎉 DEVELOPMENT IS 100% OKAY AND VERIFIED!');
  print('📝 flavor_manifest.json updated with verification timestamp.');
  print('======================================================');
  print('\nNext Step Guide to Promote:');
  print('1️⃣  DEV -> STAGING:');
  print('   git checkout -b staging || git checkout staging');
  print('   git merge main (or your dev branch)');
  print('   git push origin staging');
  print('\n2️⃣  STAGING -> PRODUCTION:');
  print('   git checkout main');
  print('   git merge staging');
  print('   git push origin main');
  print('======================================================');
}
