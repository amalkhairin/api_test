class CountryModel{
  String name;
  String code;
  String capital;
  String region;
  String flag;
  CountryModel({this.name,this.code,this.capital,this.region,this.flag});

  factory CountryModel.fromJson(Map<String,dynamic> data){
    return CountryModel(
      name: data['name'],
      code: data['alpha2Code'],
      capital: data['capital'],
      region: data['region'],
      flag: data['flag']
    );
  }
}

class Country{
  List<CountryModel> model;
  Country({this.model});

  factory Country.fromJson(List<dynamic> data){
    List<CountryModel> model = List<CountryModel>();
    model = data.map((e) => CountryModel.fromJson(e)).toList();

    return Country(
      model: model
    );
  }
}