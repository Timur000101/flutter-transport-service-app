import 'package:flutter/material.dart';
import 'package:sto_app/models/services.dart';

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
        onChanged: (bool value) {
          setState(() {
            _isSelected = !_isSelected;
          });
        },
      ),
    );
  }
}
