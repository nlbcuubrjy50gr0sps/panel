{include file='admin/main.tpl'}

<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">编辑文档</h1>
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
                                <input class="form-control maxwidth-edit" id="title" name="title" type="text" value="{$help->title}">
                            </div>

                            <div class="form-group form-group-label">
                                <label class="floating-label" for="content">内容</label>
                                <link rel="stylesheet"
                                      href="https://fastly.jsdelivr.net/npm/editor.md@1.5.0/css/editormd.min.css"/>
                                <div id="editormd">
                                    <textarea style="display:none;" id="content">{$help->markdown}</textarea>
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
                                            <label for="class">
                                                <label class="floating-label" for="class">分类</label>
                                                <select id="class" class="form-control maxwidth-edit" name="class">
                                                        <option value="0">请选择分类</option>
                                                        {foreach $helpClass as $Class}
                                                            <option value="{$Class->id}" {if $Class->id == $helpUpid}selected="selected"{/if}>#{$Class->id} - {$Class->name}{if $Class->id == $helpUpid}  √{/if}</option>
                                                        {/foreach}
                                                </select>
                                            </label>
                                        </div>
                                        <div class="form-group form-group-label">
                                            <label for="sort">
                                                <label class="floating-label" for="sort">排序</label>
                                                <input class="form-control maxwidth-edit" id="sort" name="sort" type="text" value="{$help->sort}">
                                            </label>
                                        </div>
                                        <p class="form-control-guide"><i class="material-icons">info</i>数组越大越靠前(最多5位数)</p>

                                        <div class="form-group form-group-label">
                                            <div class="checkbox switch">
                                                <label for="isontop">
                                                    <input class="access-hide" id="isontop" type="checkbox" name="isontop" {if $help->ontop==1}checked{/if}><span class="switch-toggle"></span>是否置顶展开
                                                </label>
                                            </div>
                                        </div>

                                        <button id="submit" type="submit" class="btn btn-block btn-brand waves-attach waves-light">修改
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

<script src="https://fastly.jsdelivr.net/gh/CCooco/editor.md@v1.5.1/editormd.min.js"></script>
<script>
    editormd.emoji   = {
        // path  : "http://www.emoji-cheat-sheet.com/graphics/emojis/",
        path  : "/theme/metron/media/emoji/",
        ext   : ".png"
    };
    (() => {
        editor = editormd("editormd", {
            path: "https://fastly.jsdelivr.net/gh/CCooco/editor.md@v1.5.1/lib/", // Autoload modules mode, codemirror, marked... dependents libs path
            height: 720,
            saveHTMLToTextarea: true,
            emoji: true,
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
        function submit() {

            if ($$.getElementById('isontop').checked) {
                var isontop = 1;
            } else {
                var isontop = 0;
            }

            $.ajax({
                type: "PUT",
                url: "/admin/help/document/{$help->id}",
                dataType: "json",
                data: {
                    title: $$getValue('title'),
                    content: editor.getHTML(),
                    class: $$getValue('class'),
                    markdown: $('.editormd-markdown-textarea').val(),
                    isontop: isontop,
                    sort: $$getValue('sort'),
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
