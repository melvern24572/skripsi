import 'package:flutter/material.dart';
class PopUp extends StatelessWidget {
  final Widget child ;
  final Widget child2;
  final Function onPress;
  const PopUp({
    Key key,
    @required GlobalKey<FormState> formKey, @required this.child, @required this.onPress, this.child2,
  }) : _formKey = formKey, super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      content: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            right: -40.0,
            top: -40.0,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                child: Icon(Icons.close),
                backgroundColor: Colors.red,
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: child,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: child2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      RaisedButton(
                        child: Text("Cancel"),
                        onPressed: onPress,
                        /*if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                      }*/
                      ),
                      RaisedButton(
                        child: Text("Submit"),
                        onPressed: onPress,
                        /*if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                      }*/

                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );







  }
}