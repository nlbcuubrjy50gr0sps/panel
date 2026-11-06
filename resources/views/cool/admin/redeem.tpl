{include file='admin/main.tpl'}

<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">套餐码</h1>
        </div>
    </div>
    <div class="container">
        <section class="content-inner margin-top-no">
            <div class="card">
                <div class="card-main">
                    <div class="card-inner">
                        <div class="form-group form-group-label">
                            <label class="floating-label" for="prefix">兑换码</label>
                            <input class="form-control maxwidth-edit" id="prefix" type="text">
                            <p class="form-control-guide"><i class="material-icons">info</i>生成随机兑换码不填</p>
                        </div>
                        <div class="form-group form-group-label">
                            <label class="floating-label" for="prefix">选择生成套餐</label>
                            <select id="shop-id" class="form-control maxwidth-edit">
                                {foreach $shops as $shop}
                                    <option value="{$shop->id}">{$shop->name}</option>
                                {/foreach}
                            </select>
                        </div>
                        <div class="form-group form-group-label">
                            <label class="floating-label" for="expire">兑换码有效期(h)</label>
                            <input class="form-control maxwidth-edit" id="expire" type="number" value="1">
                        </div>
                        <div class="form-group form-group-label">
                            <label class="floating-label" for="shop">兑换码可用次数，-1为无限次</label>
                            <input class="form-control maxwidth-edit" id="count" type="number" value="1">
                        </div>
                        <div class="form-group form-group-label">
                            <label for="generate-type">
                                <label class="floating-label" for="sort">选择生成方式</label>
                                <select id="generate-type" class="form-control maxwidth-edit">
                                    <option value="1">指定字符</option>
                                    <option value="2">随机字符</option>
                                    <option value="3">指定字符+随机字符</option>
                                </select>
                            </label>
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-md-10 col-md-push-1">
                                    <button id="redeem" type="submit"
                                            class="btn btn-block btn-brand waves-attach waves-light">生成兑换码
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card margin-bottom-no">
                <div class="card-main">
                    <div class="card-inner">
                        <p class="card-heading">套餐码</p>
                        <p>显示表项:
                            {include file='table/checkbox.tpl'}
                        </p>
                        <div class="card-table">
                            <div class="table-responsive">
                                {include file='table/table.tpl'}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            {include file='dialog.tpl'}
        </section>
    </div>
</main>

{include file='admin/footer.tpl'}

<script>
    {include file='table/js_1.tpl'}
    window.addEventListener('load', () => {
        {include file='table/js_2.tpl'}

        $$.getElementById('redeem').addEventListener('click', () => {

            $.ajax({
                type: "POST",
                url: "/admin/redeem",
                dataType: "json",
                data: {
                    prefix: $$getValue('prefix'),
                    shop: $$getValue('shop-id'),
                    onetime: $$getValue('count'),
                    expire: $$getValue('expire'),
                    generate_type: $$getValue('generate-type'),
                },
                success: data => {
                    $("#result").modal();
                    $$.getElementById('msg').innerHTML = data.msg;
                    if (data.ret) {
                        window.setTimeout("location.href='/admin/redeem'", {$config['jump_delay']});
                    }
                },
                error: jqXHR => {
                    alert(`发生错误：${
                            jqXHR.status
                            }`);
                }
            })
        })
    })
</script>