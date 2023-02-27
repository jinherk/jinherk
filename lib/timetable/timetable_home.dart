import 'package:everynue/scheduler/scheduler_home.dart';
import 'package:flutter/material.dart';

class TimeTableHome extends StatefulWidget {
  const TimeTableHome({Key? key}) : super(key: key);

  @override
  State<TimeTableHome> createState() => _TimeTableHomeState();
}

class _TimeTableHomeState extends State<TimeTableHome>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextStyle textStyle = TextStyle(fontSize: 18);

  Widget renderTabButton(String title) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      child: Text(
        title,
      ),
    );
  }

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 50,
              child: TabBar(
                tabs: [
                  renderTabButton("시간표"),
                  renderTabButton("스케쥴러"),
                ],
                indicator: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.circular(15)),
                labelColor: Colors.white,
                labelStyle: textStyle.copyWith(fontWeight: FontWeight.bold),
                unselectedLabelColor: Colors.black,
                unselectedLabelStyle: textStyle,
                controller: _tabController,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Center(child: Text("여기는 시간표")),
                  SchedulerHome(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
