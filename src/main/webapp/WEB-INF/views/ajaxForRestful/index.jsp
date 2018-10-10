<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>Title</title>
</head>
<body>
<h2>员工管理</h2>
<table border="1" width="100%" id="tabEmps">
    <tr>
        <th>编号</th>
        <th>姓名</th>
        <th>生日</th>
        <th>地址</th>
        <th>电话</th>
        <th>操作</th>
    </tr>
</table>
<p>

</p>
<p class="loading" style="display: none;">
    <img src="img/loading.gif" align="absmiddle">努力加载中...
</p>
<p class="message">

</p>
<script src="js/jquery-1.11.3.min.js"></script>
<script>
    //    var data = {
    //        "state": "success",
    //        "data": {"id": 1, "name": "张学友", "birthday": -41500800000, "address": "中国香港", "phone": "18989890098"},
    //        "message": "获得数据成功！"
    //    }
    var app = {
        url: "http://localhost:8080/mvc08/emps",
        init:function(){
            this.binddata();
        },
        ajax: function (actionType, callback, path, data) {
            $.ajax({
                url: app.url + (path||""),
                contentType: "application/json;charset=utf-8",
                data: data || {},
                type: actionType||"get",
                dataType: "json",
                success: function (data) {
                    if(data&&data.state=="success"){
                        app.info(data.message);
                    }else if(data&&data.state=="error"){
                        app.info(data.message);
                    }else{
                        app.info(data);
                    }
                    if(callback){
                        callback(data);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    info(textStatus+errorThrown);
                },
                beforeSend: function () {
                    $(".loading").show(200);
                }
                ,
                complete: function () {
                    $(".loading").hide(200);
                }
            })
            ;
        },
        binddata: function () {
            this.ajax("get",function(data){
                $.each(data.data,function(index,emp){
                    var tr=$("<tr/>").appendTo("#tabEmps");
                    $("<td/>").text(emp.id).appendTo(tr);
                    $("<td/>").text(emp.name).appendTo(tr);
                    $("<td/>").text(emp.birthday).appendTo(tr);
                    $("<td/>").text(emp.address).appendTo(tr);
                    $("<td/>").text(emp.phone).appendTo(tr);
                    $("<td/>").html("<a>删除</a>").appendTo(tr);
                });
            });
        },
        info:function(msg){
            $(".message")[0].innerHTML+=msg+"<br/>";
        }
    };

    app.init();
</script>
</body>
</html>