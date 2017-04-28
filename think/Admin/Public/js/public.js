//$(function () {
//    var layerIndex;
//    $(document).ajaxStart(function () {
//        layerIndex = layer.load(1, {
//            shade: [0.1, '#fff'] //0.1透明度的白色背景
//        });
//    });
//    $("[data-target='ajax']").click(function () {
//        var $obj = $(this);
//        var $form = $(this).closest("form");
//        var url = ($obj.data('url') != 'undefined') ? $obj.data('url') : $form.attr("action");
//        var params = $obj.closest("form").serialize();
//        $.ajax({
//            url: url,
//            type: "POST",
//            data: params,
//            dataType: "json",
//            success: function (data) {
//                if (data.status == 1) {
//                    layer.close(layerIndex);
//                    layer.msg('登录成功', {
//                        time: 500,
//                    }, function () {
//                        location.href = data.url;
//                    });
//                } else {
//                    layer.close(layerIndex);
//                    layer.msg(data.info, {
//                        time: 1000,
//                    });
//
//                }
//            }
//        })
//    });
//
//
//})