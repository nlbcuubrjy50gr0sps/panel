{include file='admin/main.tpl'}

<main class="content">
    <div class="content-header ui-content-header">
        <div class="container">
            <h1 class="content-heading">汇总</h1>
        </div>
    </div>
    <div class="container">
        <section class="content-inner margin-top-no">
            <div class="row">
                <div class="col-xx-12">
                    <div class="card margin-bottom-no">
                        <div class="card-main">
                            <div class="card-inner">
                                <p>下面是系统运行情况简报。</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="ui-card-wrap">
                <div class="row">
                    {if $Cool_Config['quick_operation'] == true}
                		<div class="col-xx-12">
                            <div class="card">
                                <div class="card-main">
                                    <div class="card-inner">
                                        <h5>快捷操作(不可逆,请等待页面刷新)</h5>
                                        <p>无关紧要的记录，请按时清理，尤其是实时流量记录增加的会很快，超过php页面消耗的最大内存时会报错</p>
                                        <p>可自行Google 修改PHP memory_limit数值解决。若嫌麻烦，可进入主题配置文件，关闭快捷操作</p>
                                        
                        				<button onclick="detect_log('detect_log')" type="button" class="btn btn-primary">清理审计记录 {$sys->getDetectLog()}</button>&nbsp;
                        				<button onclick="login_ip('login_ip')" type="button" class="btn btn-primary">清理登陆IP记录 {$sys->getLoginIp()}</button>&nbsp;
                        				<button onclick="paylist('paylist')" type="button" class="btn btn-primary">清理未支付订单记录 {$sys->getPaylist()}</button>&nbsp;
                        				<button onclick="node_info('node_info')" type="button" class="btn btn-primary">清理节点信息记录 {$sys->getNodeInfoLog()}</button>&nbsp;
                        				<button onclick="node_online_log('node_online_log')" type="button" class="btn btn-primary">清理节点在线记录 {$sys->getNodeOnlineLog()}</button>&nbsp;
                        				<button onclick="codelist('codelist')" type="button" class="btn btn-primary">清理所有流水记录 {$sys->getCodelist()}</button>
                                    </div>
                                </div>
                            </div>
                		</div>
                	{/if}
                    
                    <div class="col-xx-12 col-sm-4">
                        <div class="card">
                            <div class="card-main">
                                <div class="card-inner">
                                    <h5>财务简报</h5>
                                    <div class="col-sm-6">
                                        <p id="income_text">
                                            今日笔数: {$sts->getFinanceToday('count')} 笔<br />
                                            
                                            今日流水: ¥ {$sts->getFinanceToday('total')}<br />
                                            
                                            ️七天笔数: {$sts->getFinanceWeek('count')} 笔<br />
                                            
                                            上月笔数: {$sts->getFinanceMonth('count')} 笔<br />
                                        </p>
                                    </div> 
                                    <div class="col-sm-6">
                                        <p id="income_text">
                                            昨日笔数: {$sts->getFinanceYesterday('count')} 笔<br />
                                          
                                            昨日流水: ¥ {$sts->getFinanceYesterday('total')}<br />
                                            
                                            ️七天流水: ¥ {$sts->getFinanceWeek('total')}<br />
                                            
                                            上月流水: ¥ {$sts->getFinanceMonth('total')}
                                        </p>
                                    </div> 
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xx-12 col-sm-4">
                        <div class="card">
                            <div class="card-main">
                                <div class="card-inner">
                                    <h5>人数简报</h5>
                                    <div class="col-sm-6">
                                        <p id="income_text">
                                            今日新注册: {$sts->getUserNumToday()} 人<br />
                                            
                                            昨日注册: {$sts->getUserNumYesterday()} 人<br />
                                            
                                            七天注册: {$sts->getUserNumWeek()} 人<br />
                                            
                                            上月注册: {$sts->getUserNumMonth()} 人<br />
                                        </p>
                                    </div> 
                                    <div class="col-sm-6">
                                        <p id="income_text">
                                            {if $sts->getUserNumWeek() != 0}
                                                七天转化: {round(($sts->getFinanceWeek('count') / $sts->getUserNumWeek() *100),2)} % <br />
                                            {else}
                                                七天转化: 0 % <br />
                                            {/if}
                                            
                                            {if $sts->getUserNumMonth() != 0}
                                                上月转化: {round(($sts->getFinanceMonth('count') / $sts->getUserNumMonth()*100),2)} % <br />
                                            {else}
                                                上月转化: 0 % <br />
                                            {/if}
                                            
                                            七天账号过期: {$sts->getUserClassExp('expire_in')} 人 <br />
                                            
                                            七天等级过期: {$sts->getUserClassExp('class_expire')} 人
                                        </p>
                                    </div> 
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xx-12 col-sm-4">
                        <div class="card">
                            <div class="card-main">
                                <div class="card-inner">
                                    <h5>付费简报</h5>
                                    <div class="col-sm-6">
                                        <p id="income_text">
                                            总用户: {$sts->getTotalUser()} 人<br />
                                            
                                            白嫖用户: {$sts->getUserPayNum('nopay')} 人<br />
                                            
                                            ️付费用户: {$sts->getUserPayNum('yespay')} 人<br />
                                            
                                            付费转化: {round(($sts->getUserPayNum('yespay') / $sts->getTotalUser() *100),2)} %<br />
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="ui-card-wrap">
                        <div class="row">
                            <div class="col-xx-12 col-sm-6">
                                <div class="card">
                                    <div class="card-main">
                                        <div class="card-inner">
                                            <div id="check_chart" style="height: 300px; width: 100%;"></div>
                                            <script src="//cdn.jsdelivr.net/gh/M1Screw/canvasjs.js/canvasjs.min.js"></script>
                                            <script>
                                                var chart = new CanvasJS.Chart("check_chart",
                                                        {
                                                            title: {
                                                                text: "用户签到情况(总用户 {$sts->getTotalUser()}人)",
                                                                fontFamily: "Impact",
                                                                fontWeight: "normal"
                                                            },
                                                            legend: {
                                                                verticalAlign: "bottom",
                                                                horizontalAlign: "center"
                                                            },
                                                            data: [
                                                                {
                                                                    //startAngle: 45,
                                                                    indexLabelFontSize: 20,
                                                                    indexLabelFontFamily: "Garamond",
                                                                    indexLabelFontColor: "darkgrey",
                                                                    indexLabelLineColor: "darkgrey",
                                                                    indexLabelPlacement: "outside",
                                                                    type: "doughnut",
                                                                    showInLegend: true,
                                                                    dataPoints: [
                                                                        {
                                                                            y: {(1-($sts->getCheckinUser()/$sts->getTotalUser()))*100},
                                                                            legendText: "没有签到过的用户 {number_format((1-($sts->getCheckinUser()/$sts->getTotalUser()))*100,2)}% {$sts->getTotalUser()-$sts->getCheckinUser()}人",
                                                                            indexLabel: "没有签到过的用户 {number_format((1-($sts->getCheckinUser()/$sts->getTotalUser()))*100,2)}% {$sts->getTotalUser()-$sts->getCheckinUser()}人"
                                                                        },
                                                                        {
                                                                            y: {(($sts->getCheckinUser()-$sts->getTodayCheckinUser())/$sts->getTotalUser())*100},
                                                                            legendText: "曾经签到过的用户 {number_format((($sts->getCheckinUser()-$sts->getTodayCheckinUser())/$sts->getTotalUser())*100,2)}% {$sts->getCheckinUser()-$sts->getTodayCheckinUser()}人",
                                                                            indexLabel: "曾经签到过的用户 {number_format((($sts->getCheckinUser()-$sts->getTodayCheckinUser())/$sts->getTotalUser())*100,2)}% {$sts->getCheckinUser()-$sts->getTodayCheckinUser()}人"
                                                                        },
                                                                        {
                                                                            y: {$sts->getTodayCheckinUser()/$sts->getTotalUser()*100},
                                                                            legendText: "今日签到用户 {number_format($sts->getTodayCheckinUser()/$sts->getTotalUser()*100,2)}% {$sts->getTodayCheckinUser()}人",
                                                                            indexLabel: "今日签到用户 {number_format($sts->getTodayCheckinUser()/$sts->getTotalUser()*100,2)}% {$sts->getTodayCheckinUser()}人"
                                                                        }
                                                                    ]
                                                                }
                                                            ]
                                                        });
                                                chart.render();
                                                function chartRender(chart) {
                                                    chart.render();
                                                    chart.ctx.shadowBlur = 8;
                                                    chart.ctx.shadowOffsetX = 4;
                                                    chart.ctx.shadowColor = "black";
                                                    for (let i in chart.plotInfo.plotTypes) {
                                                        let plotType = chart.plotInfo.plotTypes[i];
                                                        for (let j in plotType.plotUnits) {
                                                            let plotUnit = plotType.plotUnits[j];
                                                            if (plotUnit.type === "doughnut") {
                                                                // For Column Chart
                                                                chart.renderDoughnut(plotUnit);
                                                            } else if (plotUnit.type === "bar") {
                                                                // For Bar Chart
                                                                chart.renderBar(plotUnit);
                                                            }
                                                        }
                                                    }
                                                    chart.ctx.shadowBlur = 0;
                                                    chart.ctx.shadowOffsetX = 0;
                                                    chart.ctx.shadowColor = "transparent";
                                                }
                                            </script>
                                        </div>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-main">
                                        <div class="card-inner">
                                            <div id="alive_chart" style="height: 300px; width: 100%;"></div>
                                            <script src="//cdn.jsdelivr.net/gh/M1Screw/canvasjs.js/canvasjs.min.js"></script>
                                            <script type="text/javascript">
                                                var chart = new CanvasJS.Chart("alive_chart",
                                                        {
                                                            title: {
                                                                text: "用户在线情况(总用户 {$sts->getTotalUser()}人)",
                                                                fontFamily: "Impact",
                                                                fontWeight: "normal"
                                                            },
                                                            legend: {
                                                                verticalAlign: "bottom",
                                                                horizontalAlign: "center"
                                                            },
                                                            data: [
                                                                {
                                                                    //startAngle: 45,
                                                                    indexLabelFontSize: 20,
                                                                    indexLabelFontFamily: "Garamond",
                                                                    indexLabelFontColor: "darkgrey",
                                                                    indexLabelLineColor: "darkgrey",
                                                                    indexLabelPlacement: "outside",
                                                                    type: "doughnut",
                                                                    showInLegend: true,
                                                                    dataPoints: [
                                                                        {
                                                                            y: {(($sts->getUnusedUser()/$sts->getTotalUser()))*100},
                                                                            legendText: "从未在线的用户 {number_format((($sts->getUnusedUser()/$sts->getTotalUser()))*100,2)}% {(($sts->getUnusedUser()))}人",
                                                                            indexLabel: "从未在线的用户 {number_format((($sts->getUnusedUser()/$sts->getTotalUser()))*100,2)}% {(($sts->getUnusedUser()))}人"
                                                                        },
                                                                        {
                                                                            y: {(($sts->getTotalUser()-$sts->getOnlineUser(86400)-$sts->getUnusedUser())/$sts->getTotalUser())*100},
                                                                            legendText: "一天以前在线的用户 {number_format((($sts->getTotalUser()-$sts->getOnlineUser(86400)-$sts->getUnusedUser())/$sts->getTotalUser())*100,2)}% {($sts->getTotalUser()-$sts->getOnlineUser(86400)-$sts->getUnusedUser())}人",
                                                                            indexLabel: "一天以前在线的用户 {number_format((($sts->getTotalUser()-$sts->getOnlineUser(86400)-$sts->getUnusedUser())/$sts->getTotalUser())*100,2)}% {($sts->getTotalUser()-$sts->getOnlineUser(86400)-$sts->getUnusedUser())}人"
                                                                        },
                                                                        {
                                                                            y: {($sts->getOnlineUser(86400)-$sts->getOnlineUser(3600))/$sts->getTotalUser()*100},
                                                                            legendText: "一天内在线的用户 {number_format(($sts->getOnlineUser(86400)-$sts->getOnlineUser(3600))/$sts->getTotalUser()*100,2)}% {($sts->getOnlineUser(86400)-$sts->getOnlineUser(3600))}人",
                                                                            indexLabel: "一天内在线的用户 {number_format(($sts->getOnlineUser(86400)-$sts->getOnlineUser(3600))/$sts->getTotalUser()*100,2)}% {($sts->getOnlineUser(86400)-$sts->getOnlineUser(3600))}人"
                                                                        },
                                                                        {
                                                                            y: {($sts->getOnlineUser(3600)-$sts->getOnlineUser(60))/$sts->getTotalUser()*100},
                                                                            legendText: "一小时内在线的用户 {number_format(($sts->getOnlineUser(3600)-$sts->getOnlineUser(60))/$sts->getTotalUser()*100,2)}% {($sts->getOnlineUser(3600)-$sts->getOnlineUser(60))}人",
                                                                            indexLabel: "一小时内在线的用户 {number_format(($sts->getOnlineUser(3600)-$sts->getOnlineUser(60))/$sts->getTotalUser()*100,2)}% {($sts->getOnlineUser(3600)-$sts->getOnlineUser(60))}人"
                                                                        },
                                                                        {
                                                                            y: {($sts->getOnlineUser(60))/$sts->getTotalUser()*100},
                                                                            legendText: "一分钟内在线的用户 {number_format(($sts->getOnlineUser(60))/$sts->getTotalUser()*100,2)}% {($sts->getOnlineUser(60))}人",
                                                                            indexLabel: "一分钟内在线的用户 {number_format(($sts->getOnlineUser(60))/$sts->getTotalUser()*100,2)}% {($sts->getOnlineUser(60))}人"
                                                                        }
                                                                    ]
                                                                }
                                                            ]
                                                        });
                                                chart.render();
                                            </script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xx-12 col-sm-6">
                                <div class="card">
                                    <div class="card-main">
                                        <div class="card-inner">
                                            <div id="node_chart" style="height: 300px; width: 100%;"></div>
                                            <script src="//cdn.jsdelivr.net/gh/M1Screw/canvasjs.js/canvasjs.min.js"></script>
                                            <script type="text/javascript">
                                                var chart = new CanvasJS.Chart("node_chart",
                                                        {
                                                            title: {
                                                                text: "节点在线情况(节点数 {$sts->getTotalNodes()}个)",
                                                                fontFamily: "Impact",
                                                                fontWeight: "normal"
                                                            },
                                                            legend: {
                                                                verticalAlign: "bottom",
                                                                horizontalAlign: "center"
                                                            },
                                                            data: [
                                                                {
                                                                    //startAngle: 45,
                                                                    indexLabelFontSize: 20,
                                                                    indexLabelFontFamily: "Garamond",
                                                                    indexLabelFontColor: "darkgrey",
                                                                    indexLabelLineColor: "darkgrey",
                                                                    indexLabelPlacement: "outside",
                                                                    type: "doughnut",
                                                                    showInLegend: true,
                                                                    dataPoints: [
                                                                        {if $sts->getTotalNodes()!=0}
                                                                        {
                                                                            y: {(1-($sts->getAliveNodes()/$sts->getTotalNodes()))*100},
                                                                            legendText: "离线节点 {number_format((1-($sts->getAliveNodes()/$sts->getTotalNodes()))*100,2)}% {$sts->getTotalNodes()-$sts->getAliveNodes()}个",
                                                                            indexLabel: "离线节点 {number_format((1-($sts->getAliveNodes()/$sts->getTotalNodes()))*100,2)}% {$sts->getTotalNodes()-$sts->getAliveNodes()}个"
                                                                        },
                                                                        {
                                                                            y: {(($sts->getAliveNodes()/$sts->getTotalNodes()))*100},
                                                                            legendText: "在线节点 {number_format((($sts->getAliveNodes()/$sts->getTotalNodes()))*100,2)}% {$sts->getAliveNodes()}个",
                                                                            indexLabel: "在线节点 {number_format((($sts->getAliveNodes()/$sts->getTotalNodes()))*100,2)}% {$sts->getAliveNodes()}个"
                                                                        }
                                                                        {/if}
                                                                    ]
                                                                }
                                                            ]
                                                        });           
                                                chart.render();
                                            </script>
                                        </div>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-main">
                                        <div class="card-inner">
                                            <div id="traffic_chart" style="height: 300px; width: 100%;"></div>
                                            <script src="//cdn.jsdelivr.net/gh/M1Screw/canvasjs.js/canvasjs.min.js"></script>
                                            <script type="text/javascript">
                                                var chart = new CanvasJS.Chart("traffic_chart",
                                                        {
                                                            title: {
                                                                text: "流量使用情况(总分配流量 {$sts->getTotalTraffic()})",
                                                                fontFamily: "Impact",
                                                                fontWeight: "normal"
                                                            },
                                                            legend: {
                                                                verticalAlign: "bottom",
                                                                horizontalAlign: "center"
                                                            },
                                                            data: [
                                                                {
                                                                    //startAngle: 45,
                                                                    indexLabelFontSize: 20,
                                                                    indexLabelFontFamily: "Garamond",
                                                                    indexLabelFontColor: "darkgrey",
                                                                    indexLabelLineColor: "darkgrey",
                                                                    indexLabelPlacement: "outside",
                                                                    type: "doughnut",
                                                                    showInLegend: true,
                                                                    dataPoints: [
                                                                        {if $sts->getRawTotalTraffic()!=0}
                                                                        {
                                                                            y: {(($sts->getRawUnusedTrafficUsage()/$sts->getRawTotalTraffic()))*100},
                                                                            label: "总剩余可用",
                                                                            legendText: "总剩余可用 {number_format((($sts->getRawUnusedTrafficUsage()/$sts->getRawTotalTraffic()))*100,2)}% {(($sts->getUnusedTrafficUsage()))}",
                                                                            indexLabel: "总剩余可用 {number_format((($sts->getRawUnusedTrafficUsage()/$sts->getRawTotalTraffic()))*100,2)}% {(($sts->getUnusedTrafficUsage()))}"
                                                                        },
                                                                        {
                                                                            y: {(($sts->getRawLastTrafficUsage()/$sts->getRawTotalTraffic()))*100},
                                                                            label: "总过去已用",
                                                                            legendText: "总过去已用 {number_format((($sts->getRawLastTrafficUsage()/$sts->getRawTotalTraffic()))*100,2)}% {(($sts->getLastTrafficUsage()))}",
                                                                            indexLabel: "总过去已用 {number_format((($sts->getRawLastTrafficUsage()/$sts->getRawTotalTraffic()))*100,2)}% {(($sts->getLastTrafficUsage()))}"
                                                                        },
                                                                        {
                                                                            y: {(($sts->getRawTodayTrafficUsage()/$sts->getRawTotalTraffic()))*100},
                                                                            label: "总今日已用",
                                                                            legendText: "总今日已用 {number_format((($sts->getRawTodayTrafficUsage()/$sts->getRawTotalTraffic()))*100,2)}% {(($sts->getTodayTrafficUsage()))}",
                                                                            indexLabel: "总今日已用 {number_format((($sts->getRawTodayTrafficUsage()/$sts->getRawTotalTraffic()))*100,2)}% {(($sts->getTodayTrafficUsage()))}"
                                                                        }
                                                                        {/if}
                                                                    ]
                                                                }
                                                            ]
                                                        });
                                                chart.render();
                                            </script>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
 
                </div>
            </div>
        </section>
    </div>
