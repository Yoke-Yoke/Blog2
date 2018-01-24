<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta charset="utf-8"/>
    <title></title>
    <link href="/layui/css/layui.css" rel="stylesheet"/>
    <script src="/layui/layui.js"></script>
    <script
            src="https://code.jquery.com/jquery-3.2.1.min.js"
            integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
            crossorigin="anonymous"></script>
    <script src="/layui/layui.js"></script>
</head>
<body style="background-color:#eee;">
<div class="layui-form-item">
    <label class="layui-form-label">文章标题</label>
    <div class="layui-input-block">
        <input type="text" id="title" name="title" required lay-verify="required" placeholder="标题" autocomplete="off"
               class="layui-input">
    </div>
</div>
<!--<div class="layui-form-item">
    <label class="layui-form-label">选择框</label>
    <div class="layui-input-block">
        <select id="select" lay-verify="required">
        </select>
    </div>
</div>-->

<!--<div class="layui-form-item">
    <label class="layui-form-label">作者</label>
    <div class="layui-input-block">
        <input type="text" id="author" name="author" required lay-verify="required" placeholder="作者"
               autocomplete="off"
               class="layui-input">
    </div>
</div>-->
<div style="width:90%;margin-left:5%;margin-top:100px;background-color:#fff;">
    <textarea name="txt" id="txt" style="display:none;"></textarea>
</div>
<input type="button" value="提交文章" id="btn1" class="layui-btn" style="margin-left:5%;margin-top:20px;"/>
</body>
</html>
<script type="text/javascript">
    window.onload = function () {
//        $.ajax({
//            type: "GET",
//            url: "/column/list",
//            success: function (data) {
//
//                for (var i in data) {
//                    $("#select").append("<option value=" + data[i].id + ">Select" + data[i].name + "</option>");
//                }
//            }
//        });
        layui.use('layedit', function () {
            var layedit = layui.layedit;

            layedit.set({
                uploadImage: {
                    url: '/article/upload' //接口url
                    , type: 'post' //默认post
                    , size: 0
                }
            });

            var editIndex = layedit.build('txt', {
                height: 400
            });

            document.getElementById('btn1').onclick = function () {
//                alert(layedit.getContent(editIndex));
                var content = layedit.getContent(editIndex);
                var title = document.getElementById("title").value;
//                var authorName = document.getElementById("author").value;
                var columnId = $("select").val();  //获得下拉框的值
                $.ajax({
                    url: "/article/add/",
                    type: 'post',
                    dataType: 'json',
                    contentType: "application/json",
                    data: JSON.stringify({
//                        "authorName": authorName,
                        "title": title,
                        "content": content
                    }),
                    success: function (data) {
                        console.log(data);
                        if (data.code === 0) {
                            //关闭弹框
                            var index = parent.layer.getFrameIndex(Window.name);
                            parent.layer.close(index);
                            layer.msg("添加成功", {icon: 6});
                        } else {
                            layer.msg("添加失败", {icon: 5});
                        }
                    }
                });
            }
        });
    }
</script>