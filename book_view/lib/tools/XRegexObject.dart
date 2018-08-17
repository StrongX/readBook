library XRegexObject;




class XRegexObject {

  static RegExp rankListRegex = new RegExp(r'<div class="rank-list-row cf mb20">[\s\S]*?<div class="rank-list">[\s\S]*?</a>', multiLine: false, caseSensitive: false);
  static RegExp bRegex = new RegExp(r'<b>[\s\S]*?</b>', multiLine: false, caseSensitive: false);
  static RegExp headRegex = new RegExp(r'<head>[\s\S]*?</head>', multiLine: false, caseSensitive: false);
  static RegExp titleRegex = new RegExp(r'<title>(.*)</Title>', multiLine: true, caseSensitive: false);
  static RegExp dateRegex = new RegExp(r'(?:[0-3]?\d(?:st|nd|rd|th)?\s+(?:of\s+)?(?:january|jan\.?|february|feb\.?|march|mar\.?|april|apr\.?|may|june|jun\.?|july|jul\.?|august|aug\.?|september|sep\.?|october|oct\.?|november|nov\.?|december|dec\.?)|(?:january|jan\.?|february|feb\.?|march|mar\.?|april|apr\.?|may|june|jun\.?|july|jul\.?|august|aug\.?|september|sep\.?|october|oct\.?|november|nov\.?|december|dec\.?)\s+[0-3]?\d(?:st|nd|rd|th)?)(?:\,)?\s*(?:\d{4})?|[0-3]?\d[-/][0-3]?\d[-/]\d{2,4}', multiLine: true, caseSensitive: false);
  static RegExp timeRegex = new RegExp(r'((0?[0-9]|1[0-2]):[0-5][0-9](am|pm)|([01]?[0-9]|2[0-3]):[0-5][0-9])', multiLine: true, caseSensitive: false);
  static RegExp phoneRegex = new RegExp(r'(\d?[^\s\w]*(?:\(?\d{3}\)?\W*)?\d{3}\W*\d{4})', multiLine: true, caseSensitive: false);
  static RegExp linkRegex = new RegExp(r'''((?:https?:\/\/|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}\/)(?:[^\s()<>]+|\((?:[^\s()<>]+|(?:\([^\s()<>]+\)))*\))+(?:\((?:[^\s()<>]+|(?:\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:\'".,<>?\xab\xbb\u201c\u201d\u2018\u2019]))''', multiLine: true, caseSensitive: false);
  static RegExp emailRegex = new RegExp(r'''([a-z0-9!#$%&'*+\/=?\^_`{|}~\-]+@([a-z0-9]+\.)+([a-z0-9]+))''', multiLine: true, caseSensitive: false);
  static RegExp IPv4Regex = new RegExp(r'\b((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b', multiLine: true, caseSensitive: false);
  static RegExp IPv6Regex = new RegExp(r'((([0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){6}:[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){5}:([0-9A-Fa-f]{1,4}:)?[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){4}:([0-9A-Fa-f]{1,4}:){0,2}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){3}:([0-9A-Fa-f]{1,4}:){0,3}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){2}:([0-9A-Fa-f]{1,4}:){0,4}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){6}((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))|(([0-9A-Fa-f]{1,4}:){0,5}:((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))|(::([0-9A-Fa-f]{1,4}:){0,5}((\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b)\.){3}(\b((25[0-5])|(1\d{2})|(2[0-4]\d)|(\d{1,2}))\b))|([0-9A-Fa-f]{1,4}::([0-9A-Fa-f]{1,4}:){0,5}[0-9A-Fa-f]{1,4})|(::([0-9A-Fa-f]{1,4}:){0,6}[0-9A-Fa-f]{1,4})|(([0-9A-Fa-f]{1,4}:){1,7}:))\b', multiLine: true, caseSensitive: false);
  static RegExp hexColorRegex = new RegExp(r'#(?:[0-9a-fA-F]{3}){1,2}\b', multiLine: true, caseSensitive: false);
  static RegExp acronymRegex = new RegExp(r'\b(([A-Z]\.)+|([A-Z]){2,})', multiLine: true);
  static RegExp moneyRegex = new RegExp(r'((^|\b)US?)?\$\s?[0-9]{1,3}((,[0-9]{3})+|([0-9]{3})+)?(\.[0-9]{1,2})?\b', multiLine: true, caseSensitive: false);
  static RegExp percentageRegex = new RegExp(r'(100(\.0+)?|[0-9]{1,2}(\.[0-9]+)?)%', multiLine: true, caseSensitive: false);
  static RegExp creditCardRegex = new RegExp(r'((?:(?:\d{4}[- ]){3}\d{4}|\d{16}))(?![\d])', multiLine: true, caseSensitive: false);
  static RegExp addressRegex = new RegExp(r'\d{1,5} [\w\s]{1,20}(?:(street|avenue|road|highway|square|trail|drive|court|parkway|boulevard)\b|(st|ave|rd|hwy|sq|trl|dr|ct|pkwy|blvd)\.)', multiLine: true, caseSensitive: false);

