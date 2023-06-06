// import 'dart:js';

import 'package:flutter/material.dart';
import 'alert.dart';
import 'listts.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  final _controller=TextEditingController();
  void Change(Item a)
  {
    setState(() {
      a.change=!a.change;
    });
    
  }
  void Loaddata()
  {
    showDialog<void>(context: context, builder: (context)
    {
      return Dialogs(
        controller: _controller,
        Onsave: (){
          Item a=Item(id: Catalog.index+1, task: _controller.text, change: false);
          setState(() {
            Catalog.items.add(a);
            _controller.clear();
            Navigator.of(context).pop();
          });
        },
        Oncancel: ()=> Navigator.pop(context),
      );
    },);
  }
  void Delete(int index)
  {
    setState(() {
      Catalog.items.removeAt(index);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    List<Item> item=[];
    return Scaffold(
      appBar: AppBar(title: Text("ToDo",style: TextStyle(color: Colors.black54),),actions: [
          IconButton(
            onPressed: () {
              // method to show the search bar
              showSearch(
                context: context,
                // delegate to customize the search bar
                delegate: CustomSearchDelegate()
              );
            },
            icon: const Icon(Icons.search),
          )
        ],),
     floatingActionButton:FloatingActionButton(onPressed: Loaddata,
     child: Icon(Icons.add),
     ),
     
      
      
      body:
      (Catalog.items.length==0)? Center( child: Text("Enter a Task",style: TextStyle(color: Colors.black54)),):
            ListView.builder(
            itemCount: Catalog.items.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: InkWell(
                  onTap: () {
                    Change(Catalog.items[index]);
                  },
                  child: (Catalog.items[index].change)?Icon(Icons.check_box):Icon(Icons.check_box_outline_blank),
                ),
                trailing: 
                InkWell(
                  onTap:() {
                    Delete(index);
                  },
                  child: Icon(Icons.delete,color: Colors.red,),
                ),
                title: Text(Catalog.items[index].task,
                
                style: TextStyle(
                  fontSize: 20,
                  decoration:(Catalog.items[index].change)?TextDecoration.lineThrough:TextDecoration.none,
                ),),
              );
            },
            
     ) );
  }
  
}

class CustomSearchDelegate extends SearchDelegate{
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }
  
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }
  
  @override
  Widget buildResults(BuildContext context) {
    List<Item> res=[];
    
    
      res=Catalog.items.where((Item) => Item.task.contains(query)).toList();
    
      
      return ListView.builder(
      itemCount: res.length,
      itemBuilder: (context, index) {
        var result = res[index];
        return ListTile(
          leading: (res[index].change)?Icon(Icons.check_box):Icon(Icons.check_box_outline_blank),
          title: Text("result"),
        );
      },
    );
    
  }
  
  @override
  Widget buildSuggestions(BuildContext context) {
     List<Item> res=[];
     if(query!='')
      res=Catalog.items.where((Item) => Item.task.contains(query)).toList();
      return ListView.builder(
      itemCount: res.length,
      itemBuilder: (context, index) {
        var result = res[index];
        return ListTile(
          leading: (res[index].change)?Icon(Icons.check_box):Icon(Icons.check_box_outline_blank),
          title: Text(result.task),
        );
      },
    );
  }
}