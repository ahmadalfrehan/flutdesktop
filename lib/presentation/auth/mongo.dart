import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';

import 'const.dart';

class MongoDataBase {
  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    print(db.serverStatus());
    var collection = db.collection(CollectionNAME);
    print(collection.find().toList());
  }
}
