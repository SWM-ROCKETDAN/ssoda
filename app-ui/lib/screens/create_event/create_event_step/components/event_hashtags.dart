import 'package:flutter/material.dart';

class EventHashtags extends StatefulWidget {
  final hashtagList;
  const EventHashtags({Key? key, this.hashtagList}) : super(key: key);

  @override
  _EventHashtagsState createState() => _EventHashtagsState();
}

class _EventHashtagsState extends State<EventHashtags> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 9.0,
            children: List.generate(
              widget.hashtagList.length + 1,
              (index) => index == widget.hashtagList.length
                  ? CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 20,
                      child: IconButton(
                          highlightColor: Colors.transparent,
                          icon: Icon(Icons.add),
                          color: Colors.white,
                          onPressed: () {
                            _showHashtagInputDialog(context);
                          }),
                    )
                  : Chip(
                      avatar: CircleAvatar(
                        radius: 14,
                        child: Icon(
                          Icons.tag,
                          color: Colors.white,
                          size: 18,
                        ),
                        backgroundColor: Colors.black,
                      ),
                      onDeleted: () {
                        setState(() {
                          widget.hashtagList.removeAt(index);
                        });
                      },
                      deleteIconColor: Colors.grey,
                      label: Text('${widget.hashtagList[index]}'),
                      labelPadding: const EdgeInsets.fromLTRB(6, 3, 0, 3),
                      elevation: 3.0,
                      backgroundColor: Colors.white,
                    ),
            )));
  }

  Future<void> _showHashtagInputDialog(BuildContext context) async {
    _controller = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                '해시태그 추가하기',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: TextField(
                controller: _controller,
                decoration: InputDecoration(hintText: '여기에 입력'),
              ),
              actions: [
                ButtonBar(
                  children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        child: Text(
                          '취소',
                        )),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            widget.hashtagList
                                .add(_controller.value.text.trim());
                            Navigator.pop(context);
                          });
                        },
                        child: Text('등록'))
                  ],
                )
              ],
            ));
  }
}
