import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path/path.dart' as p;
import 'package:provider/provider.dart';
import 'package:shoping/models/product.dart';
import 'package:shoping/provider/modelHud.dart';
import 'package:shoping/servis/store.dart';
import 'package:shoping/widgets/custom_textField.dart';

import '../../constant.dart';

class AddProduct extends StatefulWidget {
  static String id = 'AddProduct';

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String _name, _price, _description, _category, _prand, _con;

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final _store = Store();

  File _image1, _image2, _image3;

  String _url, _url2, _url3;
  List<String> selectedSizes = <String>[];
  bool male = false;
  bool Fmale = false;
  void _changeMale(bool value) => setState(() => male = value);
  void _changeFamel(bool value) => setState(() => Fmale = value);
  bool cloths = false;
  bool shose = false;
  void _changeClohes(bool value) => setState(() => cloths = value);
  void _changeShose(bool value) => setState(() => shose = value);
  String selectedCate = "Product   Type";

  var Cate = [
    "Product   Type",
    KShirtsColletion,
    KTshirtsColletion,
    KshoseColletion,
    KPantsColletion,
    KWomenColletion,
  ];
  @override
  Widget build(BuildContext context) {
    print(selectedCate);
    final hight = MediaQuery.of(context).size.height * .01;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModelHud>(context).isLoding,
        child: StreamBuilder<Object>(
            stream: null,
            builder: (context, snapshot) {
              return Container(
                height: MediaQuery.of(context).size.height * 1.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/loginBG.jpg"),
                      fit: BoxFit.cover),
                ),
                child: Form(
                  key: _globalKey,
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .1,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Add Product Photo ",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                          SizedBox(
                            height: hight,
                          ),
                          SingleChildScrollView(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: OutlineButton(
                                        borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.5),
                                            width: 2.5),
                                        onPressed: () {
                                          _selectImage(
                                              ImagePicker.pickImage(
                                                  source: ImageSource.gallery),
                                              1);
                                        },
                                        child: _displayChild1()),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: OutlineButton(
                                        borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.5),
                                            width: 2.5),
                                        onPressed: () {
                                          _selectImage(
                                              ImagePicker.pickImage(
                                                  source: ImageSource.gallery),
                                              2);
                                        },
                                        child: _displayChild2()),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: OutlineButton(
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.5),
                                          width: 2.5),
                                      onPressed: () {
                                        _selectImage(
                                            ImagePicker.pickImage(
                                                source: ImageSource.gallery),
                                            3);
                                      },
                                      child: _displayChild3(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Add Product Name",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: hight,
                              ),
                              Expanded(
                                child: CtextField(
                                  hint: 'Product Name',
                                  TextValue: (value) {
                                    _name = value;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Add Product price",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: hight,
                              ),
                              Expanded(
                                child: CtextField(
                                  TextValue: (value) {
                                    _price = value;
                                  },
                                  hint: 'Product Price',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Add Product Description",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: hight,
                              ),
                              Expanded(
                                child: CtextField(
                                  TextValue: (value) {
                                    _description = value;
                                  },
                                  hint: 'Product Description',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Add Product Prand ",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                              SizedBox(
                                height: hight,
                              ),
                              Expanded(
                                child: CtextField(
                                  TextValue: (value) {
                                    _prand = value;
                                  },
                                  hint: 'Product Prand',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
//                          Text(
//                            "Add Product Condation ",
//                            style: TextStyle(fontSize: 20, color: Colors.white),
//                          ),
//                          SizedBox(
//                            height: hight,
//                          ),
//                          CtextField(
//                            TextValue: (value) {
//                              _con = value;
//                            },
//                            hint: 'Product condation',
//                          ),
//                          Expanded(
//                            child: CtextField(
//                              TextValue: (value) {
//                                _category = value;
//                              },
//                              hint: 'Product Category',
//                            ),
                          Text(
                            "Add Product Catogory ",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Card(
                              color: Colors.grey,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  DropdownButton(
                                    items: Cate.map((select) {
                                      return DropdownMenuItem(
                                        value: select,
                                        child: Text(
                                          select,
                                          style:
                                              TextStyle(color: Colors.black87),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (v) {
                                      setState(() {
                                        selectedCate = v;
                                      });
                                    },
                                    value: selectedCate,
                                  ),
                                ],
                              )),
                          SizedBox(
                            height: hight,
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 20,
                          ),
//                          Text(
//                            "Product Type ",
//                            style: TextStyle(fontSize: 20, color: Colors.white),
//                          ),
//                          Card(
//                            color: Colors.grey,
//                            child: Row(
//                              crossAxisAlignment: CrossAxisAlignment.center,
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              children: <Widget>[
//                                Checkbox(
//                                    hoverColor: Colors.grey,
//                                    value: cloths,
//                                    onChanged: (value) {
//                                      _changeClohes(value);
//                                    }),
//                                Text("Shose"),
//                                Checkbox(
//                                    hoverColor: Colors.grey,
//                                    value: shose,
//                                    onChanged: (value) {
//                                      _changeShose(value);
//                                    }),
//                                Text("Clothes"),
//                              ],
//                            ),
//                          ),
//                          Text(
//                            "Gender Type ",
//                            style: TextStyle(fontSize: 20, color: Colors.white),
//                          ),
//                          Card(
//                            color: Colors.grey,
//                            child: Row(
//                              crossAxisAlignment: CrossAxisAlignment.center,
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              children: <Widget>[
//                                Checkbox(
//                                    hoverColor: Colors.grey,
//                                    value: male,
//                                    onChanged: (value) {
//                                      _changeMale(value);
//                                    }),
//                                Text("Male"),
//                                Checkbox(
//                                    hoverColor: Colors.grey,
//                                    value: Fmale,
//                                    onChanged: (value) {
//                                      _changeFamel(value);
//                                    }),
//                                Text("Fmale"),
//                              ],
//                            ),
//                          ),
                          Text(
                            "Select Available Sizes ",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          (selectedCate == KWomenColletion ||
                                  selectedCate == KPantsColletion ||
                                  selectedCate == KTshirtsColletion ||
                                  selectedCate == KShirtsColletion)
                              ? Card(
                                  color: Colors.grey,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Checkbox(
                                          value: selectedSizes.contains('S'),
                                          onChanged: (value) =>
                                              changeSelectedSize('S')),
                                      Text('S'),
                                      Checkbox(
                                          value: selectedSizes.contains('M'),
                                          onChanged: (value) =>
                                              changeSelectedSize('M')),
                                      Text('M'),
                                      Checkbox(
                                          value: selectedSizes.contains('L'),
                                          onChanged: (value) =>
                                              changeSelectedSize('L')),
                                      Text('L'),
                                      Checkbox(
                                          value: selectedSizes.contains('XL'),
                                          onChanged: (value) =>
                                              changeSelectedSize('XL')),
                                      Text('XL'),
                                      Checkbox(
                                          value: selectedSizes.contains('XXL'),
                                          onChanged: (value) =>
                                              changeSelectedSize('XXL')),
                                      Text('XXL'),
                                    ],
                                  ),
                                )
                              : SizedBox(),
                          selectedCate == KshoseColletion
                              ? Card(
                                  elevation: 2,
                                  color: Colors.grey,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          verticalDirection:
                                              VerticalDirection.down,
                                          children: <Widget>[
                                            Checkbox(
                                                value: selectedSizes
                                                    .contains('30'),
                                                onChanged: (value) =>
                                                    changeSelectedSize('30')),
                                            Text('30'),
                                            Checkbox(
                                                value: selectedSizes
                                                    .contains('32'),
                                                onChanged: (value) =>
                                                    changeSelectedSize('32')),
                                            Text('32'),
                                            Checkbox(
                                                value: selectedSizes
                                                    .contains('34'),
                                                onChanged: (value) =>
                                                    changeSelectedSize('34')),
                                            Text('34'),
                                            Checkbox(
                                                value: selectedSizes
                                                    .contains('36'),
                                                onChanged: (value) =>
                                                    changeSelectedSize('36')),
                                            Text('36'),
                                            Checkbox(
                                                value: selectedSizes
                                                    .contains('38'),
                                                onChanged: (value) =>
                                                    changeSelectedSize('38')),
                                            Text('38'),
                                            Checkbox(
                                                value: selectedSizes
                                                    .contains('39'),
                                                onChanged: (value) =>
                                                    changeSelectedSize('39')),
                                            Text('39'),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Checkbox(
                                                value: selectedSizes
                                                    .contains('40'),
                                                onChanged: (value) =>
                                                    changeSelectedSize('40')),
                                            Text('40'),
                                            Checkbox(
                                                value: selectedSizes
                                                    .contains('41'),
                                                onChanged: (value) =>
                                                    changeSelectedSize('41')),
                                            Text('41'),
                                            Checkbox(
                                                value: selectedSizes
                                                    .contains('42'),
                                                onChanged: (value) =>
                                                    changeSelectedSize('42')),
                                            Text('42'),
                                            Checkbox(
                                                value: selectedSizes
                                                    .contains('43'),
                                                onChanged: (value) =>
                                                    changeSelectedSize('43')),
                                            Text('43'),
                                            Checkbox(
                                                value: selectedSizes
                                                    .contains('44'),
                                                onChanged: (value) =>
                                                    changeSelectedSize('44')),
                                            Text('44'),
                                            Checkbox(
                                                value: selectedSizes
                                                    .contains('45'),
                                                onChanged: (value) =>
                                                    changeSelectedSize('45')),
                                            Text('45'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox(),
//                          Card(
//                            elevation: 2,
//                            color: Colors.grey,
//                            child:
//                            Row(
//                              children: <Widget>[
//                                Checkbox(
//                                    value: selectedSizes.contains('40'),
//                                    onChanged: (value) =>
//                                        changeSelectedSize('40')),
//                                Text('40'),
//                                Checkbox(
//                                    value: selectedSizes.contains('41'),
//                                    onChanged: (value) =>
//                                        changeSelectedSize('41')),
//                                Text('41'),
//                                Checkbox(
//                                    value: selectedSizes.contains('42'),
//                                    onChanged: (value) =>
//                                        changeSelectedSize('42')),
//                                Text('42'),
//                                Checkbox(
//                                    value: selectedSizes.contains('43'),
//                                    onChanged: (value) =>
//                                        changeSelectedSize('43')),
//                                Text('43'),
//                                Checkbox(
//                                    value: selectedSizes.contains('44'),
//                                    onChanged: (value) =>
//                                        changeSelectedSize('44')),
//                                Text('44'),
//                                Checkbox(
//                                    value: selectedSizes.contains('45'),
//                                    onChanged: (value) =>
//                                        changeSelectedSize('45')),
//                                Text('45'),
//                              ],
//                            ),
//                          ),
                          Builder(
                            builder: (context) => RaisedButton(
                              color: Colors.white54,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide.none),
                              onPressed: () async {
                                await uplodeProduct(context);
                              },
                              child: Text('Add Product'),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Future uplodeProduct(BuildContext context) async {
    _globalKey.currentState.save();

    if (_globalKey.currentState.validate() && selectedSizes != null) {
      final modelhud = Provider.of<ModelHud>(context, listen: false);

      try {
        modelhud.ChangeIsLoding(true);
        if (_image1 != null) {
          await uplodeImage();
        }
        if (_image2 != null) {
          await uplodeImage2();
        }
        if (_image3 != null) {
          await uplodeImage3();
        }

        await _store.addProudect(
            product: Product(
              Pname: _name,
              Pprice: _price,
              Pdescriptin: _description,
              Ploction: _url,
              Ploction2: _url2,
              Ploction3: _url3,
              Pcatogery: _category,
              ProPrand: _prand,
              ProPcon: _con,
              PAvlibelSize: selectedSizes,
            ),
            ProductColiction: selectedCate);
        Scaffold.of(context).showSnackBar(SnackBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.purple, style: BorderStyle.solid),
          ),
          backgroundColor: Colors.white54,
          duration: Duration(seconds: 5),
          content: Text(
            "Item added",
            style: TextStyle(color: Colors.black),
          ),
        ));
      } catch (e) {
        modelhud.ChangeIsLoding(false);
        print(e);

        Scaffold.of(context).showSnackBar(SnackBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.purple, style: BorderStyle.solid),
          ),
          backgroundColor: Colors.white54,
          duration: Duration(seconds: 5),
          content: Text(
            e,
            style: TextStyle(color: Colors.black),
          ),
        ));
      }
      modelhud.ChangeIsLoding(false);
    } else
      Scaffold.of(context).showSnackBar(SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.purple, style: BorderStyle.solid),
        ),
        backgroundColor: Colors.white70,
        duration: Duration(milliseconds: 500),
        content: Text(
          "Enter value ",
          style: TextStyle(color: Colors.purple),
        ),
      ));
    print("sssssssssssssssssssssssssssssssssssssssssss");
  }

//  void pickImage() async {
//    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
//
//    setState(() {
//      _image = image;
//    });
//  }
  Future uplodeImage3() async {
    FirebaseStorage storege =
        FirebaseStorage(storageBucket: 'gs://shoping-47fca.appspot.com');
    StorageReference ref = storege.ref().child(p.basename(_image3.path));
    StorageUploadTask storageUploadTask = ref.putFile(_image3);
    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
    String url = await taskSnapshot.ref.getDownloadURL();

    await setState(() {
      _url3 = url;
    });

    print("urlllllllllllllll  $_url2");
  }

  Future uplodeImage() async {
    FirebaseStorage storege =
        FirebaseStorage(storageBucket: 'gs://shoping-47fca.appspot.com');
    StorageReference ref = storege.ref().child(p.basename(_image1.path));
    StorageUploadTask storageUploadTask = ref.putFile(_image1);
    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
    String url = await taskSnapshot.ref.getDownloadURL();

    await setState(() {
      _url = url;
    });

    print("urlllllllllllllll  $_url");
  }

  Future uplodeImage2() async {
    FirebaseStorage storege =
        FirebaseStorage(storageBucket: 'gs://shoping-47fca.appspot.com');
    StorageReference ref = storege.ref().child(p.basename(_image2.path));
    StorageUploadTask storageUploadTask = ref.putFile(_image2);
    StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
    String url = await taskSnapshot.ref.getDownloadURL();

    await setState(() {
      _url2 = url;
    });

    print("urlllllllllllllll  $_url2");
  }

  void changeSelectedSize(String size) {
    if (selectedSizes.contains(size)) {
      setState(() {
        selectedSizes.remove(size);
      });
    } else {
      setState(() {
        selectedSizes.insert(0, size);
      });
    }
  }

  Widget _displayChild1() {
    if (_image1 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(
          Icons.add,
          color: Colors.white,
        ),
      );
    } else {
      return Image.file(
        _image1,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Widget _displayChild2() {
    if (_image2 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(
          Icons.add,
          color: Colors.white,
        ),
      );
    } else {
      return Image.file(
        _image2,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  Widget _displayChild3() {
    if (_image3 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 70, 14, 70),
        child: new Icon(
          Icons.add,
          color: Colors.white,
        ),
      );
    } else {
      return Image.file(
        _image3,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }

  void _selectImage(Future<File> pickImage, int imageNumber) async {
    File tempImg = await pickImage;
    switch (imageNumber) {
      case 1:
        setState(() => _image1 = tempImg);
        break;
      case 2:
        setState(() => _image2 = tempImg);
        break;
      case 3:
        setState(() => _image3 = tempImg);
        break;
    }
  }
}
