import 'package:flutter/material.dart';
import 'dart:html';
//import 'dart:ui' as ui;
import 'dart:ui_web' as ui;

class Iframescreen extends StatefulWidget {
  const Iframescreen({super.key});

  //const Iframescreen({super.key});

  @override
  State<Iframescreen> createState() => _IframescreenState();
}

class _IframescreenState extends State<Iframescreen> {
  final IFrameElement _iFrameElement = IFrameElement();

  @override
  void initState() {
    //_iFrameElement.style.height = '50%';
    //_iFrameElement.style.width = '50%';
    _iFrameElement.src =
        'https://www.google.com/maps/d/embed?mid=1j4umU__ajTXQf6Pn9HXUu2lsQ27g69g&ehbc=2E312F&noprof=1';
    _iFrameElement.style.border = 'none';

    ui.platformViewRegistry
        .registerViewFactory('iframeElement', (int ViewId) => _iFrameElement);

    super.initState();
  }

  final Widget _iframeWidget = HtmlElementView(
    viewType: 'iframeElement',
    key: UniqueKey(),
  );

  @override
  Widget build(BuildContext context) {
    return _iframeWidget;
  }
}
