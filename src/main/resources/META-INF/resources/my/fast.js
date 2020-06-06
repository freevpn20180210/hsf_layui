/**
 * 自定义js工具类
 * author:lyf
 * 20200605
 */

//格式化日期--fmt为显示格式
function dateFtt(fmt, date) { //author: meizz
    var o = {
        "y+": date.getMonth(),//年
        "M+": date.getMonth() + 1,//月
        "d+": date.getDate(), //日
        "H+": date.getHours(),//时
        "m+": date.getMinutes(),//分
        "s+": date.getSeconds(),//秒
        "q+": Math.floor((date.getMonth() + 3) / 3),//季
        "S": date.getMilliseconds()//毫秒
    };
    if (/(y+)/.test(fmt))
        fmt = fmt.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}

//检测是什么浏览器
function whatBrowser() {
    //取得浏览器的userAgent字符串
    var userAgent = navigator.userAgent;
    if (userAgent.indexOf("Opera") > -1) return "Opera"
    if (userAgent.indexOf("Firefox") > -1) return "Firefox";
    if (userAgent.indexOf("Chrome") > -1) return "Chrome";
    if (userAgent.indexOf("Safari") > -1) return "Safari";
    if (userAgent.indexOf("compatible") > -1 && userAgent.indexOf("MSIE") > -1 && !isOpera) return "IE";
}

//检测是PC访问还是手机访问
function isPC() {
    var userAgent = navigator.userAgent;
    var Agents = ["Android", "iPhone", "SymbianOS", "Windows Phone", "iPad", "iPod"];
    var flag = true;
    for (var v = 0; v < Agents.length; v++) {
        if (userAgent.indexOf(Agents[v]) > 0) {
            flag = false;
            break;
        }
    }
    return flag;
}

//判断json数组是否包含某json对象
Array.prototype.indexOfJson = function (v) {
    return JSON.stringify(this).indexOf(JSON.stringify(v)) !== -1;
}

//设置key,把对象转成json字符串并存入localStorage,//localStorage值只接受字符串
function setLocalStorage(key, val) {
    window.localStorage.setItem(key, JSON.stringify(val));
}

//通过key,把存入localStorage的json符串转成对象
function getLocalStorage(key) {
    return JSON.parse(window.localStorage.getItem(key));
}

/***********************************************layui自定义封装start**************************************************************/

//layui增删改查--基本顶部按钮的实现
function layuiBaseTopBtn($, table, searches, DEL, TOSAVEUPDATE) {
    //顶部按钮
    var active = {
        //搜索
        search: function () {
            //搜索条件
            var keywords = []
            searches.each((i, v) => {
                keywords.push(v.value)
            })
            //重载表格
            table.reload('table', {
                page: {
                    curr: 1 //重新从第 1 页开始
                }
                , where: {
                    keywords: keywords.toString(),
                }
            })
            searches[0].focus()
        },
        //清空
        clear: function () {
            searches.each((i, v) => {
                v.value = ''
            })
            //重载表格
            table.reload('table', {
                page: {
                    curr: 1 //重新从第 1 页开始
                }
                , where: {
                    keywords: '',
                }
            })
            searches[0].focus()
        },
        //批量删除
        delAll: function () {
            //得到选中的数据,是一个json数组
            var checkData = table.checkStatus('table').data;
            if (checkData.length === 0) {
                return layer.msg('请选择数据');
            }

            var ids = []
            $.each(checkData, function (i, v) {
                ids.push(v.id)
            })
            layer.confirm('确定删除吗？', function (index) {
                $.post(DEL, {ids: ids.toString()}, function (rs) {
                    if (rs.ok) {
                        layer.msg('已删除');
                        table.reload('table');
                        searches[0].focus()
                    }
                })
            })
        },
        save: function () {
            var index = layer.open({
                type: 2,
                title: '添加',
                content: TOSAVEUPDATE,
                btn: ['确定', '取消'],
                yes: function (index, layero) {
                    //找到iframe里的提交按钮并点击提交
                    var submit = layero.find('iframe').contents().find("#save");
                    submit.click();
                    $('#search0').focus()
                }
            })
            //打开就最大化
            layer.full(index)
        },
    }
    return active
}

