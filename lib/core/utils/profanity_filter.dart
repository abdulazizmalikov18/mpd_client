class ProfanityFilter {
  static const List<String> _bannedWords = [
    // 🔹 English - Common Profanity / Hate / Slurs (cleaned for policy)
    'stupid', 'idiot', 'dumb', 'crazy', 'fool', 'mad', 'ugly', 'hate', 'trash',
    'kill',
    'murder',
    'die',
    'dead',
    'suicide',
    'racist',
    'nazi',
    'slave',
    'sex',
    'sexual', 'nude', 'naked', 'porn', 'xxx', 'abuse', 'abusive', 'bastard',
    'bitch', 'shit', 'fuck', 'fucked', 'fucking', 'asshole', 'dick', 'cock',
    'slut',
    'whore',
    'hoe',
    'jerk',
    'moron',
    'loser',
    'retard',
    'gay',
    'lesbian',
    'trans', 'transgender', 'suck', 'balls', 'boobs', 'tits', 'damn', 'hell',
    'fag', 'cunt', 'pussy', 'rape', 'rapist', 'molest', 'pervert', 'pedophile',
    'nigger', 'chink', 'spic', 'terrorist', 'bomb', 'explode', 'kill yourself',
    'go die', 'ugly bitch', 'fuck you', 'hate you',

    // 🔹 Abbreviations or disguised forms
    'fuk', 'fck', 'fk', 'f.u.c.k', 'sht', 'btch', 'b!tch', 'b1tch',
    'a\$\$', 'a\$\$hole', 'd1ck', 'c0ck', 'n1gga', 'f@ck', 's3x', 'xnx', 'xnxx',
  ];

  static bool hasProfanity(String text) {
    if (text.isEmpty) return false;

    final lowerText = text.toLowerCase();
    return _bannedWords.any((word) => lowerText.contains(word));
  }

  static String filterProfanity(String text) {
    if (text.isEmpty) return text;

    var filteredText = text;
    final lowerText = text.toLowerCase();

    for (final word in _bannedWords) {
      if (lowerText.contains(word)) {
        final replacement = '*' * word.length;
        filteredText = filteredText.replaceAll(
          RegExp(word, caseSensitive: false),
          replacement,
        );
      }
    }

    return filteredText;
  }
}
