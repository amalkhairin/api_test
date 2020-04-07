import 'package:api_test/config.dart';
import 'package:api_test/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  TextEditingController _controller;
  bool isLoading;
  CountryModel _country;

  @override
  void initState() {
    // TODO: implement initState

    _controller = TextEditingController();
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: _builder(),
        ),
      ),
    );
  }

  _searchField(){
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        hintText: 'Masukkan nama negara',
        contentPadding: EdgeInsets.only(left: 10, right: 10, top: 16, bottom: 16),
        suffixIcon: IconButton(
          icon: Icon(Icons.search),
          onPressed: () async {
            setState(() {
              isLoading = true;
            });
            var res = await GetCountry.getCountry(_controller.text);
            if(res != null){
              var data = await Country.fromJson(res);
              setState(() {
                _country = data.model[0];
              });
            }

            setState(() {
              isLoading = false;
            });
          },
        )
      ),
    );
  }

  _content(){
    return isLoading?
      CircularProgressIndicator()
      :
      Padding(
        padding: EdgeInsets.all(16),
        child: _country == null?
          Text("")
          :
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SvgPicture.network(_country.flag, height: 50, placeholderBuilder: (context) => CircularProgressIndicator()),
              Text(_country.name),
              Text(_country.code),
              Text(_country.region),
              Text(_country.capital),
            ],
          )
        ,
      );
  }

  _builder(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16),
          child: _searchField(),
        ),
        _content()
      ],
    );
  }
}