</main>

    <!--删除modal-->
    <div aria-hidden="true" class="modal modal-va-middle fade" id="delete_modal" role="dialog"
         tabindex="-1">
        <div class="modal-dialog modal-xs">
            <div class="modal-content">
                <div class="modal-heading">
                    <a class="modal-close" data-dismiss="modal">×</a>
                    <h2 class="modal-title">确认要删除？</h2>
                </div>
                <div class="modal-inner">
                    <p>请您确认。</p>
                </div>
                <div class="modal-footer">
                    <p class="text-right">
                        <button class="btn btn-flat btn-brand-accent waves-attach waves-effect"
                                data-dismiss="modal" type="button">取消
                        </button>
                        <button class="btn btn-flat btn-brand-accent waves-attach" data-dismiss="modal"
                                id="delete_input" type="button">确定
                        </button>
                    </p>
                </div>
            </div>
        </div>
    </div>
    
    {include file='dialog.tpl'}

{include file='admin/footer.tpl'}

{if $Cool_Config['quick_operation'] == true}
    <script>
        function detect_log(log){
        	$("#delete_modal").modal();
        	$("#delete_modal").on('shown.bs.modal', function () {
        	    $("#delete_input").click(function (){
        			$("#delete_input").html('正在删除...')
        			document.getElementById('delete_input').disabled=true;
        			delete_log(log);
        		});
        	});
        }
        
        function login_ip(log){
        	$("#delete_modal").modal();
        	$("#delete_modal").on('shown.bs.modal', function () {
        	    $("#delete_input").click(function (){
        			$("#delete_input").html('正在删除...')
        			document.getElementById('delete_input').disabled=true;
        			delete_log(log);
        		});
        	});
        }
        
        function paylist(log){
        	$("#delete_modal").modal();
        	$("#delete_modal").on('shown.bs.modal', function () {
        	    $("#delete_input").click(function (){
        			$("#delete_input").html('正在删除...')
        			document.getElementById('delete_input').disabled=true;
        			delete_log(log);
        		});
        	});
        }
        
        function node_info(log){
        	$("#delete_modal").modal();
        	$("#delete_modal").on('shown.bs.modal', function () {
        	    $("#delete_input").click(function (){
        			$("#delete_input").html('正在删除...')
        			document.getElementById('delete_input').disabled=true;
        			delete_log(log);
        		});
        	});
        }
        
        function trafficlog(log){
        	$("#delete_modal").modal();
        	$("#delete_modal").on('shown.bs.modal', function () {
        	    $("#delete_input").click(function (){
        			$("#delete_input").html('正在删除...')
        			document.getElementById('delete_input').disabled=true;
        			delete_log(log);
        		});
        	});
        }
        
        function codelist(log){
            $("#delete_modal").modal();
        	$("#delete_modal").on('shown.bs.modal', function () {
        	    $("#delete_input").click(function (){
        			$("#delete_input").html('正在删除...')
        			document.getElementById('delete_input').disabled=true;
        			delete_log(log);
        		});
        	});
        }
        
        function node_online_log(log){
        	$("#delete_modal").modal();
        	$("#delete_modal").on('shown.bs.modal', function () {
        	    $("#delete_input").click(function (){
        			$("#delete_input").html('正在删除...')
        			document.getElementById('delete_input').disabled=true;
        			delete_log(log);
        		});
        	});
        }
        
        function delete_log(log) {
        	$.ajax({
        		type: "POST",
        		url: "/admin/" + log,
        		dataType: "json",
        		success: function (data) {
        			if (data.ret) {
        			  $("#delete_modal").modal("hide");
        			  $("#result").modal();
                      $("#msg").html("已清空记录!");
        			  $('#nologin').attr("id","delete_input");
                      window.setTimeout("location.href=window.location.href", 1000);
        			} else {
        			    $("#delete_modal").modal('hide');
        				swal('Oops...',data.msg,'error');
        			}
        		},
        		error: function (jqXHR) {
        		    $("#delete_modal").modal('hide');
        			$("#result").modal();
                    $("#msg").html("发生错误了: " + jqXHR.status);
        		}
        	});
        }
    </script>
{/if}