class Logger {
  final String name;
  bool debug = true;

  Logger._internal(this.name);

  static Map<String, Logger> _cache;

  factory Logger(String name) {
    if (_cache == null) {
      _cache = {};
    }

    if (_cache.containsKey(name)) {
      return _cache[name];
    } else {
      var logger = Logger._internal(name);
      _cache[name] = logger;
      return logger;
    }
  }

  void log(Object msg) {
    if (debug) {
      print('$name => $msg');
    }
  }
}
