import 'package:flutter/material.dart';
import 'package:hashchecker/widgets/holo_date_picker/flutter_holo_date_picker.dart';

class EventPeriod extends StatefulWidget {
  final period;
  EventPeriod({Key? key, this.period}) : super(key: key);

  @override
  _EventPeriodState createState() => _EventPeriodState();
}

class _EventPeriodState extends State<EventPeriod>
    with TickerProviderStateMixin {
  final _dateRangeList = ['30일 간', '다음 달까지', '올해까지', '영구 진행', '직접 입력'];
  String? _dropdownValue;

  @override
  void initState() {
    super.initState();
    _dropdownValue = _dateRangeList[widget.period.dateShortcut];
  }

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
          Visibility(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: DatePickerWidget(
                    looping: true,
                    firstDate: widget.period.startDate,
                    lastDate: DateTime(DateTime.now().year + 3,
                        DateTime.now().month, DateTime.now().day),
                    //initialDate: DateTime.now()
                    dateFormat: "yyyy-MMMM-dd",
                    locale: DateTimePickerLocale.ko,
                    onChange: (DateTime newDate, _) {
                      widget.period.finishDate = newDate;
                    },
                    pickerTheme: DateTimePickerTheme(
                      itemTextStyle:
                          TextStyle(color: Colors.black, fontSize: 19),
                      dividerColor: Colors.indigoAccent.shade700,
                    ),
                  ),
                ),
                Text('까지',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            visible: _dropdownValue == _dateRangeList.last,
          ),
          SizedBox(height: 15),
          DropdownButton(
              value: _dropdownValue,
              icon: const Icon(
                Icons.date_range_outlined,
                color: Colors.indigoAccent,
              ),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
              underline: Container(
                height: 2,
                color: Colors.indigoAccent.shade700,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  _dropdownValue = newValue!;
                });

                widget.period.dateShortcut =
                    _dateRangeList.indexOf(_dropdownValue!);

                if (_dropdownValue == _dateRangeList[0]) {
                  widget.period.finishDate =
                      widget.period.startDate.add(Duration(days: 30));
                } else if (_dropdownValue == _dateRangeList[1]) {
                  widget.period.finishDate = DateTime(
                          widget.period.startDate.year,
                          widget.period.startDate.month + 2,
                          1)
                      .subtract(Duration(days: 1));
                } else if (_dropdownValue == _dateRangeList[2]) {
                  widget.period.finishDate =
                      DateTime(widget.period.startDate.year + 1, 1, 1)
                          .subtract(Duration(days: 1));
                } else if (_dropdownValue == _dateRangeList[3]) {
                  widget.period.finishDate = null;
                }
              },
              items: _dateRangeList
                  .map((e) => DropdownMenuItem(
                      child: SizedBox(
                        width: 100,
                        child: Text(
                          e,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      value: e))
                  .toList()),
          Visibility(
            child: Text(
                widget.period.finishDate != null
                    ? '${widget.period.finishDate.toString().substring(0, 10)} 까지에요!'
                    : '이벤트 상품 소진 시까지 진행해요!',
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            visible: _dropdownValue != _dateRangeList.last,
          ),
        ],
      ),
    );
  }
}