//layui增删改查--基本顶部按钮的实现--批量删除完会刷新页面
function layuiBaseTopBtn_reload($, table, searches, DEL, TOSAVEUPDATE) {
    //顶部按钮
    var active = {
        //搜索
        search: function () {
            //搜索条件
            var keywords = []
            searches.each((i, v) => {
                keywords.push(v.value)
            })
            //重载表格
            table.reload('table', {
                page: {
                    curr: 1 //重新从第 1 页开始
                }
                , where: {
                    keywords: keywords.toString(),
                }
            })
            searches[0].focus()
        },
        //清空
        clear: function () {
            searches.each((i, v) => {
                v.value = ''
            })
            //重载表格
            table.reload('table', {
                page: {
                    curr: 1 //重新从第 1 页开始
                }
                , where: {
                    keywords: '',
                }
            })
            searches[0].focus()
        },
        //批量删除
        delAll: function () {
            //得到选中的数据,是一个json数组
            var checkData = table.checkStatus('table').data;
            if (checkData.length === 0) {
                return layer.msg('请选择数据');
            }

            var ids = []
            $.each(checkData, function (i, v) {
                ids.push(v.id)
            })
            layer.confirm('确定删除吗？', function (index) {
                $.post(DEL, {ids: ids.toString()}, function (rs) {
                    if (rs.ok) {
                        layer.msg('已删除');
                        // table.reload('table');
                        // searches[0].focus()
                        location.reload()
                    }
                })
            })
        },
        save: function () {
            var index = layer.open({
                type: 2,
                title: '添加',
                content: TOSAVEUPDATE,
                btn: ['确定', '取消'],
                yes: function (index, layero) {
                    //找到iframe里的提交按钮并点击提交
                    var submit = layero.find('iframe').contents().find("#save");
                    submit.click();
                    $('#search0').focus()
                }
            })
            //打开就最大化
            layer.full(index)
        },
    }
    return active
}

//layui增删改查--基本事件按钮的实现
function layuiBaseEvent($, table, searches, obj, DEL, TOSAVEUPDATE) {
    var data = obj.data;
    //单个删除
    if (obj.event === 'del') {
        layer.confirm('真的删除么', function (index) {
            $.post(DEL, {ids: data.id}, function (rs) {
                if (rs.ok) {
                    layer.msg('已删除');
                    table.reload('table');
                    searches[0].focus()
                }
            })
        })
    }
    //单个更新
    if (obj.event === 'update') {
        var index = layer.open({
            type: 2,
            title: '更新',
            content: TOSAVEUPDATE + data.id,
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                //找到iframe里的提交按钮并点击提交
                var submit = layero.find('iframe').contents().find("#update");
                submit.click();
                searches[0].focus()
            }
        })
        //打开就最大化
        layer.full(index)
    }
}

//layui增删改查--基本事件按钮的实现--单个删除完会刷新页面
function layuiBaseEvent_reload($, table, searches, obj, DEL, TOSAVEUPDATE) {
    var data = obj.data;
    //单个删除
    if (obj.event === 'del') {
        layer.confirm('真的删除么', function (index) {
            $.post(DEL, {ids: data.id}, function (rs) {
                if (rs.ok) {
                    layer.msg('已删除');
                    // table.reload('table');
                    // searches[0].focus()
                    location.reload()
                }
            })
        })
    }
    //单个更新
    if (obj.event === 'update') {
        var index = layer.open({
            type: 2,
            title: '更新',
            content: TOSAVEUPDATE + data.id,
            btn: ['确定', '取消'],
            yes: function (index, layero) {
                //找到iframe里的提交按钮并点击提交
                var submit = layero.find('iframe').contents().find("#update");
                submit.click();
                searches[0].focus()
            }
        })
        //打开就最大化
        layer.full(index)
    }
}

