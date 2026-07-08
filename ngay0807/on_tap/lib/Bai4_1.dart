/*
  Bài tập 4.1: Ứng dụng quản lý danh sách sản phẩm
  Yêu cầu: Xây dựng một ứng dụng nhỏ quản lý sản phẩm với các chức năng:
  1. Form thêm sản phẩm:
    Gồm các trường:
    - Tên sản phẩm (bắt buộc),
    - Giá (bắt buộc, phải là số),
    - Mô tả (không bắt buộc).
    Có nút "Thêm sản phẩm" và nút "Xóa tất cả".
  2. Hiển thị danh sách sản phẩm:
    Sử dụng ListView.builder hiển thị các sản phẩm đã thêm.
    Mỗi item hiển thị tên và giá, kèm nút xóa (xóa sản phẩm đó).
  3. Hiển thị ảnh đại diện sản phẩm:
    Mỗi sản phẩm có ảnh đại diện (URL mặc định: https://loremflickr.com/200/200?lock=$id).
    Sử dụng Image.network với xử lý loading và lỗi.
  4. GridView xem sản phẩm:
    Thêm một tab hoặc nút chuyển sang chế độ xem lưới (GridView) với 2 cột,
    hiển thị ảnh và tên sản phẩm.
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Product {
  static int cnt = 0;
  final int _id;
  final String _name;
  final int _price;
  final String? _desc;

  Product({required this._name, required this._price, this._desc})
    : _id = cnt++;
}

class ProductManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductManagerState();
}

class _ProductManagerState extends State<ProductManager> {
  List<Product> products = [];
  final _keyForm = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();
  bool _isValidate = false;
  bool _isList = false;

  void _addProduct() {
    setState(() {
      products.add(
        Product(
          name: _nameController.text,
          price: int.parse(_priceController.text),
          desc: _descController.text,
        ),
      );
      _keyForm.currentState!.reset();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Thêm sản phẩm thành công!')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product manager app',
          style: TextStyle(
            fontSize: 36,
            color: Colors.lightGreen[900],
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.lightGreen[100],
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isList = !_isList;
              });
            },
            icon: Icon(
              _isList ? Icons.list_alt_rounded : Icons.grid_view,
              color: Colors.lightGreen[900],
              size: 40,
            ),
          ),
        ],
      ),

      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Form(
          key: _keyForm,
          onChanged: () {
            setState(() {
              _isValidate = _keyForm.currentState!.validate();
            });
          },
          child: Column(
            spacing: 24,
            children: [
              // ten san pham
              MyProductName(nameController: _nameController),

              // Gia san pham
              MyProductPrice(priceController: _priceController),

              // Mo ta san pham
              MyProductDesc(descController: _descController),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _isValidate ? _addProduct : null,
                    child: Text('Thêm sản phẩm'),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        products.clear();
                        _keyForm.currentState!.reset();
                      });
                    },
                    child: Text('Xóa tất cả'),
                  ),
                ],
              ),

              _isList
                  ? MyListProduct(products: products)
                  : MyGridProduct(products: products),
            ],
          ),
        ),
      ),
    );
  }
}

class MyGridProduct extends StatelessWidget {
  const MyGridProduct({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.8
          ),
          itemBuilder: (context, index) {
            return Container(
              color: Colors.lightGreen[100],
              padding: EdgeInsets.all(8),
              child: Column(
                spacing: 8,
                children: [
                  MyProductImage(products: products, index: index),
                  Text('Tên sản phẩm: ${products[index]._name}'),
                  Text('Mô tả sản phẩm: ${products[index]._desc}', maxLines: 1, softWrap: true, overflow: TextOverflow.ellipsis,)
                ],
              ),
            );
          },
        ),
      );
  }
}

class MyListProduct extends StatelessWidget {
  const MyListProduct({
    super.key,
    required this.products,
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                spacing: 24,
                children: [
                  MyProductImage(products: products, index: index,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text('Tên sản phẩm: ${products[index]._name}'),
                      Text('Mô tả sản phẩm: ${products[index]._desc}')
                    ],
                  )
                ],
              ),
            );
          },
        ),
      );
  }
}

class MyProductImage extends StatelessWidget {
  int _index;
  MyProductImage({
    super.key,
    required this.products,
    required this._index
  });

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
          'https://loremflickr.com/200/200?lock=${products[_index]._id}',
      width: 100,
      height: 100,
      fit: BoxFit.cover,
      placeholder: (context, url) => Image.asset(
        'assets/images/loading_img.jpg',
      ),
    );
  }
}

class MyProductDesc extends StatelessWidget {
  const MyProductDesc({super.key, required this._descController});

  final TextEditingController _descController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _descController,
      decoration: InputDecoration(
        labelText: 'Mô tả',
        hintText: 'Nhập mô tả sản phẩm...',
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.next,
    );
  }
}

class MyProductPrice extends StatelessWidget {
  const MyProductPrice({super.key, required this._priceController});

  final TextEditingController _priceController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _priceController,
      decoration: InputDecoration(
        labelText: 'Giá sản phẩm',
        hintText: 'Hãy nhập giá của sản phẩm',
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Giá sản phẩm là bắt buộc!';
        if (num.tryParse(value) == null) return 'Giá phải là 1 số!';
        return null;
      },
      textInputAction: TextInputAction.next,
    );
  }
}

class MyProductName extends StatelessWidget {
  const MyProductName({super.key, required this._nameController});

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Tên sản phẩm',
        hintText: 'Hãy nhập tên của sản phẩm...',
      ),
      controller: _nameController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Tên sản phẩm là bắt buộc';
        return null;
      },
      textInputAction: TextInputAction.next,
    );
  }
}
