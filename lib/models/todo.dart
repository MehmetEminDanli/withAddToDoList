class Todo{
  int Id;
  String title;
  bool? isComplated;
  bool? isStar;
  Todo({required this.Id,required this.title,this.isComplated=false,this.isStar=false});
}