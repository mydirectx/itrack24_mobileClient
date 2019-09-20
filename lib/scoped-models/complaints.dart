import 'dart:convert';

import 'package:itrack24/models/complain.dart';
import 'package:itrack24/scoped-models/image.dart';
import 'package:itrack24/scoped-models/user.dart';
import 'package:itrack24/scoped-models/utility.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

mixin ComplaintsModel on Model, UtilityModel, ImageModel, UserModel {
  List<Complain> _finalComplainList;
  Complain _selectedComplain;

  Complain get selectedComplain {
    return _selectedComplain;
  }

  set selectedComplain(Complain comp) {
    _selectedComplain = comp;
  }

  List<Complain> get finalComplainList {
    return _finalComplainList;
  }

  Future<Null> fetchComplains(int userId) async {
    isLoading = true;
    final http.Response response = await http.post(
      '$hostUrl/users/mycomplains',
      body: json.encode({'user_id': userId}),
      headers: {'content-type': 'application/json'},
    );
    final List fetchedComplains = json.decode(response.body);
    final List<Complain> fetchedComplainsList = [];
    fetchedComplains.forEach((complain) {
      Complain fetchedComplainElement = Complain(
        complainId: complain['id'],
        userId: complain['user_id'],
        category: complain['category'],
        description: complain['description'],
        complainImage: complain['complainImg'],
        address1: complain['address1'],
        address2: complain['address1'],
        district: complain['district'],
        date: complain['date'],
        time: complain['time'],
        latitude: complain['latitude'],
        longitude: complain['longitude'],
      );
      fetchedComplainsList.add(fetchedComplainElement);
    });
    _finalComplainList = fetchedComplainsList;
    isLoading = false;
  }

  Future<Null> submitComplain(Complain complain) async {
    isLoading = true;
    await uploadImage('/users/upload-image', 'compImg');
    final Map<String, dynamic> _complainDetails = {
      'user_id': user.userId,
      'category': complain.category,
      'description': complain.description,
      'longitude': complain.longitude,
      'latitude': complain.latitude,
      'complainImg': null,
      'address1': complain.address1,
      'address2': complain.address2,
      'district': complain.district,
      'date': complain.date,
      'time': complain.time,
    };
    final http.Response response = await http.post(
      '$hostUrl/users/complain',
      body: json.encode(_complainDetails),
      headers: {'content-type': 'application/json'},
    );
    isLoading = false;
    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);
  }
}
