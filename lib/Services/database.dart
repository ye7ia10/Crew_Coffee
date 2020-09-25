import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/Models/Brew.dart';
import 'package:coffee/Models/User.dart';

class DataBaseService {

  final String cUId;

  DataBaseService({this.cUId});

  //collection reference
  final CollectionReference brewRef = Firestore.instance.collection("Brews");


  // ignore: non_constant_identifier_names
  Future UpdateData(String name, String sugar, int strength) async {
    return await brewRef.document(cUId).setData({
      'name': name,
      'sugar': sugar,
      'strength': strength,
    });
  }

  List<Brew> _getListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
        name: doc.data['name'] ?? '',
        sugar: doc.data['sugar'] ?? '0',
        strength: doc.data['strengh'] ?? 0,
      );
    }).toList();
  }

  Stream<List<Brew>> get brews {
    return brewRef.snapshots().map(_getListFromSnapShot);
  }

  Stream<UserData> get user {
    return brewRef.document(cUId).snapshots().map(_getUserData);
  }

  UserData _getUserData(DocumentSnapshot snapshot) {
    return UserData(
        id: cUId,
        name: snapshot.data['name'],
        sugar : snapshot.data['sugar'],
        strength : snapshot.data['strength'],

    );
  }
}