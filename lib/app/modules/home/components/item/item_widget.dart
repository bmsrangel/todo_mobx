import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:todo_mobx/app/modules/home/home_controller.dart';
import 'package:todo_mobx/app/modules/home/home_module.dart';
import 'package:todo_mobx/app/shared/models/todo_model.dart';

class ItemWidget extends StatefulWidget {
  const ItemWidget({Key key, this.model, this.onPressed}) : super(key: key);
  final TodoModel model;
  final Function onPressed;

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  final homeController = HomeModule.to.bloc<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return ListTile(
          leading: IconButton(
            icon: Icon(Icons.remove_circle),
            color: Colors.red,
            onPressed: () {
              _removeItem(widget.model.id);
            },
          ),
          onTap: widget.onPressed,
          title: Text(widget.model.title),
          trailing: Checkbox(
            value: widget.model.check,
            onChanged: (bool value) {
              widget.model.check = value;
              homeController.update(widget.model);
            },
          ),
        );
      },
    );
  }

  void _removeItem(int id) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return AlertDialog(
            title: Text("Remover elemento?"),
            content: Text("Esta ação é irreversível!"),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Confirmar"),
                onPressed: () {
                  homeController.delete(id);
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