//layui增删改查--弹出一个新窗口--普通提交
function layuiBaseNewWindow_normalSubmit(title, url, searches) {
    var index = layer.open({
        type: 2,
        title: title,
        content: url,
        area: ['600px', '600px'],
        btn: ['确定', '取消'],
        yes: function (index, layero) {
            //找到iframe里的提交按钮并点击提交
            var submit = layero.find('iframe').contents().find("#submit");
            submit.click();
            searches[0].focus()
        }
    })
    return index
}

//layui--弹出一个新窗口--普通提交
function layuiNewWindow_normalSubmit(title, url, width, height) {
    var index = layer.open({
        type: 2,
        title: title,
        content: url,
        area: [width, height],
        btn: ['确定', '取消'],
        yes: function (index, layero) {
            //找到iframe里的提交按钮并点击提交
            var submit = layero.find('iframe').contents().find("#submit");
            submit.click();
        }
    })
    return index
}

//layui增删改查--公共js模板1
function layuiPublic1($, searches) {
    //移至焦点,回车搜索
    searches[0].focus()
    searches.each((i, v) => {
        //如果不是最后一个搜索框,回车就跳转就下一个搜索框
        if (i != searches.length - 1) {
            $(searches[i]).keypress(e => {
                if (e.keyCode == 13) {
                    $(searches[i + 1]).focus()
                }
            })
        } else {//否则就点击搜索按钮
            $(searches[i]).keypress(e => {
                if (e.keyCode == 13) {
                    $('[data-type=search]').click()
                }
            })
        }
    })

    //单击一行就选中该行的复选框并设置该行的背景颜色
    //先获取一行
    $(document).on("click", "div.layui-table-body>table.layui-table>tbody>tr", function () {
        //再获取该行的复选框
        var checkbox = $(this).find("td>div.laytable-cell-checkbox>div.layui-unselect.layui-form-checkbox");
        //不再派发事件,阻止事件冒泡
        checkbox.click(e => {
            e.stopPropagation()
        })
        //点击复选框
        checkbox.click();
        //选中时会添加.layui-form-checked样式
        var isClick = $(this).find("td>div.laytable-cell-checkbox>div.layui-unselect.layui-form-checkbox.layui-form-checked")
        if (isClick.length > 0) {
            //选中就设置该行的背景颜色
            $(this).css("background-color", "#F2F2F2");
        } else {
            //取消选中就还原该行的背景颜色
            $(this).css("background-color", "#FFFFFF")
        }
    })
}

/**
 * layui上传图片
 * @param $ jquery
 * @upload upload layui的上传组件
 * @param element layui的element组件
 * @param btn 上传按钮的jquery id选择器,如#upload
 * @param url 上传接口
 * @param imgTxt 预读图片的img的jquery选择器文本
 * @param inputTxt 保存图片地址到数据库的input的jquery选择器文本
 * @param processTxt 进度条的jquery选择器文本
 */
function layuiUploadPic($, upload, element, btn, url, imgTxt, inputTxt, processTxt) {
    //上传loading
    var load;
    upload.render({
        elem: btn,
        url: url,
        choose: function (obj) {//选择完文件后的回调
            //预读本地文件，如果是多文件，则会遍历。(不支持ie8/9)
            //result--文件base64编码，比如图片
            obj.preview(function (index, file, result) {
                var img = $(imgTxt)[0]
                img.src = result
                img.alt = file.name
            })
        },
        before: function (obj) { //文件上传前的回调,obj同choose
            load = layer.load() //上传loading
            element.progress('progress', 0 + '%')
        },
        done: function (rs) {//上传完毕的回调
            layer.close(load)
            if (rs.ok) {
                $(inputTxt).val(rs.pic)
            }
        },
        error: function () {//请求异常的回调
            layer.close(load)
            layer.msg("上传出错，请重试")
        },
        progress: function (n, elem) {//上传进度的回调
            $(processTxt).show()
            element.progress('progress', n + '%');
        },
        auto: true,//选择文件后自动上传
        // bindAction: '#save',//点了按钮才上传
        accept: 'images',//文件类别
        exts: 'jpg|png|gif|bmp|jpeg'//文件具体类型
    })
}

