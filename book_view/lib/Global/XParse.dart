class XParse{
  static urlJoin(String url1,String url2){
    String url = url1+url2;
    url.replaceAll(RegExp("//"), "/");
    return url;
  }
}