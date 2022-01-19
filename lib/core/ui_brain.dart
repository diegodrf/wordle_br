class UIBrain {
  static UIBrain? _instance;
  bool showProgressBar = false;
  bool canVibrate = false;


  static UIBrain getInstance() {
    _instance ??= UIBrain();
    return _instance!;
  }
}