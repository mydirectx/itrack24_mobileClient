import 'dart:convert';

import 'package:itrack24/models/complain.dart';
import 'package:itrack24/scoped-models/utility.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

mixin ComplaintsModel on Model, UtilityModel {
  Future<Null> fetchComplains(int userId) async {
    final http.Response response = await http.post(
      '$hostUrl/mycomplains',
      body: {'user_id': userId},
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
  }
}
