{include file='admin/main.tpl'}

<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">工单</h1>
        </div>
    </div>
    <div class="container">
        <div class="col-lg-12 col-sm-12">
            <section class="content-inner margin-top-no">
                <div class="card">
                    <div class="card-main">
                        <div class="card-inner">
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="quick_create"> 输入用戶 ID 快速创建新工单 </label>
                                <input class="form-control maxwidth-edit" id="userid" type="text">
                            </div>
                        </div>
                        <div class="card-inner">
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="new_user_money"> 标题 </label>
                                <input class="form-control maxwidth-edit" id="title" type="text">
                            </div>
                        </div>
                        
                        <div class="card-inner">
                            <div class="form-group form-group-label">
                                <label for="new_user_add_shop">
                                    <label class="floating-label" for="message-text"> 部门 </label>
                                    <select id="ticket-type" class="form-control maxwidth-edit">
                                        <option>财务部门</option>
                                        <option>技术部门</option>
                                    </select>
                                </label>
                            </div>
                        </div>
                        <div class="card-inner">
                            <div class="form-group form-group-label">
                                <label for="new_user_add_shop">
                                    <label class="floating-label" for="message-text"> 严重性 </label>
                                    <select id="ticket-level" class="form-control maxwidth-edit">
                                        <option>低</option>
                                        <option>中</option>
                                        <option>高</option>
                                    </select>
                                </label>
                            </div>
                        </div>
                        
                        
                        <div class="card-inner">
                            <div class="form-group form-group-label">
                                <label class="floating-label" for="new_user_money"> 内容 </label>
                                <input class="form-control maxwidth-edit" id="content" type="text">
                            </div>
                        </div>
                        <div class="card-action">
                            <div class="card-action-btn pull-left">
                                <a class="btn btn-flat waves-attach waves-light" id="submit" type="submit"><span
                                            class="icon">check</span>&nbsp;添加</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card">
                    <div class="card-main">
                        <div class="card-inner">
                            <p>系统中的工单</p>
                            <p>显示表项:
                                {include file='table/checkbox.tpl'}
                            </p>
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    {include file='table/table.tpl'}
                </div>
            {include file='dialog.tpl'}
        </div>
    </div>
</main>

{include file='admin/footer.tpl'}

<script>
    {include file='table/js_1.tpl'}
    window.addEventListener('load', () => {
        function submit() {
            $.ajax({
                type: "POST",
                url: "/admin/ticket",
                dataType: "json",
                data: {
                    content: $$getValue('content'),
                    title: $$getValue('title'),
                    userid: $$getValue('userid'),
                    type: $$getValue('ticket-type'),
                    level: $$getValue('ticket-level')
                },
                success: (data) => {
                    if (data.ret) {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                        window.setTimeout("location.href='/admin/ticket'", {$config['jump_delay']});
                    } else {
                        $("#result").modal();
                        $$.getElementById('msg').innerHTML = data.msg;
                    }
                },
                error: (jqXHR) => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = `发生错误：${
                            jqXHR.status
                    }`;
                }
            });
        }
        $("#submit").click(function () {
            submit();
        });

        table = $('#table_tickets').DataTable({
            ajax: 'ticket/ajax',
            processing: true,
            serverSide: true,
            order: [[1, 'desc']]
        })
        {include file='table/js_2.tpl'}
    });
</script>