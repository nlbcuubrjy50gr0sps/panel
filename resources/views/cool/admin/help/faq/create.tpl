{include file='admin/main.tpl'}

<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">添加记录</h1>
        </div>
    </div>
    <div class="container">
        <div class="col-lg-12 col-md-12">
            <section class="content-inner margin-top-no">

                <div class="card">
                    <div class="card-main">
                        <div class="card-inner">
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="title">标题</label>
                                <input class="form-control maxwidth-edit" id="title" name="title" type="text" value="">
                            </div>
                        
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="content">内容</label>
                                <link rel="stylesheet"
                                      href="https://fastly.jsdelivr.net/npm/editor.md@1.5.0/css/editormd.min.css"/>
                                <div id="editormd">
                                    <textarea style="display:none;" id="content"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-main">
                        <div class="card-inner">

                            <div class="form-group">
                                <div class="row">
                                    <div class="col-md-10 col-md-push-1">
                                        <div class="form-group form-group-label">
                                            <input class="form-control maxwidth-edit" id="time" type="text" name="time" value="{date('Y-m-d H:i:s')}">
                                            <p class="form-control-guide"><i class="material-icons">info</i>发表时间</p>
                                        </div>
                                    
                                        <button id="submit" type="submit" class="btn btn-block btn-brand waves-attach waves-light">添加
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                {include file='dialog.tpl'}
        </div>


    </div>
</main>

{include file='admin/footer.tpl'}

<script src="https://fastly.jsdelivr.net/npm/editor.md@1.5.0/editormd.min.js"></script>
<script>
    (() => {
        editor = editormd("editormd", {
            path: "https://fastly.jsdelivr.net/npm/editor.md@1.5.0/lib/", // Autoload modules mode, codemirror, marked... dependents libs path
            height: 720,
            saveHTMLToTextarea: true
        });

        /*
        // or
        var editor = editormd({
            id   : "editormd",
            path : "../lib/"
        });
        */
    })();

    window.addEventListener('load', () => {
        function submit(page = -1) {
            $.ajax({
                type: "POST",
                url: "/admin/faq",
                dataType: "json",
                data: {
                    title: $$getValue('title'),
                    content: editor.getHTML(),
                    markdown: editor.getMarkdown(),
                    time: $$getValue('time'),
                },
                success: data => {
                    if (data.ret === 1) {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                        window.setTimeout("location.href=top.document.referrer", {$config['jump_delay']});
                    } else if (data.ret === 2) {
                        submit(data.msg);
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: jqXHR => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `发生错误：${
                            jqXHR.status
                            }`;
                }
            });
        }

        $$.getElementById('submit').addEventListener('click', () => {
            submit();
        });
    });


</script>
