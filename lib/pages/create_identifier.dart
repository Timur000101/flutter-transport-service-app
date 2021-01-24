import 'package:flutter/material.dart';
// import 'package:sto_app/widgets/app_widgets.dart';
import 'package:sto_app/core/const.dart';

class CreateIdentifier extends StatefulWidget {
  CreateIdentifier({Key key}) : super(key: key);

  @override
  _CreateIdentifierState createState() => _CreateIdentifierState();
}

class _CreateIdentifierState extends State<CreateIdentifier> {
  final UnderlineInputBorder identifierBorder = UnderlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: Colors.grey[300]));

  TextEditingController identifierFieldController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Text(
                  "Хотите предложить свои услуги?!",
                  style: TextStyle(
                      fontSize: 18, fontFamily: "Montserrat SemiBold"),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Image.asset("assets/images/identifier.png"),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 40,
                  right: 40,
                  top: 15,
                ),
                child: Text(
                    "Введите идентификатор предоставленный нашей компанией, если у вас его нет, обратитесь к модератору.",
                    style: TextStyle(
                        color: AppColors.primaryTextColor,
                        fontSize: 12,
                        fontFamily: "Montserrat Regular"),
                    textAlign: TextAlign.center),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 16),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: identifierFieldController,
                  maxLength: 8,
                  cursorColor: Colors.grey[600],
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey[500]),
                      fillColor: Colors.grey[300],
                      filled: true,
                      counterText: "",
                      enabledBorder: identifierBorder,
                      focusedBorder: identifierBorder,
                      labelText: "Идентификатор",
                      hintText: "XXXXXXXX",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 12)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 36, left: 20, right: 20, bottom: 8),
                child: myButton(context, Colors.red[600], "Готово"),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: myButton(context, Colors.grey[500], "Отправить заявку"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myButton(BuildContext context, Color color, String text) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: RaisedButton(
        padding: EdgeInsets.symmetric(vertical: 17),
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(6.0)),
        child: Text(
          text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        color: color,
        textColor: AppColors.lightColor,
        onPressed: () {
          // Scaffold.of(context)
          // .showSnackBar(SnackBar(content: Text('asdasd')));
        },
      ),
    );
  }
}
