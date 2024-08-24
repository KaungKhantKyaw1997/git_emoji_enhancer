import 'package:git_emoji_enhancer/git_emoji_enhancer.dart';
import 'package:test/test.dart';

void main() {
  test('addEmojisToMessage adds emoji for feat', () {
    final message = 'feat: add new feature';
    final result = addEmojisToMessage(message);
    expect(result, '✨ feat: add new feature');
  });

  test('addEmojisToMessage adds emoji for fix', () {
    final message = 'fix: correct typo';
    final result = addEmojisToMessage(message);
    expect(result, '🐛 fix: correct typo');
  });

  test('addEmojisToMessage returns message unmodified if no keywords match',
      () {
    final message = 'refactor: clean code';
    final result = addEmojisToMessage(message);
    expect(result, '♻️ refactor: clean code');
  });
}
