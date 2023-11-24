// import 'package:dargon2/dargon2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../../home/home-screen.dart';
import '../const.dart';
import '../mongo.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  getuser() async {
    var db = await Db.create(MONGO_URL);
    await db.open();

    print(db.serverStatus());

    final collection = db.collection(CollectionNAME);

    // Replace 'user@example.com' with the actual user email you want to find
    final user =
        await collection.findOne(where.eq('email', emailController.text));
    print(user);
  }

  RxBool isLogin = true.obs;
  RxBool isLoading = false.obs;
  RxString status = ''.obs;

  login(BuildContext context) async {
    isLoading.value = true;
    var db = await Db.create(MONGO_URL);
    await db.open();

    print(db.serverStatus());

    final collection = db.collection(CollectionNAME);

    final user =
        await collection.findOne(where.eq('email', emailController.text));
    if (user != null) {
      print('User found: $user');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('User found: $user')));
      final storedHashedPassword = user['password'];
      print(storedHashedPassword);

      if (storedHashedPassword == passwordController.text) {
        print('Login successful!');
        status.value = 'Login successful';
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(status.value.toString())),
        );
      } else {
        print('Incorrect password');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Incorrect password")));
      }
    } else {
      print('User not found');

      status.value = 'User not found';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(status.value.toString())),
      );
    }
    db.close();
    isLoading.value = false;
  }

  createDB() async {
    await MongoDataBase.connect();
  }

  addUser() async {
    isLoading.value = true;
    final hashedPassword = passwordController.text;

    Map<String, dynamic> newUser = {
      'email': emailController.text,
      'password': hashedPassword,
    };
    print(newUser);
    var db = await Db.create(MONGO_URL);
    await db.open();
    final collection = db.collection(CollectionNAME);

    await collection.insert(newUser);

    print('User added successfully');
    status.value = "User added successfully";
    db.close();
    isLoading.value = false;
  }
}
