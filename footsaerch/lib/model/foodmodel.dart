class FoodModel{
  int id;
  String imgUrl;
  String siteUrl;
  String title;
  String date;

  FoodModel({this.id,this.date,this.imgUrl,this.siteUrl,this.title});

  Map<String, dynamic> toMap(){
    return{
      'id':id,
      'title':title,
      'imgUrl':imgUrl,
      'siteUrl' : siteUrl,
      'date' : date,
    };
  }

  @override
  String toString() {
    return 'FoodModel(id : $id, title : $title,imgUrl : $imgUrl, siteUrl : $siteUrl, date : $date';
  }

}
