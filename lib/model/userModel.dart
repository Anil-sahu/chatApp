class User{
  String? name;
  String url="";
  DateTime date = DateTime.now();
  User({required this.name,});
  toMap(){
    return {
"name":name,
"url":url,
"date":date
    };
  }
}