import 'dart:io';
import 'package:args/args.dart';

/// Main function to parse arguments and run the appropriate action
void run(List<String> arguments) {
  final parser = ArgParser()
    ..addOption('message',
        abbr: 'm', help: 'The commit message to add emojis to.')
    ..addOption('path',
        abbr: 'p', help: 'Path to a file containing the commit message.')
    ..addFlag('generate-hook',
        abbr: 'g',
        help: 'Generate the prepare-commit-msg hook file.',
        negatable: false);

  final argResults = parser.parse(arguments);

  if (argResults['generate-hook'] as bool) {
    _generateGitHook();
  } else {
    final message = argResults['message'] as String?;
    final path = argResults['path'] as String?;

    if (message != null) {
      print(addEmojisToMessage(message));
    } else if (path != null) {
      final file = File(path);
      final lines = file.readAsLinesSync();

      for (var line in lines) {
        print(addEmojisToMessage(line));
      }
    } else {
      print('Usage: git_emoji_enhancer -m "Your commit message" or '
          'git_emoji_enhancer -p /path/to/message/file or '
          'git_emoji_enhancer -g');
    }
  }
}

/// Function to generate the prepare-commit-msg hook file
void _generateGitHook() {
  final hookContent = '''
    #!/bin/sh
    # This script modifies the commit message with emojis

    COMMIT_MSG_FILE=\$1
    COMMIT_MSG=\$(cat \$COMMIT_MSG_FILE)

    # Run emoji adder to modify the commit message
    MODIFIED_MSG=\$(dart run git_emoji_enhancer -m "\$COMMIT_MSG")

    # Write the modified message back to the commit message file
    echo "\$MODIFIED_MSG" > \$COMMIT_MSG_FILE
  ''';

  final hookFile = File('.git/hooks/prepare-commit-msg');

  // Ensure the .git/hooks directory exists
  if (!hookFile.parent.existsSync()) {
    hookFile.parent.createSync(recursive: true);
  }

  // Write the hook content to the file
  hookFile.writeAsStringSync(hookContent.trim());

  // Make the hook file executable
  Process.runSync('chmod', ['+x', hookFile.path]);

  print('prepare-commit-msg hook created and made executable.');
}

/// Function to add relevant emojis to a commit message based on keywords
String addEmojisToMessage(String message) {
  final emojiMap = {
    'feat': '✨', // New feature
    'fix': '🐛', // Bug fix
    'docs': '📝', // Documentation changes
    'style': '🎨', // Code style changes
    'refactor': '♻️', // Refactoring code
    'test': '✅', // Adding or fixing tests
    'chore': '🔧', // Maintenance and chores
    'perf': '⚡', // Performance improvements
    'build': '🏗️', // Build related changes
    'ci': '👷', // Continuous Integration
  };

  for (final entry in emojiMap.entries) {
    if (message.toLowerCase().contains(entry.key)) {
      return '${entry.value} $message';
    }
  }

  // Return original message if no keywords match
  return message;
}
