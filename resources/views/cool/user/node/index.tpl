<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>节点列表 — {$config['appName']}</title>
    {include file='user/header.tpl'}
    <style>
        .nodes-style {
            text-align: right;
            position: absolute;
            right: 2em;
        }
    </style>
    
    <!-- BEGIN: Content--> 
    <div class="app-content content">
        <div class="content-overlay"></div>
        <div class="header-navbar-shadow"></div>
        <div class="content-wrapper">
            <div class="content-header row">
                <div class="content-header-left col-md-9 col-12 mb-2">
                    <div class="row breadcrumbs-top">
                        <div class="col-12">
                            <h2 class="content-header-title float-left mb-0">节点列表</h2>
                           <div class="breadcrumb-wrapper col-12">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/user">Home</a></li>
                                      <li class="breadcrumb-item"><a href="/user/node">Server</a></li>
                                 </ol>
                           </div>
                        </div>
                     </div>
                </div>
            </div>
            <div class="card">
                <div class="card-header">
                    <h4 class="card-title">使用说明</h4>
                    {if $Cool_Config['nodes_filter'] === true}
                        <a class="btn btn-outline-primary waves-effect right nodes-style" data-toggle="modal" data-target="#nodes-filter-modal">节点筛选</a>
                    {/if}
                </div>
                <hr />
                <div class="card-body" style="padding-top: 0.5rem;">
                    <blockquote class="blockquote">
        	            <p class="description badge-dot"><strong>线路简介</strong>：可以通过节点筛选来选择节点使用，这会更好的满足您的服务需求。</p>
        	            <p class="description badge-dot"><strong>各类标签</strong>：流量倍率 -> 你使用 0.2 倍率的节点，消耗 1G 流量，则统计为 0.2G；速率 -> 标示速率为最高速率，但会受限于您本地网络、目标网络等；等级 -> 与会员套餐匹配；在线、负载 -> 表示节点当前使用人数，过载可能会影响线路体验...</p>
                        <p class="description badge-dot"><strong>使用权限</strong>：对应的节点使用<code>权限</code>根据你的用户等级和用户群组来决定的.</p>
                        <p>
                            当前套餐等级：<font color="#399AF2" size="3">VIP{$user->class} {$Cool_Config['node_class_name'][{$user->class}]}</font>&nbsp;&nbsp;
                            <a class="btn btn-success btn-sm" href="/user/shop">点此升级</a>
                        </p>
                    </blockquote>
                    
                </div>
            </div>
    
            {if $Cool_Config['flag_mode'] == 'node-name'}
                {assign var=flags value=['美国'=>'us','香港'=>'hk','新加'=>'sg','日本'=>'jp','回国'=>'cn','中国'=>'cn','台湾'=> 'tw','菲律'=>'ph','俄罗'=>'ru','韩国'=>'kr','德国'=>'de','英国'=>'gb','法国'=>'fr','越南'=>'vn','印度'=>'in','印尼'=>'id','澳门'=>'mo','马来'=>'my','荷兰'=>'nl','罗马'=>'ro','澳大'=>'au']}
            {/if}
            
            <div class="content-body">
                {$class = -1} {$dom_head = 0}
            {foreach $nodes as $node_class => $class_group}
                {foreach $class_group as $node}
                
                    {if $node['class'] != $class}
                        {if $dom_head === 2}
                    </div>
                        {/if}
                    {$class = $node['class']} {$dom_head = 1} {$nodeClass[] = $node['class']}
                    
                    <h4 class="card-title"> {$Cool_Config['node_class_name'][$class]}</h4>
                    
                    {/if}
                    {if $dom_head === 1}
                        {$dom_head = 2} {$dom_end = 1}
        
                    <div class="row">
                    {/if}
                        <div class="col-12 col-sm-12 col-lg-6">
                        {if $Cool_Config['show_node_info'] == true}
                            <div class="card" onclick="UsernodeInfo()">
                        {else}
        	                {if $node['sort'] == 11}
        	                    <div class="card" {if $user->class >= $node['class']}data-toggle="modal" data-target="#node-modal-{$node['id']}" {else} onclick="UserClassinsufficient()" {/if}>
        	                {elseif $node['sort'] == 14}
        	                    <div class="card" {if $user->class >= $node['class']}data-toggle="modal" data-target="#nodeinfo-trojan-modal-{$node['id']}" {else} onclick="UserClassinsufficient()" {/if}>
        	                {else}
                                {foreach $node['connect'] as $mu_port}
                                    <div class="card" {if $user->class >= $node['class']} onclick="urlChange('{$node['id']}',{$mu_port})" {else} onclick="UserClassinsufficient()" {/if}>
                                    {break}
                                {/foreach}
                            {/if}
                        {/if}
                            
                                <div class="card-body">
                                    <ul class="list-unstyled user-details list-unstyled-border list-unstyled-noborder">
                                        <li class="media">
                                            {$region = substr($node['name'],0,6)}
                                            <img alt="image" class="mr-2 rounded-circle" width="50" height="50" src="/theme/cool/assets/modules/flag-icon-css/flags/1x1/{if $Cool_Config['flag_mode']=='node-name'}{if $flags[$region] != ''}{$flags[$region]}{else}un{/if}{else}{$node['status']}{/if}.svg">
                                            <div class="media-body">
                                                <div class="media-title node-status {if $node['online']=='1'} node-is-online {else} node-is-offline {/if}">{$node['name']}</div>
                                                <div class=" text-job text-muted">{$node['info']}</div>
                                            </div>
                                            <div class="media-items">
                                              {if $Cool_Config['show_online_user'] == true}
                                                  <div class="media-item">
                                                    <div class="media-value">{if $user->isAdmin}{$node['online_user']}{else}{if $node['online_user'] == -1} N/A{else} {$node['online_user']} {/if}{/if}</div>
                                                    <div class="media-label">在线</div>
                                                  </div>
                                              {/if}
                                              
                                              {if $Cool_Config['show_node_traffic_rate'] == true}
                                                  <div class="media-item">
                                                    <div class="media-value">x{$node['traffic_rate']}</div>
                                                    <div class="media-label">倍率</div>
                                                  </div>
                                              {/if}
                                              
                                              {if $Cool_Config['show_node_load'] == true}
                                                  <div class="media-item">
                                                    <div class="media-value">{if $node['latest_load'] == -1}N/A{else}{$node['latest_load']}{/if}</div>
                                                    <div class="media-label">负载</div>
                                                  </div>
                                              {/if}
                                              
                                              {if $Cool_Config['show_node_speedlimit'] == true}
                                                  <div class="media-item">
                                                    <div class="media-value">{if {$node['bandwidth']}==0}N/A{else}{$node['bandwidth']}{/if}</div>
                                                    <div class="media-label">速率</div>
                                                  </div>
                                              {/if}
                                              
                                              {if $Cool_Config['show_node_traffic_used'] == true}
                                                <div class="media-item">
                    	                              <div class="media-value">{if $node['traffic_limit']>0}{$node['traffic_used']}/{$node['traffic_limit']}{else}{$node['traffic_used']}/∞{/if}</div>
                    	                              <div class="media-label">流量</div>
                    	                         </div>
                                              {/if}
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                {/foreach}
             {/foreach}
                    </div>
                    
            </div>
        </div> 
    </div>
    <!-- END: Content--> 

	<!-- node_info -->
	<div class="modal fade" tabindex="-1" role="dialog" id="nodeinfo" aria-labelledby="nodeinfoModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
		<div class="modal-header">
			<h4 id="nodeinfoModalLabel">节点详细信息</h4>
			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
		</div>
			<iframe id="infoifram" style="display: block;border: none;width: 100%;height: 600px;margin: 0;padding: 0;over"></iframe>
		</div>
	  </div>
	</div>
	
