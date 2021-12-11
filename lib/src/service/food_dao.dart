import 'package:firebase_database/firebase_database.dart';
import 'package:nutria/src/screen/models/foods_list_data.dart';

class FoodDao {
  final FirebaseDatabase database = FirebaseDatabase(
      databaseURL:
          'https://nutria-de550-default-rtdb.asia-southeast1.firebasedatabase.app');
  late final DatabaseReference _foodRef = database.reference().child('food');

  void saveFood(FoodData foodData) {
    _foodRef.push().set(foodData.toJson());
  }

  Future<void> addFood({required String key, required FoodData data}) async {
    _foodRef.child(key).set(data.toJson()).whenComplete(() {
      print('### Success Add food');
    }).catchError((error) {
      print('Failed to add food: $error');
    });
  }

  void initialFoodList() {
    _foodRef.push().set(FoodData(
          foodName: 'Noodle',
          kacl: 333,
          startColor: '#FA7D82',
          endColor: '#FFB295',
        ).toJson());
    _foodRef.push().set(FoodData(
          foodName: 'Tofu',
          kacl: 150,
          startColor: '#738AE6',
          endColor: '#5C5EDD',
        ).toJson());
    _foodRef.push().set(FoodData(
          foodName: 'Rice',
          kacl: 345,
          startColor: '#FE95B6',
          endColor: '#FF5287',
        ).toJson());
    _foodRef.push().set(FoodData(
          foodName: 'Corn Flakes',
          kacl: 387,
          startColor: '#6F72CA',
          endColor: '#1E1466',
        ).toJson());
    _foodRef.push().set(FoodData(
          foodName: 'Baby Corn',
          kacl: 37,
          startColor: '#FA7D82',
          endColor: '#FFB295',
        ).toJson());
    _foodRef.push().set(FoodData(
          foodName: 'Watermelon',
          kacl: 24,
          startColor: '#738AE6',
          endColor: '#5C5EDD',
        ).toJson());
    _foodRef.push().set(FoodData(
          foodName: 'Honeydew',
          kacl: 24,
          startColor: '#FE95B6',
          endColor: '#FF5287',
        ).toJson());
    _foodRef.push().set(FoodData(
          foodName: 'Pomegranate',
          kacl: 80,
          startColor: '#6F72CA',
          endColor: '#1E1466',
        ).toJson());
    _foodRef.push().set(FoodData(
          foodName: 'Beef Sausage',
          kacl: 194,
          startColor: '#FA7D82',
          endColor: '#FFB295',
        ).toJson());
    _foodRef.push().set(FoodData(
          foodName: 'Chicken Sausage',
          kacl: 193,
          startColor: '#738AE6',
          endColor: '#5C5EDD',
        ).toJson());
    _foodRef.push().set(FoodData(
          foodName: 'Egg Noodles',
          kacl: 335,
          startColor: '#FE95B6',
          endColor: '#FF5287',
        ).toJson());
    _foodRef.push().set(FoodData(
          foodName: 'Spaghetti',
          kacl: 347,
          startColor: '#6F72CA',
          endColor: '#1E1466',
        ).toJson());
    _foodRef.push().set(FoodData(
          foodName: 'Biscuit Choc Chip',
          kacl: 479,
          startColor: '#FA7D82',
          endColor: '#FFB295',
        ).toJson());
    _foodRef.push().set(FoodData(
          foodName: 'Bun Kaya',
          kacl: 103,
          startColor: '#738AE6',
          endColor: '#5C5EDD',
        ).toJson());
    _foodRef.push().set(FoodData(
          foodName: 'Potato Chip',
          kacl: 483,
          startColor: '#FE95B6',
          endColor: '#FF5287',
        ).toJson());
    _foodRef.push().set(FoodData(
          foodName: 'Soy Sauce',
          kacl: 189,
          startColor: '#6F72CA',
          endColor: '#1E1466',
        ).toJson());
  }

  Query getFoodListQuery() {
    return _foodRef;
  }

  Future<void> updateFood(FoodData data) async {
    _foodRef.child(data.key!).set(data.toJson()).whenComplete(() {
      print('### Success Update');
    }).catchError((error) {
      print('Failed to update food: $error');
    });
  }

  Future<void> deleteFood(String key) async {
    _foodRef.child(key).remove().whenComplete(() {
      print('### Success Delete');
    }).catchError((error) {
      print('Failed to delete food: $error');
    });
  }
}
