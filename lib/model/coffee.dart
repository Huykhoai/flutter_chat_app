class Coffee{
  final String title;
  final String description;
  final String image;

  Coffee({required this.title, required this.description,required this.image});
  factory Coffee.fromJson(Map<String, dynamic> json){
    return Coffee(
      title: json['title'],
      description: json['description'],
      image: json['image']
    );
  }
}