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
    String titleCache = model.title;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(model != null ? "Editar" : "Novo"),
          content: TextFormField(
            initialValue: model.title,
            maxLines: 5,
            onChanged: (value) {
              model.title = value;
            },
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancelar"),
              onPressed: () {
                model.title = titleCache;
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Salvar"),
              onPressed: () {
                if (model.id != null) {
                  controller.update(model);
                } else {
                  controller.add(model);
                }
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
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Remover tudo",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: controller.cleanAll,
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Total de itens na lista: ${controller.itemsTotal}",
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Text(
                      "Total de itens marcados: ${controller.itemsChecked}",
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.list.length,
                  itemBuilder: (_, int index) {
                    TodoModel model = controller.list[index];
                    return ItemWidget(
                      model: model,
                      onPressed: () {
                        _showDialog(model);
                      },
                    );
                  },
                ),
              ),
            ],
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