<!-- 订阅筛选 -->
{if $Cool_Config['nodes_filter'] === true}
<div class="modal fade" id="nodes-filter-modal"tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h4>订阅节点筛选</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            
            <div class="modal-body">
                <div class="row align-items-center">
                    <div class="col-xl-8 order-2 order-xl-1">
                        <div class="row align-items-center">
                            <div class="col-md-3">
                                <div class="form-label">
                                    <label>节点订阅模式</label>
                                </div>
                                <div class="d-flex align-items-center">
                                    <select class="form-control" id="filter_mode">
                                        <option value="all" {if !$filter || $filter && $filter['mode']=='all'}selected="selected"{/if}>默认获取全部</option>
                                        <option value="nodes_class" {if $filter && $filter['mode']=='nodes_class'}selected="selected"{/if}>按节点等级</option>
                                        <option value="nodes_id" {if $filter && $filter['mode']=='nodes_id'}selected="selected"{/if}>自定义获取节点</option>
                                    </select>
                                </div>
                            </div>
                        
                            <div class="col-md-3">
                                <div class="form-label">
                                    <label>订阅节点排序</label>
                                </div>
                                <div class="d-flex align-items-center">
                                    <select class="form-control" id="filter_sort">
                                        <option value="node_class-asc" {if $filter['sort']['type']=='node_class' && $filter['sort']['value']=='asc'}selected="selected"{/if}>按节点等级升序</option>
                                        <option value="node_class-desc" {if $filter['sort']['type']=='node_class' && $filter['sort']['value']=='desc'}selected="selected"{/if}>按节点等级降序</option>
                                    </select>
                                </div>
                            </div>
                            
                            {if $Cool_Config['nodes_miniName'] === true}
                            <div class="col-md-3">
                                <div class="form-label">
                                    <label>简化节点名称</label>
                                </div>
                                <div class="d-flex align-items-center">
                                    <select class="form-control" id="filter_mininame">
                                        <option value="1" {if $filter['mininame']===1}selected="selected"{/if}>开启</option>
                                        <option value="0" {if $filter['mininame']===0 || !$filter['mininame'] }selected="selected"{/if}>关闭</option>
                                    </select>
                                </div>
                            </div>
                            {/if}
                        </div>
                    </div>
                </div>
                
                <div class="nodes-modal">
                    <!-- mode: 默认获取全部 -->
                    <div class="row pl-1 pr-1 pt-4" id="filter_mode-all" {if $filter && $filter['mode']!='all'} style="display: none" {/if}>
                        <div class="col-12 alert alert-custom alert-outline-2x alert-outline-primary fade show mb-5" role="alert">
                            <div class="alert-text">该模式下您可以订阅到所有可用节点</div>
                        </div>
                    </div>
                    
                    <!-- mode: 按节点等级 -->
                    <div class="row pt-2" id="filter_mode-nodes_class" {if $filter['mode']!='nodes_class'} style="display: none" {/if}>
                        <div class="col-12 text-center">
                            <h3 class="text-primary"><strong>节点等级条件</strong></h3>
                        </div>
                        <div class="col-12">
                            <p>获取<code>大于等于</code>指定等级的所有节点</p>
                            <p>例如选择 Lv.2 等级, 您将订阅到 Lv.2 和以上等级节点, 不会订阅到 Lv.1 节点<br></p>
                        </div>
                        <div class="col-12 row">
                            {foreach $nodeClass as $class}
                                <div class="custom-control custom-radio">
                                    <input type="radio" id="inlineRadio-{$class}" {if $user->class < $class} disabled="disabled" {/if} name="radio-nodes_class-filter" class="custom-control-input" value="{$class}" 
                   
                                    {if $filter['nodes_class']['the'] == '>=' && $class == $filter['nodes_class']['value'] || !$filter['nodes_class']['the'] && $class==$user->class}checked="true"{/if}>
                                    
                                    
                                    &nbsp;&nbsp;
                                    <label class="custom-control-label" for="inlineRadio-{$class}" {if $user->class < $class} disabled="disabled" {/if} >Lv{$class} {$Cool_Config['node_class_name'][$class]} </label>
                                </div>
                            {/foreach}
                        </div>
                    </div>
                
                    <!-- mode: 自定义获取节点 -->
                    <div class="row" id="filter_mode-nodes_id" {if $filter['mode']!='nodes_id'} style="display: none" {/if}>
                    {$filter_class = -1}
                    
                    {foreach $nodes as $node_class => $class_group}
                        {foreach $class_group as $node}
                        {if $node['class'] != $filter_class}
                            {$filter_class = $node['class']}
                            <div class="col-12 pt-2 text-center">
                                <h3 class="display-5 text-primary"><strong>{$Cool_Config['node_class_name'][$filter_class]}</strong>{if $user->class<$filter_class} [等级不足]{/if}</h3>
                            </div>
                        {/if}
                        
                        <div class="col-sm-12 col-md-6 col-lg-4 col-xl-2 pt-1 custom-control custom-checkbox ml-1">
                            <input class="custom-control-input node_class-{$node['class']} nation-{$node['status']}" type="checkbox" id="id-{$node['id']}"
                            {if $user->class < $node['class']} disabled="disabled" {/if} name="nodes_id-filter" value="{$node['id']}" {if isset($filter['nodes_id']) && in_array($node['id'], $filter['nodes_id']) || !$filter['nodes_id'] && $user->class >= $node['class']}checked="true"{/if}>
                            <label class="custom-control-label" for="id-{$node['id']}">{$node['name']}</label>
                        </div>
                        
                        {/foreach}
                    {/foreach}
                    
                    </div>
                </div>
                
            </div>
            <div class="modal-footer">
                <button type="button" class="btn font-weight-bold" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-success" onclick="nodeFilterSave();" id="node_filter_save_down"><i class="fa fa-save"></i> <span id="node_filter_save_dowm_text">保存更改</span></button>
            </div>
        </div>
    </div>
</div>
{/if}
  
  <!-- BEGIN: Footer--> 
	{include file='user/footer.tpl'} 
  <!-- END: Footer-->
  
    <script>
        $("#filter_mode").on("change", function() {
        	$nodes_moal = $("#filter_mode-" + $(this).val());
        	$nodes_moal.siblings().hide();
        	$nodes_moal.show();
        });
    </script>
</body>
</html>