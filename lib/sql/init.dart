class InitSQL {
  static const dbName = 'read_only';
  static const queries = [
    "CREATE TABLE doc (id INTEGER PRIMARY KEY, name TEXT)",
    "CREATE TABLE chapter (id INTEGER PRIMARY KEY, name TEXT)",
    "CREATE TABLE paragraph (id INTEGER PRIMARY KEY, name TEXT)",
  ];
}
