import 'package:Food_Order/base/base_widget.dart';
import 'package:Food_Order/module/signin/signin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      di: [],
      bloc: [],
      child: CreateInfoFormWidget(),
    );
  }
}

class CreateInfoFormWidget extends StatefulWidget {
  @override
  _CreateInfoFormWidgetState createState() => _CreateInfoFormWidgetState();
}

class _CreateInfoFormWidgetState extends State<CreateInfoFormWidget> {
  final TextEditingController _txtFullNameController = TextEditingController();
  final TextEditingController _txtDateOfBirthController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Chào bạn,',
              style: TextStyle(fontSize: 25.0),
            ),
            Text(
              'Họ và tên đầy đủ của bạn là?',
            ),
            _buildFullNameField(),
            Text(
              'Ngày sinh của bạn là?',
            ),
            _buildDateOfBirthField(),
            Spacer(),
            Container(
                padding: EdgeInsets.only(bottom: 20),
                alignment: Alignment.center,
                child: buildButton()),
          ],
        ),
      ),
    );
  }

  Widget _buildFullNameField() {
    return TextFormField(
      controller: _txtFullNameController,
      onChanged: (text) {
        //bloc.optSink.add(text);
      },
      cursorColor: Colors.green[500],
      autofocus: true,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).unselectedWidgetColor),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        hintText: 'Họ và tên',
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
            borderSide: BorderSide(color: Colors.grey[200])),
      ),
    );
  }

  Widget _buildDateOfBirthField() {
    return TextFormField(
      controller: _txtDateOfBirthController,
      onChanged: (text) {
        ///bloc.optSink.add(text);
      },
      cursorColor: Colors.green[500],
      autofocus: true,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).unselectedWidgetColor),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        hintText: 'DD/MM/YYYY',
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(5.0),
            ),
            borderSide: BorderSide(color: Colors.grey[200])),
      ),
    );
  }

  Widget buildButton() {
    return StreamProvider<bool>.value(
      initialData: true,
      //value: bloc.btnStream,
      child: Consumer<bool>(
        builder: (context, enable, child) => FlatButton(
          height: 60,
          minWidth: double.infinity,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: enable ? () {} : null,
          child: Text(
            'Hoàn tất',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: Colors.orange,
        ),
      ),
    );
  }
}
