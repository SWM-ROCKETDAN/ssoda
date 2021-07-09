import 'package:flutter/material.dart';
import 'package:hashchecker/widgets/holo_date_picker/flutter_holo_date_picker.dart';

class EventPeriod extends StatefulWidget {
  final period;
  EventPeriod({Key? key, this.period}) : super(key: key);

  @override
  _EventPeriodState createState() => _EventPeriodState();
}

class _EventPeriodState extends State<EventPeriod> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: DatePickerWidget(
              looping: true,
              firstDate: widget.period.startDate,
              lastDate: DateTime(DateTime.now().year + 3, DateTime.now().month,
                  DateTime.now().day),
              //initialDate: DateTime.now()
              dateFormat: "yyyy-MMMM-dd",
              locale: DateTimePickerLocale.ko,
              onChange: (DateTime newDate, _) {
                widget.period.startDate = newDate;
              },
              pickerTheme: DateTimePickerTheme(
                itemTextStyle: TextStyle(color: Colors.black, fontSize: 19),
                dividerColor: Colors.indigoAccent.shade700,
              ),
            ),
          ),
          Text('부터',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          AnimatedContainer(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: DatePickerWidget(
                looping: true,
                firstDate: widget.period.finishDate,
                lastDate: DateTime(DateTime.now().year + 3,
                    DateTime.now().month, DateTime.now().day),
                //initialDate: DateTime.now()
                dateFormat: "yyyy-MMMM-dd",
                locale: DateTimePickerLocale.ko,
                onChange: (DateTime newDate, _) {
                  widget.period.finishDate = newDate;
                },
                pickerTheme: DateTimePickerTheme(
                  itemTextStyle: TextStyle(color: Colors.black, fontSize: 19),
                  dividerColor: Colors.indigoAccent.shade700,
                ),
              ),
            ),
            height: widget.period.isPermanent ? 0 : 160,
            duration: Duration(microseconds: 500),
            curve: Curves.easeIn,
          ),
          Visibility(
            child: Text('까지',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            visible: !widget.period.isPermanent,
          ),
          SizedBox(height: 15),
          CheckboxListTile(
              title: Text(
                '영구적으로 진행하기',
                style: TextStyle(
                    color: widget.period.isPermanent
                        ? Theme.of(context).accentColor
                        : Colors.grey),
              ),
              value: widget.period.isPermanent,
              onChanged: (value) {
                setState(() {
                  widget.period.isPermanent = value!;
                });
              }),
        ],
      ),
    );
  }
}
