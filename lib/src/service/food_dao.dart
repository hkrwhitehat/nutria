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

  void initialFoodList() {
    _foodRef.push().set(FoodData(
          titleTxt: 'Noodle',
          kacl: 333,
          startColor: '#FA7D82',
          endColor: '#FFB295',
        ).toJson());
    _foodRef.push().set(FoodData(
          titleTxt: 'Tofu',
          kacl: 150,
          startColor: '#738AE6',
          endColor: '#5C5EDD',
        ).toJson());
    _foodRef.push().set(FoodData(
          titleTxt: 'Rice',
          kacl: 345,
          startColor: '#FE95B6',
          endColor: '#FF5287',
        ).toJson());
    _foodRef.push().set(FoodData(
          titleTxt: 'Corn Flakes',
          kacl: 387,
          startColor: '#6F72CA',
          endColor: '#1E1466',
        ).toJson());
    _foodRef.push().set(FoodData(
          titleTxt: 'Baby Corn',
          kacl: 37,
          startColor: '#FA7D82',
          endColor: '#FFB295',
        ).toJson());
    _foodRef.push().set(FoodData(
          titleTxt: 'Watermelon',
          kacl: 24,
          startColor: '#738AE6',
          endColor: '#5C5EDD',
        ).toJson());
    _foodRef.push().set(FoodData(
          titleTxt: 'Honeydew',
          kacl: 24,
          startColor: '#FE95B6',
          endColor: '#FF5287',
        ).toJson());
    _foodRef.push().set(FoodData(
          titleTxt: 'Pomegranate',
          kacl: 80,
          startColor: '#6F72CA',
          endColor: '#1E1466',
        ).toJson());
    _foodRef.push().set(FoodData(
          titleTxt: 'Beef Sausage',
          kacl: 194,
          startColor: '#FA7D82',
          endColor: '#FFB295',
        ).toJson());
    _foodRef.push().set(FoodData(
          titleTxt: 'Chicken Sausage',
          kacl: 193,
          startColor: '#738AE6',
          endColor: '#5C5EDD',
        ).toJson());
    _foodRef.push().set(FoodData(
          titleTxt: 'Egg Noodles',
          kacl: 335,
          startColor: '#FE95B6',
          endColor: '#FF5287',
        ).toJson());
    _foodRef.push().set(FoodData(
          titleTxt: 'Spaghetti',
          kacl: 347,
          startColor: '#6F72CA',
          endColor: '#1E1466',
        ).toJson());
    _foodRef.push().set(FoodData(
          titleTxt: 'Biscuit Choc Chip',
          kacl: 479,
          startColor: '#FA7D82',
          endColor: '#FFB295',
        ).toJson());
    _foodRef.push().set(FoodData(
          titleTxt: 'Bun Kaya',
          kacl: 103,
          startColor: '#738AE6',
          endColor: '#5C5EDD',
        ).toJson());
    _foodRef.push().set(FoodData(
          titleTxt: 'Potato Chip',
          kacl: 483,
          startColor: '#FE95B6',
          endColor: '#FF5287',
        ).toJson());
    _foodRef.push().set(FoodData(
          titleTxt: 'Soy Sauce',
          kacl: 189,
          startColor: '#6F72CA',
          endColor: '#1E1466',
        ).toJson());
  }

  Query getFoodListQuery() {
    return _foodRef;
  }
}
