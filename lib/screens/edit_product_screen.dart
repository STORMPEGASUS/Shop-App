// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routename = '/edit-product';
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imagecontroller = TextEditingController();
  final _imageurlfocusnode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    title: '',
    price: 0,
    description: '',
    imageurl: '',
  );

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageurl': '',
  };

  @override
  void dispose() {
    _imagecontroller.dispose();
    _imageurlfocusnode.dispose();
    _imageurlfocusnode.removeListener(_updateimageUrl);
    super.dispose();
  }

  @override
  void initState() {
    _imageurlfocusnode.addListener(_updateimageUrl);
    super.initState();
  }

  var _isinit = true;
  var _isloading = false;
  @override
  void didChangeDependencies() {
    if (_isinit) {
      final productid = ModalRoute.of(context).settings.arguments as String;
      if (productid != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productid);
        _initValues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageurl': '',
        };
        _imagecontroller.text = _editedProduct.imageurl.toString();
      }
    }
    _isinit = false;
    super.didChangeDependencies();
  }

  void _updateimageUrl() {
    if (!_imageurlfocusnode.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _saveform() async {
    final isval = _form.currentState.validate();
    if (!isval) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isloading = true;
    });
    if (_editedProduct.id != null) {
    await  Provider.of<Products>(context, listen: false).UpdateProduct(
        _editedProduct.id,
        _editedProduct,
      );
      
    } else {
      try {
        await Provider.of<Products>(context, listen: false).addProduct(
          _editedProduct,
        );
      } catch (error) {
       await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An Error Occured !!'),
            content: Text('Something Went Wrong'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('Okay'),
              ),
            ],
          ),
        );
      } 
    }
    setState(() {
          _isloading = false;
        });
        Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: _saveform,
            icon: Icon(
              Icons.save,
            ),
          ),
        ],
        backgroundColor: Color.fromARGB(255, 0, 255, 213),
        title: Text(
          'Edit Product',
        ),
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _initValues['title'],
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please provide the Title";
                        } else
                          return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          isfavorite: _editedProduct.isfavorite,
                          title: value,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageurl: _editedProduct.imageurl,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      decoration: InputDecoration(
                        labelText: 'Price',
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please provide Price";
                        } else if (double.tryParse(value) == null) {
                          return "Enter the correct number";
                        } else if (double.parse(value) <= 0) {
                          return "Enter the correct value";
                        } else
                          return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          isfavorite: _editedProduct.isfavorite,
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: double.parse(value),
                          imageurl: _editedProduct.imageurl,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['description'],
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please provide the Description";
                        } else
                          return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          isfavorite: _editedProduct.isfavorite,
                          title: _editedProduct.title,
                          description: value,
                          price: _editedProduct.price,
                          imageurl: _editedProduct.imageurl,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 8, right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imagecontroller.text.isEmpty
                              ? Text('Enter the URL')
                              : FittedBox(
                                  child: Image.network(
                                    _imagecontroller.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imagecontroller,
                            focusNode: _imageurlfocusnode,
                            onFieldSubmitted: (_) {
                              _saveform();
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please provide the URL";
                              } else
                                return null;
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                id: _editedProduct.id,
                                isfavorite: _editedProduct.isfavorite,
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                price: _editedProduct.price,
                                imageurl: value,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
