
class Catalog{
  static int index=1;
  static List<Item> items=[
    
  ];
}
class Item {
  final int id;
  final String task;
   bool change;
  Item({
    required this.id,
    required this.task,
    required this.change,
  });
}
