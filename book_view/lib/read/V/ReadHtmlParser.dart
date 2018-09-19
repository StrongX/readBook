import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html show parse;
import 'package:html/dom.dart' as html;
import "package:pull_to_refresh/src/internals/refresh_physics.dart";
class ReadHtmlParser{
  List<Widget> _widgets;
  List<TextSpan> _currentTextSpans;
  TextStyle textStyle = TextStyle(color: Colors.black54,fontSize: 18.0);
  TextStyle titleStyle = TextStyle(color: Colors.black54,fontSize: 22.0);
  TextStyle tagStyle = TextStyle(color: Colors.black54,fontSize: 15.0);



  ListView getParseListFromStr(String htmlStr,ScrollController scroll,String chapterName) {
    // print('*** parsing html...');
    _widgets = [];
    _currentTextSpans = [];
    final html.Node body = html.parse(htmlStr).body;

    _parseNode(body);
    _tryCloseCurrentTextSpan();
    Widget titleLabel = Text(chapterName,style: titleStyle,textAlign: TextAlign.center,);
    _widgets.insert(0, titleLabel);
    Widget tag = Text("继续上拉查看下一章",style: tagStyle,textAlign: TextAlign.center,);
    _widgets.add(tag);

    ListView listView = ListView(children:_widgets,controller: scroll,physics: new RefreshScrollPhysics(enableOverScroll: true));
    return listView;
  }


  void _parseNode(html.Node node) {
    // print('--- _parseNode');
    // print(node.toString());
    switch (node.nodeType) {
      case html.Node.ELEMENT_NODE:
        _parseElement(node as html.Element);
        return;
      case html.Node.TEXT_NODE:
      // strip/trim
        final trimmedText = node.text;
        // NOTE if contains only `\n`s
        if (trimmedText.length == 0) {
          _tryCloseCurrentTextSpan();
          return;
        }

        _appendToCurrentTextSpans(trimmedText);
        return;
      default:
        break;
    }
  }

  void _parseElement(html.Element element) {
    // print('--- _parseElement');
    // print(element.toString());

    switch (element.localName) {
      case 'body':
      case 'p':
      case 'div':
      case 'br':
      case 'section':
      // traverse down the tree
        for (var subNode in element.nodes) {
          _parseNode(subNode);
        }

        _tryCloseCurrentTextSpan();

        return;
      case 'li':
      // TODO missing key features, treating just as div
        _tryCloseCurrentTextSpan();

        // traverse down the tree
        for (var subNode in element.nodes) {
          _parseNode(subNode);
        }

        return;
      case 'figure': // TODO
        _tryCloseCurrentTextSpan();

        // traverse down the tree
        for (var subNode in element.nodes) {
          _parseNode(subNode);
        }

        return;
    // TODO fig caption
      case 'table':
        _tryCloseCurrentTextSpan();

        // TODO

        return;
      case 'span':
      case 'i':
      case 'strong':
      // TODO PRIMARY OBJECT
      // TODO NEED IMPROVEMENT maybe a _currentTextStylesStack for nesting stacks

      // still traverse down the tree
        for (var subNode in element.nodes) {
          _parseNode(subNode);
        }

        return;
      default:
      // print('=== MET UNSUPPORTED TAG: ${element.localName}');

      // still traverse down the tree
        for (var subNode in element.nodes) {
          _parseNode(subNode);
        }

        return;
    }
  }

  void _tryCloseCurrentTextSpan() {
    // print('=== closingCurrentTextSpan ===' + _currentTextSpans.length.toString());

    if (_currentTextSpans.isEmpty) {
      return;
    }

    _widgets.add(new Container(
        padding: const EdgeInsets.all(8.0),
        child: new RichText(
            text: new TextSpan(
                style: textStyle,
                children: new List.from(_currentTextSpans)))));

    _currentTextSpans.clear();
  }

  void _appendToCurrentTextSpans(dynamic stringOrTextSpan) {
    // print('=== appending to _currentTextSpan: ' + textOrLink.toString());

    switch (stringOrTextSpan.runtimeType) {
      case String:
      // NOTE if the widget to be added, and the current last widget, are both Text, then we should append the text instead of widgets.
        if (_currentTextSpans.length > 0 &&
            _currentTextSpans.last.runtimeType == Text) {
          final String originalText = _currentTextSpans.last.text;
          final String mergedText = originalText + stringOrTextSpan;
          _currentTextSpans[_currentTextSpans.length - 1] =
          new TextSpan(text: mergedText);
        } else {
          _currentTextSpans.add(new TextSpan(text: stringOrTextSpan));
        }
        break;
      case TextSpan:
        _currentTextSpans.add(stringOrTextSpan);
        break;
      default:
        throw "dk how to append";
    }
  }

}