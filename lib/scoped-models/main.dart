import 'package:itrack24/scoped-models/User.dart';
import 'package:itrack24/scoped-models/news.dart';
import 'package:itrack24/scoped-models/utility.dart';
import 'package:scoped_model/scoped_model.dart';


class MainModel extends Model with UtilityModel, UserModel ,NewsModel{

}
