import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validation2020/blocs/product_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => ProductBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ProductBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Validation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            productName(bloc),
            productPrice(bloc),
            SizedBox(
              height: 15.0,
            ),
            saveButton(bloc),
          ],
        ),
      ),
    );
  }

  Widget productName(ProductBloc bloc) {
    return StreamBuilder<String>(
        stream: bloc.productName,
        builder: (context, snapshot) {
          return TextField(
            decoration: InputDecoration(
                labelText: 'Product Name', errorText: snapshot.error),
            onChanged: bloc.changeProductName,
          );
        });
  }

  Widget productPrice(ProductBloc bloc) {
    return StreamBuilder<double>(
        stream: bloc.productPrice,
        builder: (context, snapshot) {
          return TextField(
            decoration: InputDecoration(
                labelText: 'Product Price', errorText: snapshot.error),
            onChanged: bloc.changeProductPrice,
          );
        });
  }

  Widget saveButton(ProductBloc bloc) {
    return StreamBuilder<bool>(
      stream: bloc.productValid,
      builder: (context, snapshot) {
        return RaisedButton(
          child: Text('Save Product'),
          onPressed: !snapshot.hasData ? null : bloc.submitProduct,
        );
      }
    );
  }
}
