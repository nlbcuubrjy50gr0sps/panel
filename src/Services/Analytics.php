<?php

namespace App\Services;

use App\Models\User;
use App\Models\Node;
use App\Utils\Tools;
use App\Models\Code;

class Analytics
{
    public function getTotalUser()
    {
        return User::count();
    }

    // admin 财务
    public function getFinanceToday($type)
    {
        $codes = Code::whereDate('usedatetime', '=', date('Y-m-d'))->where("type", "-1")->where("isused", 1)->get();
		$result = array();
		$result["count"]=0;
		$result["total"]=0.00;
		foreach($codes as $code){
			$result["count"]+=1;
			$result["total"]+=$code['number'];
		}
       if ($type == "count") {
       return $result["count"];
       }else{
       return $result["total"];
       }
    }

 	public function getFinanceYesterday($type)
    {

        $codes = Code::whereDate('usedatetime', '=', date('Y-m-d',strtotime('-1 days')))->where("type", "-1")->where("isused", 1)->get();
        
		$result = array();
		$result["count"]=0;
		$result["total"]=0.00;
		foreach($codes as $code){
			$result["count"]+=1;
			$result["total"]+=$code['number'];
		}
       if ($type == "count") {
       return $result["count"];
       }else{
       return $result["total"];
       }
    }
    
    public function getFinanceWeek($type)
    {
        $codes = Code::whereDate('usedatetime', '>=', date('Y-m-d',strtotime('-7 days')))->whereDate('usedatetime', '<', date('Y-m-d'))->where("type", "-1")->where("isused", 1)->get();
		$result = array();
		$result["count"]=0;
		$result["total"]=0.00;
		foreach($codes as $code){
			$result["count"]+=1;
			$result["total"]+=$code['number'];
		}
       if ($type == "count") {
       return $result["count"];
       }else{
       return $result["total"];
       }
    }
    
    public function getFinanceMonth($type)
    {

		$codes = Code::whereMonth('usedatetime', '=', date('m',strtotime('last month')))->where("type", "-1")->where("isused", 1)->get();
		
		$result = array();
		$result["count"]=0;
		$result["total"]=0.00;
		foreach($codes as $code){
			$result["count"]+=1;
			$result["total"]+=$code['number'];
		}
       if ($type == "count") {
       return $result["count"];
       }else{
       return $result["total"];
       }
    }
    
    // 人数
    public function getUserNumToday()
    {
		$users = User::whereDate('reg_date', '=', date('Y-m-d'))->where("is_admin", 0)->get();
		$result=0;
		foreach($users as $user){
			$result+=1;
		}
       return $result;
    }
    
    public function getUserNumYesterday()
    {
		$users = User::whereDate('reg_date', '=', date('Y-m-d',strtotime('-1 days')))->where("is_admin", 0)->get();
		$result=0;
		foreach($users as $user){
			$result+=1;
		}
       return $result;
    }
    
    public function getUserNumWeek()
    {
		$users = User::whereDate('reg_date', '>=', date('Y-m-d',strtotime('-7 days')))->whereDate('reg_date', '<', date('Y-m-d'))->where("is_admin", 0)->get();
		$result=0;
		foreach($users as $user){
			$result+=1;
		}
       return $result;
    }
    
    public function getUserNumMonth()
    {
		$users = User::whereMonth('reg_date', '=', date('m',strtotime('last month')))->get();
		
		$result=0;
		foreach($users as $user){
			$result+=1;
		}
       return $result;
    }
    
    public function getUserClassExp($type)
    {
        if ($type=="expire_in"){
			$users = User::whereDate('expire_in', '>=', date('Y-m-d',time()))->whereDate('expire_in', '<=', date('Y-m-d',strtotime('+7 days')))->count();

        }elseif($type=="class_expire"){
			$users = User::whereDate('class_expire', '>=', date('Y-m-d',time()))->whereDate('class_expire', '<=', date('Y-m-d',strtotime('+7 days')))->count();

        }

        return $users;
    }
    
    public function getUserPayNum($type)
    {
        $result = array();
        $result["nopay"] = User::where("class","=", 0)->where("transfer_enable", ">", 1024)->where("is_admin", "<>", 1)->count();
        $result["yespay"] = User::where("class",">", 0)->where("is_admin", "<>", 1)->count();
        if ($type == "nopay") {
        return $result["nopay"];
        }else {
        return $result["yespay"];
        }
    }
    
    // 到此结束

    public function getCheckinUser()
    {
        return User::where('last_check_in_time', '>', 0)->count();
    }

    public function getTodayCheckinUser()
    {
        return User::where('last_check_in_time', '>', strtotime('today'))->count();
    }

    public function getTrafficUsage()
    {
        $total = User::sum('u') + User::sum('d');
        return Tools::flowAutoShow($total);
    }

    public function getTodayTrafficUsage()
    {
        $total = User::sum('u') + User::sum('d') - User::sum('last_day_t');
        return Tools::flowAutoShow($total);
    }


    public function getRawTodayTrafficUsage()
    {
        return User::sum('u') + User::sum('d') - User::sum('last_day_t');
    }

    public function getLastTrafficUsage()
    {
        $total = User::sum('last_day_t');
        return Tools::flowAutoShow($total);
    }


    public function getRawLastTrafficUsage()
    {
        return User::sum('last_day_t');
    }

    public function getUnusedTrafficUsage()
    {
        $total = User::sum('transfer_enable') - User::sum('u') - User::sum('d');
        return Tools::flowAutoShow($total);
    }

    public function getRawUnusedTrafficUsage()
    {
        return User::sum('transfer_enable') - User::sum('u') - User::sum('d');
    }


    public function getTotalTraffic()
    {
        $total = User::sum('transfer_enable');
        return Tools::flowAutoShow($total);
    }

    public function getRawTotalTraffic()
    {
        return User::sum('transfer_enable');
    }

    public function getOnlineUser($time)
    {
        $time = time() - $time;
        return User::where('t', '>', $time)->count();
    }

    public function getUnusedUser()
    {
        return User::where('t', '=', 0)->count();
    }

    public function getTotalNode()
    {
        return Node::count();
    }

    public function getTotalNodes()
    {
        return Node::where('node_heartbeat', '>', 0)->where(
            static function ($query) {
                $query->Where('sort', '=', 0)
                    ->orWhere('sort', '=', 10)
                    ->orWhere('sort', '=', 11)
                    ->orWhere('sort', '=', 12)
                    ->orWhere('sort', '=', 13);
            }
        )->count();
    }

    public function getAliveNodes()
    {
        return Node::where(
            static function ($query) {
                $query->Where('sort', '=', 0)
                    ->orWhere('sort', '=', 10)
                    ->orWhere('sort', '=', 11)
                    ->orWhere('sort', '=', 12)
                    ->orWhere('sort', '=', 13);
            }
        )->where('node_heartbeat', '>', time() - 90)->count();
    }
    
    public function getIncome($start, $end)
    {
        $sum = Code::where('usedatetime', '>=', date("Y-m-d H:i:s", $start))
        ->where('usedatetime', '<', date("Y-m-d H:i:s", $end))
        ->sum('number');
        if ($sum == null) {
            $sum = 0;
        }
        return $sum;
    }

    public function getNewUsers($start, $end)
    {
        $users = User::where('reg_date', '>=', date("Y-m-d H:i:s", $start))
        ->where('reg_date', '<', date("Y-m-d H:i:s", $end))
        ->count();
        if ($users == null) {
            $users = 0;
        }
        return $users;
    }
}
