import 'package:flutter/material.dart';

import '../GINUE_Best/GINUE_Best.dart';
import '../GINUE_Posting/GINUE_Posting.dart';


class GINUE_Home extends StatefulWidget {
  GINUE_Home({Key? key}) : super(key: key);

  @override
  State<GINUE_Home> createState() => _GINUE_HomeState();
}

class _GINUE_HomeState extends State<GINUE_Home> with TickerProviderStateMixin {

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 2,
      vsync: this,  //vsync에 this 형태로 전달해야 애니메이션이 정상 처리됨
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
              width: MediaQuery.of(context).size.width-50,
              child: TabBar(
                tabs: [
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      '전체 글',
                    ),
                  ),
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Text(
                      '인기 글',
                    ),
                  ),
                ],
                indicator: BoxDecoration(
                    color: Colors.red[400],
                    borderRadius: BorderRadius.circular(15)
                ),
                labelColor: Colors.white,
                labelStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                unselectedLabelColor: Colors.black,
                unselectedLabelStyle: TextStyle(fontSize: 18,),
                controller: _tabController,
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  GINUE_Posting(),
                  GINUE_Best()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}