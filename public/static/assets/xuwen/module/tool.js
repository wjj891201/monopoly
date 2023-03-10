layui.define([], function (exports) {
    var MOD_NAME = 'tool';
    var tool = {
        loading: false,
        buttonLoading: false,
        //右侧iframe的方式打开页面
        side: function (url, width) {
            let that = this;
            if (that.loading == true) {
                return false;
            }
            that.loading = true;
            var sideWidth = window.innerWidth > 1280 ? '1200px' : '996px';
            if (width && width > 0) {
                sideWidth = width + 'px';
            }
            layer.open({
                type: 2,
                title: '',
                offset: ['0', '100%'],
                skin: 'layui-anim layui-anim-rl layui-layer-admin-right',
                closeBtn: 0,
                content: url,
                area: [sideWidth, '100%'],
                success: function (obj, index) {
                    var btn = '<div data-index="' + index + '" class="express-close" title="关闭">关闭</div>';
                    obj.append(btn);
                    $('body').addClass('right-open');
                    that.loading = false;
                    obj.on('click', '.express-close', function () {
                        let op_width = obj.outerWidth();
                        obj.animate({left: '+=' + op_width + 'px'}, 200, 'linear', function () {
                            $('body').removeClass('right-open');
                            layer.close(index);
                            if (layui.pageTable) {
                                layui.pageTable.resize();
                            }
                        })
                    })
                    $(window).resize(function () {
                        width = window.innerWidth > 1280 ? '1200' : '996';
                        obj.width(width);
                    })
                }
            })
        },
        //直接彈出
        smallForm: function (url, width, height, title) {

            if (!title) {
                title = '編輯'
            }

            let that = this;
            if (that.loading == true) {
                return false;
            }
            that.loading = true;

            if (width && width > 0) {
                width = width + 'px';
            } else {
                width = 400 + 'px'
            }

            if (height && height > 0) {
                height = height + 'px';
            } else {
                height = 400 + 'px'
            }

            layer.open({
                type: 2,
                title: title,
                content: url,
                area: [width, height],
                success: function (obj, index) {
                    that.loading = false;

                }
            })
        },
        //右侧ajax请求的方式打开页面
        open: function (url, width) {
            let that = this;
            if (that.loading == true) {
                return false;
            }
            that.loading = true;
            var sideWidth = window.innerWidth > 1280 ? '1200px' : '996px';
            if (width && width > 0) {
                sideWidth = width + 'px';
            }
            $.ajax({
                url: url,
                type: "GET",
                timeout: 10000,
                success: function (res) {
                    if (res['code'] && res['code'] > 0) {
                        layer.msg(res.msg);
                        return false;
                    }
                    var express = '<section id="expressLayer" class="express-box" style="width:' + sideWidth + '"><article id="articleLayer">' + res + '</article><div id="expressClose" class="express-close" title="关闭">关闭</div></section><div id="expressMask" class="express-mask"></div>';

                    $('body').append(express).addClass('right-open');
                    $('#expressMask').fadeIn(200);
                    $('#expressLayer').animate({'right': 0}, 200, 'linear', function () {
                        if (typeof (openInit) == "function") {
                            openInit();
                        }
                    });
                    that.loading = false;

                    //关闭
                    $('body').on('click', '.express-close', function () {
                        $('#expressMask').fadeOut(100);
                        $('body').removeClass('right-open');
                        let op_width = $('#expressLayer').outerWidth();
                        $('#expressLayer').animate({left: '+=' + op_width + 'px'}, 200, 'linear', function () {
                            $('#expressLayer').remove();
                            $('#expressMask').remove();
                            if (layui.pageTable) {
                                layui.pageTable.resize();
                            }
                        })
                    })
                    $(window).resize(function () {
                        width = window.innerWidth > 1280 ? '1200' : '996';
                        $('#expressLayer').width(width);
                    })

                }
                , error: function (xhr, textstatus, thrown) {
                    console.log('错误');
                },
                complete: function () {
                    that.loading = false;
                }
            });
        },
        load: function (url) {
            let that = this;
            if (that.loading == true) {
                return false;
            }
            that.loading = true;
            $.ajax({
                url: url,
                type: "GET",
                timeout: 10000,
                success: function (res) {
                    if (res['code'] && res['code'] > 0) {
                        layer.msg(res.msg);
                        return false;
                    }
                    $('#articleLayer').html(res);
                    openInit();
                }
                , error: function (xhr, textstatus, thrown) {
                    console.log('错误');
                },
                complete: function () {
                    that.loading = false;
                }
            });
        },
        page: function (url) {
            let that = this;
            if (that.loading == true) {
                return false;
            }
            that.loading = true;
            $.ajax({
                url: url,
                type: "GET",
                timeout: 10000,
                success: function (res) {
                    if (res['code'] && res['code'] > 0) {
                        layer.msg(res.msg);
                        return false;
                    }
                    $('#pageBox').html(res);
                    pageInit();
                }
                , error: function (xhr, textstatus, thrown) {
                    console.log('错误');
                },
                complete: function () {
                    that.loading = false;
                }
            });
        },
        close: function (delay) {
            //延迟关闭，一般是在编辑完页面数据后需要自动关闭页面用到
            if (delay && delay > 0) {
                setTimeout(function () {
                    $('.express-close').last().click();
                }, delay);
            } else {
                $('.express-close').last().click();
            }
            if (layui.pageTable) {
                layui.pageTable.reload();
            }


        },
        btnLoading: function (flag, attr) {
            const DISABLED = 'layui-btn-disabled';

            if (flag === undefined) {
                flag = true
            }

            if (attr === undefined) {
                attr = $(':button');
            }

            if (flag === true) {
                attr.addClass(DISABLED); // 添加样式
                attr.attr('disabled', 'disabled');  // 添加属性
                this.buttonLoading = true;
            } else {
                attr.removeClass(DISABLED);
                attr.removeAttr('disabled');
                this.buttonLoading = false;

            }
        },
        reqCallBack() {
            let that = this
            return function (e) {
                if (tool.buttonLoading) {
                    tool.btnLoading(false)
                }
                layer.msg(e.msg);
                if (e.code === 0) {
                    setTimeout(function () {
                        if (parent.layui.tool) {
                            parent.layui.tool.close(0);
                            if (parent.layui.layer.index > 0) {
                                parent.layui.layer.close(parent.layui.layer.index)
                            }
                            parent.location.reload();
                        } else {
                            location.reload();
                        }
                    }, 1000);
                }
            }
        },
        deleteCallBack(obj) {
            let callback = function (e) {
                layer.msg(e.msg);
                if (e.code == 0) {
                    obj.del();
                }
            }
            return callback;
        },
        renderUpload(btn, box) {
            if (btn == undefined || btn == '') {
                btn = 'upload_btn_thumb'
            }
            if (box == undefined || box == '') {
                box = 'upload_box_thumb'
            }
            layui.upload.render({
                elem: '#' + btn,
                url: '/admin/api/upload',
                done: function (res) {
                    //如果上传失败
                    if (res.code == 1) {
                        layer.msg('上传失败');
                        return false;
                    }
                    //上传成功
                    $('#' + box + ' input').attr('value', res.data.id);
                    $('#' + box + ' img').attr('src', res.data.filepath);
                }
            });
        },
        renderTinymce(id, height) {
            if (id == undefined || id == '') {
                id = 'container_content';
            }
            if (height == undefined) {
                height = 500;
            }
            var editor = layui.tinymce;
            var edit = editor.render({
                selector: "#" + id,
                height: height
            });
        },
        ajax: function (options, callback) {
            var format = 'json';
            if (options.hasOwnProperty('data')) {
                format = options.data.hasOwnProperty('format') ? options.data.format : 'json';
            }
            callback = callback || options.success;
            callback && delete options.success;
            var optsetting = {timeout: 10000};
            if (format == 'jsonp') {
                optsetting = {timeout: 10000, dataType: 'jsonp', jsonp: 'callback'}
            }
            var opts = $.extend({}, optsetting, {
                success: function (res) {
                    if (callback && typeof callback === 'function') {
                        callback(res);
                    }
                }
            }, options);
            $.ajax(opts);
        },
        get: function (url, data, callback) {
            this.ajax({
                url: url,
                type: "GET",
                data: data
            }, callback);
        },
        post: function (url, data, callback) {

            this.ajax({
                url: url,
                type: "POST",
                data: data
            }, callback);
        },
        put: function (url, data, callback) {
            this.ajax({
                url: url,
                type: "PUT",
                data: data
            }, callback);
        },
        delete: function (url, data, callback) {
            this.ajax({
                url: url,
                type: "DELETE",
                data: data
            }, callback);
        },
        sideClose(delay) {
            if (parent.layui.tool) {
                parent.layui.tool.close(delay);
            } else {
                console.log('父页面没引用tool模块');
            }
        },
        tabAdd: function (url, title) {
            if (parent.layui.admin) {
                parent.layui.admin.sonAdd(url, title);
            } else {
                console.log('父页面没引用admin模块');
            }
        },
        tabClose: function () {
            if (parent.layui.admin) {
                parent.layui.admin.sonClose();
            } else {
                console.log('父页面没引用admin模块');
            }
        },
        tabDelete: function (id) {
            if (parent.layui.admin) {
                parent.layui.admin.tabDelete(id);
            } else {
                console.log('父页面没引用admin模块');
            }
        },
        tabChange: function (id) {
            if (parent.layui.admin) {
                parent.layui.admin.tabChange(id);
            } else {
                console.log('父页面没引用admin模块');
            }
        },
        tabRefresh: function (id) {
            if (parent.layui.admin) {
                parent.layui.admin.refresh(id);
            } else {
                console.log('父页面没引用admin模块');
            }
        }
    };
    $('body').on('click', '.tab-a', function () {
        let url = $(this).data('href');
        let title = $(this).data('title');
        if (url && url !== '') {
            tool.tabAdd(url, title);
        }
        return false;
    });
    $('body').on('click', '.side-a', function () {
        let url = $(this).data('href');
        if (url && url !== '') {
            tool.side(url);
        }
        return false;
    });
    $('body').on('click', '.open-a', function () {
        let url = $(this).data('href');
        if (url && url !== '') {
            tool.open(url);
        }
        return false;
    });
    $('body').on('click', '.link-a', function () {
        let url = $(this).data('href');
        if (url && url !== '') {
            window.location.href = url;
        }
        return false;
    });


    exports(MOD_NAME, tool);
});  