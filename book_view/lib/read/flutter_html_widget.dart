library flutter_html_widget;

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:html/parser.dart' as html show parse;
import 'package:html/dom.dart' as html;

import 'package:url_launcher/url_launcher.dart';

class HtmlWidget extends StatelessWidget {
  const HtmlWidget({Key key, this.html}) : super(key: key);

  final String html;

  @override
  Widget build(BuildContext context) {
    // wipe out <i> <b> <span>
    final strippedHtml = html.replaceAll(new RegExp("<\/*(i|b|span)>"), '');
    return (new _HtmlParser(context)).parseFromStr(strippedHtml);
  }
}

// legacy from wiki-flutter
// TODO polish

class _HtmlParser {
  final BuildContext context;

  // TODO wiki-flutter legacy
  final Map appContext;

  final TextTheme textTheme;

  _HtmlParser(this.context, {this.appContext: const {}})
      : textTheme = Theme.of(context).textTheme {}

  List<Widget> _widgets = [];
  List<TextSpan> _currentTextSpans = [];

  Widget parseFromElement(html.Element element) {
    // print('*** parsing html...');

    _parseNode(element);
    _tryCloseCurrentTextSpan();

    return new Wrap(children: _widgets);
  }

  Widget parseFromStr(String htmlStr) {
    // print('*** parsing html...');

    final html.Node body = html.parse(htmlStr).body;

    _parseNode(body);
    _tryCloseCurrentTextSpan();
    return new ListView(children:_widgets,);
//    return new Wrap(children: _widgets);
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
      case 'img':
        // NOTE assuming img with width=height=11 as inline image icon

        final isInlineIcon = (element.attributes['height'] == "11" &&
            element.attributes['width'] == "11");
        final imgSrc = 'https:' + element.attributes['src'];

        if (isInlineIcon) {
          // TODO REPLY ON VENDOR
          // flutter currently dont support inline image/icon in textspan
          // final icon = new ImageIcon(new NetworkImage(imgSrc));
        } else {
          _tryCloseCurrentTextSpan();

          final img = new Image.network(imgSrc);
          _widgets.add(new Container(
              padding: const EdgeInsets.all(8.0),
              alignment: FractionalOffset.center,
              child: img));
        }

        return;
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
      case 'a':
        // TODO PRIMARY OBJECT
        // TODO NEED IMPROVEMENT

        // print(element.attributes['href']);

        // if contains only one text node
        if (element.hasContent() &&
            (element.nodes.length == 1) &&
            (element.firstChild.nodeType == html.Node.TEXT_NODE)) {
          final text = element.text;
          final href = element.attributes['href'];

          _appendToCurrentTextSpans(
              _textLink(context: context, text: text, href: href));

          return;
        }

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
                style: textTheme.body1,
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

  // TODO
  // void _appendToCurrentWidgets(Widget w) {}

  // void _debugPrintWidgets() {
  //   List<String> lines = [' === *** current widgets *** ==='];

  //   for (var w in _widgets) {
  //     lines.add(w.toString());
  //     if (w.runtimeType == Wrap){
  //       lines.add((w as Wrap).children.toString());
  //     }
  //   }

  //   lines.add(' === *** current widges end *** ===');

  //   print(lines.join('\n'));
  // }

}

TextSpan _textLink({BuildContext context, String text, String href}) {
  // static const style = const TextStyle(color: Colors.blue, decoration: TextDecoration.underline);
  final linkStyle =
      Theme.of(context).textTheme.body1.copyWith(color: Colors.blue);
  // static final suffixIconString = new String.fromCharCode(Icons.open_in_browser.codePoint);
  // static final suffixIconStyle = linkStyle.apply(fontFamily: 'MaterialIcons');

  TextSpan _textSpanForInternalEntryLink(String targetEntryTitle) {
    final recognizer = new TapGestureRecognizer()
      ..onTap = () {
        Navigator.pushNamed(context, "/entries/$targetEntryTitle");
      };

    return new TextSpan(text: text, style: linkStyle, recognizer: recognizer);
  }

  TextSpan _textSpanForExternalLink() {
    final recognizer = new TapGestureRecognizer()
      ..onTap = () {
        launch(href);
      };

    return new TextSpan(text: text, style: linkStyle, recognizer: recognizer);
  }

  // internal link to another entry
  // <a href=\"/wiki/Political_union\" title=\"Political union\">political</a> and <a href=\"/wiki/Economic_union\" title=\"Economic union\">economic union</a>
  if (href.startsWith('/wiki/')) {
    final String targetEntryTiele = href.replaceAll('/wiki/', '');
    return _textSpanForInternalEntryLink(targetEntryTiele);
  }

  // default as an external link
  return _textSpanForExternalLink();
}
