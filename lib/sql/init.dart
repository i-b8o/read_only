class InitSQL {
  static const dbName = 'read_only';
  static const queries = [
    '''
      CREATE TABLE paragraph (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        paragraphID INTEGER,
        num INTEGER,
        hasLinks INTEGER,
        isTable INTEGER,
        isNFT INTEGER,
        className TEXT,
        content TEXT,
        chapterID INTEGER,
        FOREIGN KEY (chapterID) REFERENCES chapter(id)
      );
    ''',
    '''
      CREATE TABLE chapter (
        id INTEGER PRIMARY KEY,
        name TEXT,
        orderNum INTEGER,
        num TEXT,
        docID INTEGER,
        FOREIGN KEY (docID) REFERENCES doc(id)
      );

    ''',
    '''
      CREATE TABLE doc (
        id INTEGER PRIMARY KEY,
        name TEXT,
        last_access TIME
      );
    ''',
  ];
}
