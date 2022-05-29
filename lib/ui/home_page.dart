import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:eventtaskadd/controller/task_controller.dart';
import 'package:eventtaskadd/services/theme_services.dart';
import 'package:eventtaskadd/ui/add_task_bar.dart';
import 'package:eventtaskadd/ui/theme.dart';
import 'package:eventtaskadd/ui/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


DateTime _selectedDate = DateTime.now();
final _taskController = Get.put(TaskController());

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: Column(
        children: [
          _addTaskbar(),
          _addDateBar(),
          _showTask(),
        ],
      ),
    );
  }
}

_showTask(){
  return Expanded(
    child: Obx((){
     return ListView.builder(
       itemCount: _taskController.taskList.length,

         itemBuilder: (_, context){
         print(_taskController.taskList.length);
           return Container(
             width: 100,
             height: 50,
             color: Colors.green,
             margin: const EdgeInsets.only(bottom: 10)
           );

     });
    }),
  );
}

_addDateBar() {
  return Container(
    margin: const EdgeInsets.only(top: 20, left: 20),
    child: DatePicker(
      DateTime.now(),
      height: 100,
      width: 80,
      initialSelectedDate: DateTime.now(),
      selectionColor: Color.fromARGB(255, 33, 54, 243),
      selectedTextColor: Colors.white,
      dateTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey)),
      dayTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey)),
      monthTextStyle: GoogleFonts.lato(
          textStyle: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey)),
      onDateChange: (date) {
        _selectedDate = date;
      },
    ),
  );
}

_addTaskbar() {
  return Container(
    margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text(
                "Today",
                style: HeadingStyle,
              )
            ],
          ),
        ),
        MyButton(label: "+Add Task ", onTap: () async {
          await Get.to(AddTaskPage());

        }
        )
      ],
    ),
  );
}

_appbar() {
  return AppBar(
    elevation: 0,
    leading: GestureDetector(
      onTap: () {
        ThemeServices().switchTheme();
      },
      child: Icon(
        Icons.nightlight_round,
        size: 30,
        color: Get.isDarkMode ? Colors.white : Colors.black,
      ),
    ),
    actions: [
      Icon(
        Icons.person,
        size: 30,
      ),
      SizedBox(
        width: 20,
      ),
    ],
  );
}
