import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sto_app/models/services.dart';
import 'package:sto_app/pages/services/service_finish.dart';

class ServiceDetailItem extends StatefulWidget {
  final Services services;
  final int index;
  ServiceDetailItem({@required this.services, @required this.index});

  @override
  _ServiceDetailItemState createState() => _ServiceDetailItemState();
}

class _ServiceDetailItemState extends State<ServiceDetailItem> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CheckboxListTile(
        title: Text(widget.services.fields.name),
        value: _isSelected,
        onChanged: (bool value) async {
          // setState(() {
          //   _isSelected = !_isSelected;
          // });
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => ServiceFinish(servicePK: int.parse(widget.services.fields.service), subservicePK: widget.services.pk,))
          );
        },
      ),
    );
  }
}
