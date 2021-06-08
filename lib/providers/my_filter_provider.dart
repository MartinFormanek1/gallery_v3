class MyFilterProvider {
  //init singleton
  MyFilterProvider._privateConstructor();
  static final MyFilterProvider _instance =
      MyFilterProvider._privateConstructor();
  static MyFilterProvider get instance => _instance;

  final List<List<double>> _filters = [
    NO_FILTER,
    // GRAYSCALE,
    // SEPIUM,
    // OLD_TIMES,
    MILK,
    OLD_TIMES
  ];

  List<List<double>> get filters => _filters;

  static const NO_FILTER = [
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0
  ];

  static const GRAYSCALE = [
    0.2126,
    0.7152,
    0.0722,
    0.0,
    0.0,
    0.2126,
    0.7152,
    0.0722,
    0.0,
    0.0,
    0.2126,
    0.7152,
    0.0722,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0
  ];

  static const SEPIUM = [
    1.3,
    -0.3,
    1.1,
    0.0,
    0.0,
    0.0,
    1.3,
    0.2,
    0.0,
    0.0,
    0.0,
    0.0,
    0.8,
    0.2,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0
  ];

  static const MILK = [
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.6,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0
  ];

  static const OLD_TIMES = [
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    -0.4,
    1.3,
    -0.4,
    0.2,
    -0.1,
    0.0,
    0.0,
    1.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    1.0,
    0.0
  ];
}
