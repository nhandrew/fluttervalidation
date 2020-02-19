import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class ProductBloc {
  final _productName = BehaviorSubject<String>();
  final _productPrice = BehaviorSubject<String>();

  //Get
  Stream<String> get productName => _productName.stream.transform(validateProductName);
  Stream<double> get productPrice => _productPrice.stream.transform(validateProductPrice);
  Stream<bool> get productValid => Rx.combineLatest2(productName, productPrice, (productName,productPrice) => true);

  //Set
  Function(String) get changeProductName => _productName.sink.add;
  Function(String) get changeProductPrice => _productPrice.sink.add;

  dispose(){
    _productName.close();
    _productPrice.close();
  }

  //Transformers
  final validateProductName = StreamTransformer<String,String>.fromHandlers(
    handleData: (productName,sink){
      if (productName.length < 4){
        sink.addError('Product Name must be at least 4 characters');
      } else {
        sink.add(productName);
      }
    }
  );

  final validateProductPrice = StreamTransformer<String,double>.fromHandlers(
    handleData: (productPrice,sink) {
      try {
        sink.add(double.parse(productPrice));
      } catch(error){
        sink.addError('Value must be a number');
      }
    }
  );

  submitProduct(){
    print('Product Submitted with Name: ${_productName.value} and Price: ${_productPrice.value}');
  }
}