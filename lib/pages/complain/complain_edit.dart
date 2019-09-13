import 'package:flutter/material.dart';
import 'package:itrack24/scoped-models/main.dart';
import 'package:itrack24/widgets/ui_elements/default_bottom_navbar.dart';
import 'package:itrack24/widgets/ui_elements/default_side_drawer.dart';
import 'package:scoped_model/scoped_model.dart';

class ComplainEditPage extends StatefulWidget {
  @override
  _ComplainEditPageState createState() => _ComplainEditPageState();
}

class _ComplainEditPageState extends State<ComplainEditPage> {
  bool _isHidden = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _descriptionTextController =
      new TextEditingController();
  String _selectedComplainCategory;
  List<String> _complainHeadingList = [
    'Emergency on street',
    'Drainage Blocking',
    'Solid Waste Removal',
    'Removel of Tree Cutting Debris',
    'Other',
  ];
  List<List<String>> _complainCategoryList = [
    [
      'Stret-Signal post',
      'Street-Pedestrian crossing',
      'Street-lamp',
      'Street-Color light',
      'Street-Dangerous tree',
      'Street-Dangerous construction area',
    ],
    [
      'Drainage Blockage-house',
      'Drainage Blockage-Public building',
      'Drainage Blockage-Road',
    ],
    [
      'Solid waste-house',
      'Solid waste-Public premises',
    ],
    [
      'Tree Cutting Debris-house',
      'Tree Cutting Debris-Public premises',
    ],
    [
      'Mosquito breeding area',
    ]
  ];

  Widget _buildDescriptionFormField() {
    return TextFormField(
      controller: _descriptionTextController,
      textAlign: TextAlign.center,
      maxLines: null,
      decoration: InputDecoration(
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(),
        ),
        filled: true,
        hintText: 'Complain Description',
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Description Cannot be empty';
        }
        return null;
      },
    );
  }

  Widget _buildCategoryText() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isHidden = false;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1.0,color: Colors.transparent),
          borderRadius: BorderRadius.circular(25.0),
        ),
        padding: EdgeInsets.all(15.0),
        child: Text(
          _selectedComplainCategory ?? 'Select a category',
          style: TextStyle(fontSize: 16.0, color: Colors.black54),
        ),
      ),
    );
  }

  Widget _buildComplainCategory() {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(25.0)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1.0),
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Column(
          children: <Widget>[
            _buildCategoryText(),
            !_isHidden ? _buildCategorySelectionList() : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySelectionList() {
    return Container(
      height: 300.0,
      child: Scrollbar(
        child: ListView.builder(
          itemCount: _complainHeadingList.length,
          itemBuilder: (BuildContext context, int x) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        _complainHeadingList[x],
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w500),
                      ),
                      Expanded(child: Container())
                    ],
                  ),
                ),
                ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _complainCategoryList[x].length,
                    itemBuilder: (BuildContext context, int y) {
                      return FlatButton(
                          onPressed: () {
                            setState(() {
                              _selectedComplainCategory =
                                  _complainCategoryList[x][y];
                              _isHidden = true;
                            });
                          },
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 15.0,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 10.0,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(_complainCategoryList[x][y]),
                              Expanded(child: Column())
                            ],
                          ));
                    })
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      key: _scaffoldKey,
      drawer: DefaultSideDrawer(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: defaultBottomAppBar(_scaffoldKey),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Category :',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700),
                  ),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              _buildComplainCategory(),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Description :',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w700),
                  ),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              _buildDescriptionFormField(),
            ],
          )),
    );
  }

  Widget _buildFloatingActionButton() {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, MainModel model) {
        return FloatingActionButton(
          onPressed: () async {},
          tooltip: 'Submit',
          backgroundColor: Colors.black87,
          child: Icon(Icons.check),
        );
      },
    );
  }
}