#coding:utf-8
from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
from django.http import StreamingHttpResponse
import time
import requests
import json

# Create your views here.
@csrf_exempt
def getRankList(request):
	rankList = []
	rankList.append({
		'name':'原创风云榜·新书',
		'path':'https://www.qidian.com/rank/yuepiao',
		})
	rankList.append({
		'name':'24小时热销榜',
		'path':'https://www.qidian.com/rank/hotsales',
		})
	rankList.append({
		'name':'新锐会员周点击榜',
		'path':'https://www.qidian.com/rank/newvipclick',
		})
	rankList.append({
		'name':'推荐票榜',
		'path':'https://www.qidian.com/rank/recom',
		})
	rankList.append({
		'name':'收藏榜',
		'path':'https://www.qidian.com/rank/collect',
		})
	rankList.append({
		'name':'完本榜',
		'path':'https://www.qidian.com/rank/fin',
		})
	rankList.append({
		'name':'签约作家新书榜',
		'path':'https://www.qidian.com/rank/signnewbook',
		})
	rankList.append({
		'name':'公众作家新书榜',
		'path':'https://www.qidian.com/rank/pubnewbook',
		})
	typeList = []
	typeList.append({
		'name':'全部分类',
		'chn':'-1',
		})
	typeList.append({
		'name':'玄幻',
		'chn':'21',
		})
	typeList.append({
		'name':'奇幻',
		'chn':'1',
		})
	typeList.append({
		'name':'武侠',
		'chn':'2',
		})
	typeList.append({
		'name':'仙侠',
		'chn':'22',
		})
	typeList.append({
		'name':'都市',
		'chn':'4',
		})
	typeList.append({
		'name':'现实',
		'chn':'15',
		})
	typeList.append({
		'name':'军事',
		'chn':'6',
		})
	typeList.append({
		'name':'历史',
		'chn':'5',
		})
	typeList.append({
		'name':'游戏',
		'chn':'7',
		})
	typeList.append({
		'name':'体育',
		'chn':'8',
		})
	typeList.append({
		'name':'科幻',
		'chn':'9',
		})
	typeList.append({
		'name':'灵异',
		'chn':'10',
		})
	typeList.append({
		'name':'二次元',
		'chn':'12',
		})
	titleRegex = r'''<div class="book-mid-info">.*?<h4><a href="//book.qidian.com/info/[\s\S]*?>(.*?)</a>'''
	coverRegex = r'<a href="//book.qidian.com/info/.*?" target="_blank" data-eid="qd_C39" data-bid=".*?"><img src="//([\s\S]*?)"></a>';
	introRegex = r'<p class="intro">(.*?)</p>';
	lastRegex = r'<p class="update"><a href=".*?" target="_blank" data-eid="qd_C43" data-bid=".*?" data-cid=".*?">(.*?)</a><em>&#183;</em><span>.*?</span>';
	lastDateRegex = r'<p class="update"><a href=".*?" target="_blank" data-eid="qd_C43" data-bid=".*?" data-cid=".*?">.*?</a><em>&#183;</em><span>(.*?)</span>';
	authorRegex = r'<img src=".*?"><a class="name" href=".*?" target="_blank" data-eid="qd_C41">([\s\S]*?)</a><em>';
	typeRegex = r'<div class="book-mid-info">.*?data-eid="qd_C42">(.*?)</a><em>|</em><span>$';
	linkRegex = r'<div class="book-img-box">.*?<a href="//(.*?)" target="_blank" data-eid="qd_C39" data-bid=".*?"><img src="//.*?"></a>.*?</div>';

	rankRegex = {
    "titleRegex":titleRegex,
    "coverRegex":coverRegex,
    "introRegex":introRegex,
    "lastRegex":lastRegex,
    "lastDateRegex":lastDateRegex,
    "authorRegex":authorRegex,
    "typeRegex":typeRegex,
    "linkRegex":linkRegex,
    }
	qiDianIndexRegex = {
    "shortIntro":r'<p class="intro">(.*?)</p>'
	}
	searchData={}
	searchData['searchUrl'] = 'https://www.biqudu.com/searchbook.php?keyword=';
	searchTitleRegex = r'<dl><dt><span>.*?</span><ahref=".*?">(.*?)</a></dt><dd>.*?</dd></dl>';
	searchCoverRegex = r'<ahref=".*?"><imgsrc="(.*?)"alt=".*?"width="120"height="150"/>';
	searchAuthorRegex = r'<dl><dt><span>(.*?)</span><ahref=".*?">.*?</a></dt><dd>.*?</dd></dl>';
	searchLinkRegex = r'<dl><dt><span>.*?</span><ahref="(.*?)">.*?</a></dt><dd>.*?</dd></dl>';
	searchIntroRegex = r'<dd>(.*?)</dd>';
	searchRegex = {
	'titleRegex':searchTitleRegex,
	'coverRegex':searchCoverRegex,
	'authorRegex':searchAuthorRegex,
	'linkRegex':searchLinkRegex,
	'introRegex':searchIntroRegex,
	};
	searchData['regex'] = searchRegex;
	searchData['domain'] = "https://www.biqudu.com/";


	menuData = {};
	menuChapterRegex = r'<dd><ahref=".*?">(.*?)</a></dd>';
	menuLinkRegex = r'<dd><ahref="(.*?)">.*?</a></dd>';
	menuRegex = {
	"chapterRegex":menuChapterRegex,
	"linkRegex":menuLinkRegex,
	};
	menuData['regex'] = menuRegex;


	readData = {};
	readContentRegex = r'<div id="content">(.*?)</div>';
	readRegex = {
	"contentRegex":readContentRegex,
	};
	readData['regex'] = readRegex;
	return JsonResponse({'code':100,'regexVersion':1,'rankList':rankList,'typeList':typeList,"rankRegex":rankRegex,"qiDianIndexRegex":qiDianIndexRegex,
		"searchData":searchData,"menuData":menuData,"readData":readData})

@csrf_exempt
def checkVersion(request):
	if request.method == 'GET':
		v = request.GET.get("v",1.0)
	else:
		v = request.POST.get("v",1.0)
	v = float(v)
	print v;
	if v<1.0:
		return JsonResponse({"code":100,"description":"快去下载新版本","link":"https://baidu.com"})
	else:
		return JsonResponse({"code":300})




