class Environments {
  static const String PRODUCTION = 'prod';
  static const String QAS = 'QAS';
  static const String DEV = 'dev';
  static const String LOCAL = 'local';
}

class ConfigEnvironments {
  static const String _currentEnvironments = Environments.LOCAL;
  static final List<Map<String, String>> _availableEnvironments = [
    {
      'env': Environments.LOCAL,
      'url': 'https://jsonplaceholder.typicode.com/',
    },
    {
      'env': Environments.DEV,
      'url': 'https://jsonplaceholder.typicode.com/',
    },
    {
      'env': Environments.QAS,
      'url': 'https://jsonplaceholder.typicode.com/',
    },
    {
      'env': Environments.PRODUCTION,
      'url': 'https://jsonplaceholder.typicode.com/',
    },
  ];

  static Map<String, String> getEnvironments() {
    return _availableEnvironments.firstWhere(
      (d) => d['env'] == _currentEnvironments,
    );
  }
}
