import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slider_with_interval/slider_with_interval.dart';

class SliderPage extends StatefulWidget {
  @override
  SliderPageState createState() => new SliderPageState();
}

class SliderPageState extends State<SliderPage> {
  List<double> spotList = [10, 30, 70];

  double videoLength = 100;

  /// 进度
  double progressValue = 0;

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);

    setTimer();
  }

  void setTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      progressValue += 0.5;
      print('$runtimeType  次数 tick ： ${timer.tick} \t $progressValue');
      setState(() {});
    });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double bgWidth = MediaQuery.of(context).size.width - 4;
    return Scaffold(
      appBar: AppBar(
        title: Text('Slide Page'),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Container()),
            Container(
              height: 10,
              width: bgWidth,
              margin: EdgeInsets.only(bottom: 120),
              child: _buildSlider(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _timer.cancel();
          progressValue = 0;
          setState(() {});
          setTimer();
        },
        child: Icon(Icons.settings_backup_restore, size: 15, color: Colors.white),
      ),
    );
  }

  Widget _buildSlider() {
    return SliderTheme(
      //自定义风格
      data: SliderTheme.of(context).copyWith(
        //选中区
        activeTrackColor: Color(0xffffc600),
        //非选中区
        inactiveTrackColor: Color(0xfff2f2f7).withOpacity(0.48),
        thumbColor: Color(0xffffc600),
        overlayShape: RoundSliderOverlayShape(
          //可继承SliderComponentShape自定义形状
          overlayRadius: 12, //滑块外圈大小
        ),
        thumbShape: RoundSliderThumbShape(
          //可继承SliderComponentShape自定义形状
          disabledThumbRadius: 12, //禁用是滑块大小
          enabledThumbRadius: 12, //滑块大小
        ),
        trackHeight: 10,
      ),
      child: IntervalSlider(
        value: progressValue,
        onChangeStart: _onChangeStartSlide,
        onChangeEnd: _onChangeEndSlide,
        onChanged: _onChanged,
        min: 0,
        max: videoLength,
      ),
    );
  }

  void _onChangeStartSlide(double value) {
    print('$runtimeType value --> $value');
  }

  void _onChangeEndSlide(double value) {
    print('$runtimeType value --> $value');
  }

  void _onChanged(double value) {
    print('$runtimeType value --> $value');
  }
}
