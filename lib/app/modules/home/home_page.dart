import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:todo_mobx/app/modules/home/components/item/item_widget.dart';
import 'package:todo_mobx/app/modules/home/home_controller.dart';
import 'package:todo_mobx/app/modules/home/home_module.dart';
import 'package:todo_mobx/app/shared/models/todo_model.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Todo List Mobx"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeModule.to.bloc<HomeController>();

  _showDialog([TodoModel model]) {
    model = model ?? TodoModel();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("Novo"),
          content: TextField(
            maxLines: 5,
            onChanged: (value) {
              model.title = value;
            },
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Salvar"),
              onPressed: () {
                controller.add(model);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Observer(
        builder: (_) {
          return ListView.builder(
            itemCount: controller.list.length,
            itemBuilder: (_, int index) {
              TodoModel model = controller.list[index];
              return ItemWidget(
                model: model,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _showDialog();
        },
      ),
    );
  }
}
