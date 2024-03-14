import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';

class DragAndDropListApp extends StatefulWidget {
  const DragAndDropListApp({super.key});

  @override
  State<DragAndDropListApp> createState() => _DragAndDropListState();
}

class _DragAndDropListState extends State<DragAndDropListApp> {
 late List<DragAndDropList> listContent;
  @override
  void initState() {
    super.initState();
    listContent = List.generate(2, (index){
      return DragAndDropList(children: [

        DragAndDropItem(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text('List ${index.toString()}.1'),
            trailing: const Icon(Icons.menu),
          ),
        ),
      ),
        DragAndDropItem(
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('List ${index.toString()}.2'),
              trailing: const Icon(Icons.menu),
            ),
          ),
        ),
        DragAndDropItem(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('List ${index.toString()}.3'),
              trailing: const Icon(Icons.menu),
            ),
          ),
        ) , DragAndDropItem(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text('List ${index.toString()}.4'),
              trailing: const Icon(Icons.menu),
            ),
          ),
        ) ,


      ],);
    });
  }

_onItemReorder(int oldItemIndex ,int  oldListIndex ,int newItemIndex ,int newListIndex){
  setState(() {
    var movedItem = listContent[oldListIndex].children.removeAt(oldItemIndex);
    listContent[newListIndex].children.insert(newItemIndex, movedItem);
  });
}

_onListReorder(int oldListIndex , int newListIndex){
setState(() {
  var movedList = listContent.removeAt(oldListIndex);
  listContent.insert(newListIndex, movedList);
});
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('drag and drop demo' , style: TextStyle(fontSize: 20),)),
      ),
      body: DragAndDropLists(children: listContent, onItemReorder: _onItemReorder  , onListReorder: _onListReorder ,listDivider: const Divider(),),

    );
  }
}

