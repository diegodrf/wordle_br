class WordleBRBrain {
  static WordleBRBrain? _instance;

  final List<String> _words = ['', '', '', '', '', ''];
  final List<List<dynamic>> _wordAttemptsResult = [];
  int _wordAttemptIndex = 0;
  final Map<int, Set<String>> letterStatus = {0: {}, 1: {}, 2: {}};

  static WordleBRBrain getInstance() {
    _instance ??= WordleBRBrain();
    return _instance!;
  }

  void addLetter(int wordIndex, String letter) {
    if (_words[wordIndex].length < 5) {
      _words[wordIndex] += letter;
    }
  }

  void removeLastLetter(int wordIndex) {
    String _originalWord = _words[wordIndex];
    try {
      String _newWord = _originalWord.substring(0, _originalWord.length - 1);
      _words[wordIndex] = _newWord;
    } on RangeError {
      _words[wordIndex] = '';
    }
  }

  String getWord(int wordIndex) {
    return _words[wordIndex];
  }

  List<String> getAllWordAttempts() {
    return _words;
  }

  void incrementAttemptIndex() {
    if (getWord(getWordAttemptIndex()).length == 5 &&
        getWordAttemptIndex() < 6) {
      ++_wordAttemptIndex;
    }
  }

  int getWordAttemptIndex() {
    return _wordAttemptIndex;
  }

  void updateResult(List<dynamic> result) {
    _wordAttemptsResult.add(result);
    _setColorOnKeyBoardLetters();
  }

  List<dynamic> getResult(int wordIndex) {
    try {
      return _wordAttemptsResult[wordIndex];
    } on RangeError {
      return [3, 3, 3, 3, 3];
    }
  }

  void _setColorOnKeyBoardLetters() {
    int _wordIndex = getWordAttemptIndex();
    List<String> _splitWord = getWord(_wordIndex).split('');
    for (int i = 0; i < _splitWord.length; i++) {
      String _letter = _splitWord[i];
      int _letterStatus = getResult(_wordIndex)[i];
      letterStatus[_letterStatus]?.add(_letter.toUpperCase());
    }
  }
}
