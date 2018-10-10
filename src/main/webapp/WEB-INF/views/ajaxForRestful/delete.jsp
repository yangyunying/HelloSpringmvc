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
<p class="loading" style="display: none;">
    <img src="img/loading.gif" align="absmiddle">努力加载中...
</p>
<form id="formEmps">
    <fieldset>
        <legend>用户信息</legend>
        <p>
            <label for="name">姓名：</label>
            <input name="name" id="name" type="text" required="required" maxlength="32"/>
        </p>
        <p>
            <label for="birthday">生日：</label>
            <input name="birthday" id="birthday" type="date" required="required" maxlength="8"/>
        </p>
        <p>
            <label for="address">地址：</label>
            <input name="address" id="address" type="text" required="required" maxlength="128"/>
        </p>
        <p>
            <label for="phone">电话：</label>
            <input name="phone" id="phone" type="text" required="required" maxlength="11"/>
        </p>
        <p>
            <input id="id" type="hidden" name="id" value=""/>
            <button type="button" id="btnSubmit">保存</button>
        </p>
    </fieldset>
</form>
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
        init: function () {
            $("#btnSubmit").click(app.save);
            $("#tabEmps").on("click", ".del", app.delete);
            this.binddata();
        },
        ajax: function (actionType, callback, path, data) {
            $.ajax({
                url: app.url + (path || ""),
                contentType: "application/json;charset=utf-8",
                data: JSON.stringify(data) || "{}",
                type: actionType || "get",
                dataType: "json",
                success: function (data) {
                    if (data && data.state == "success") {
                        app.info(data.message);
                    } else if (data && data.state == "error") {
                        app.info(data.message);
                    } else {
                        app.info(data);
                    }
                    if (callback) {
                        callback(data);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    app.info(textStatus + errorThrown);
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
            $("#tabEmps tr:gt(0)").remove();
            this.ajax("get", function (data) {
                $.each(data.data, function (index, emp) {
                    var tr = $("<tr/>").data("emp", emp).appendTo("#tabEmps");
                    $("<td/>").text(emp.id).appendTo(tr);
                    $("<td/>").text(emp.name).appendTo(tr);
                    $("<td/>").text(emp.birthday).appendTo(tr);
                    $("<td/>").text(emp.address).appendTo(tr);
                    $("<td/>").text(emp.phone).appendTo(tr);
                    $("<td/>").html("<a class='del' href='#'>删除</a>").appendTo(tr);
                });
            });
        },
        getEmp: function () {
            return {
                "id": $("#id").val(),
                "name": $("#name").val(),
                "birthday": $("#birthday").val(),
                "address": $("#address").val(),
                "phone": $("#phone").val()
            };
        },
        save: function () {
            var emp = app.getEmp();
            if (emp.id) {
                app.update(emp);
            } else {
                app.add(emp);
            }
        },
        add: function (emp) {
            app.ajax("POST", function (data) {
                app.binddata();
            }, "", emp);
        },
        update: function (emp) {
            app.ajax("Put", function (data) {
                app.binddata();
            }, "", emp);
        },
        delete: function () {
            if (confirm("删除吗？")) {
                var tr = $(this).closest("tr");
                var emp = tr.data("emp");
                app.ajax("DELETE", function (data) {
                    tr.remove();
                }, "/" + emp.id);
            }
        },
        info: function (msg) {
            $(".message")[0].innerHTML += msg + "<br/>";
        }
    };

    app.init();
</script>
</body>
</html>