/**
 * layui上传文件
 * @param $ jquery
 * @param table layui的表格组件
 * @param upload layui的上传组件
 * @param element layui的element组件
 * @param btn 上传按钮的jquery id选择器,如#upload
 * @param url 上传接口
 * @param processTxt 进度条的jquery选择器文本
 */
function layuiUploadFile($, table, upload, element, btn, url, processTxt, getLoginUserPanInfo) {
    //上传loading
    var load;
    upload.render({
        elem: btn,
        url: url,
        choose: function (obj) {//选择完文件后的回调
            //预读本地文件，如果是多文件，则会遍历。(不支持ie8/9)
            //result--文件base64编码，比如图片
            obj.preview(function (index, file, result) {

            })
        },
        before: function (obj) { //文件上传前的回调,obj同choose
            load = layer.load() //上传loading
            element.progress('progress', 0 + '%')
        },
        done: function (rs) {//上传完毕的回调
            layer.close(load)
            if (rs.ok) {
                layer.msg('文件上传成功')
                // table.reload('table'); //重载表格
                location.reload()
            } else {
                layer.msg(rs.msg)
                element.progress('progress', 0 + '%')
            }
        },
        error: function () {//请求异常的回调
            layer.close(load)
            layer.msg("上传出错，请重试")
        },
        progress: function (n, elem) {//上传进度的回调
            $(processTxt).show()
            element.progress('progress', n + '%');
        },
        auto: true,//选择文件后自动上传
        // bindAction: '#save',//点了按钮才上传
        accept: 'file',//文件类别
        //exts: ''//文件具体类型
    })
}

/**
 * layui-最基本的树形组件
 * @param $ jquery
 * @param tree layui的树形组件
 * @param form layui的表单组件
 * @param treeUrl 生成树的url
 * @param checkUrl 返回id数组的url,设置节点勾选
 * @param addUrl 将勾选的节点进行提交的url
 * @param elemTxt 树形组件的jquery的id选择器文本
 * @param paramId 发送给后端的参数
 * @param addIds 后端形参名
 */
function layuiBaseTree($, tree, form, treeUrl, checkUrl, addUrl, elemTxt, paramId, addIds) {
    $.post(treeUrl, function (rs) {
        //渲染树
        tree.render(
            {
                id: elemTxt,
                elem: '#' + elemTxt,
                data: rs,
                showCheckbox: true,
            }
        )
        //返回id数组,设置节点勾选(使用场景:如根据用户id获取角色id的集合)
        $.post(checkUrl,
            {
                id: paramId
            }, function (rs) {
                //id相同则选中节点,rs为id数组
                tree.setChecked(elemTxt, rs)
                //将勾选的节点进行提交(使用场景: 如给用户添加角色）
                //监听提交
                form.on('submit(submit)', function (data) {
                    //获取提交的字段
                    var field = data.field;
                    //勾选的id数组
                    var ids = []
                    $.each(field, function (i, v) {
                        //减0是为了返回number类型而不是string
                        ids.push(v - 0)
                    })
                    $.ajax(
                        {
                            type: 'post',
                            url: addUrl,
                            data: {id: paramId, [addIds]: ids.toString()},
                            success: function (rs) {
                                if (rs.ok) {
                                    parent.layui.table.reload('table'); //重载表格
                                    var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
                                    parent.layer.close(index); //再执行关闭
                                } else {
                                    layer.msg(rs.msg)
                                }
                            }
                        }
                    )
                })
            })
    })
}

/***********************************************layui自定义封装end**************************************************************/