  String _text;
  List<String> get head => getHead();
  List<String> get b => getB();
  List<String> get rankList => getRankList();

  List<String> get title => getTitle();
  List<String> get dates => getDates();
  List<String> get times => getTimes();
  List<String> get phones => getPhones();
  List<String> get links => getLinks();
  List<String> get emails => getEmails();
  List<String> get IPv4 => getIPv4();
  List<String> get IPv6 => getIPv6();
  List<String> get hexColors => getHexColors();
  List<String> get acronyms => getAcronyms();
  List<String> get money => getMoney();
  List<String> get percentages => getPercentages();
  List<String> get creditCards => getCreditCards();
  List<String> get addresses => getAddresses();

  XRegexObject({String text}) {
    if (text != null)
      this._text = text;
  }

  List<String> _getMatches(RegExp r, String text) {
    List<String> matches = [];
    for (Match m in r.allMatches(text)) {
      matches.add(m.group(1));
    }
    return matches;
  }
  List<String> getListWithRegex(String regexStr) {
    RegExp regex = new RegExp(regexStr, multiLine: false, caseSensitive: false);
    return _getMatches(regex, this._text);
  }
  List<String> getRankList({String text}) {
    return _getMatches(rankListRegex, (text != null ? text : this._text));
  }
  List<String> getB({String text}) {
    return _getMatches(bRegex, (text != null ? text : this._text));
  }
  List<String> getHead({String text}) {
    return _getMatches(headRegex, (text != null ? text : this._text));
  }
  List<String> getTitle({String text}) {
    return _getMatches(titleRegex, (text != null ? text : this._text));
  }

  List<String> getTimes({String text}) {
    return _getMatches(timeRegex, (text != null ? text : this._text));
  }

  List<String> getPhones({String text}) {
    return _getMatches(phoneRegex, (text != null ? text : this._text));
  }

  List<String> getLinks({String text}) {
    return _getMatches(linkRegex, (text != null ? text : this._text));
  }

  List<String> getEmails({String text}) {
    return _getMatches(emailRegex, (text != null ? text : this._text));
  }

  List<String> getIPv4({String text}) {
    return _getMatches(IPv4Regex, (text != null ? text : this._text));
  }

  List<String> getIPv6({String text}) {
    return _getMatches(IPv6Regex, (text != null ? text : this._text));
  }

  List<String> getHexColors({String text}) {
    return _getMatches(hexColorRegex, (text != null ? text : this._text));
  }

  List<String> getAcronyms({String text}) {
    return _getMatches(acronymRegex, (text != null ? text : this._text));
  }

  List<String> getMoney({String text}) {
    return _getMatches(moneyRegex, (text != null ? text : this._text));
  }

  List<String> getPercentages({String text}) {
    return _getMatches(percentageRegex, (text != null ? text : this._text));
  }

  List<String> getCreditCards({String text}) {
    return _getMatches(creditCardRegex, (text != null ? text : this._text));
  }

  List<String> getAddresses({String text}) {
    return _getMatches(addressRegex, (text != null ? text : this._text));
  }

  List<String> getDates({String text}) {
    return _getMatches(dateRegex, (text != null ? text : this._text));
  }

}