import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const routename = '/edit-product';
  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imagecontroller = TextEditingController();
  final _imageurlfocusnode = FocusNode();
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

  void _updateimageUrl() {
    if (!_imageurlfocusnode.hasFocus) {
      setState(() {});
    }
  }

  void _saveform() {}

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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
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