<?php

namespace App\Services;

use App\Models\User;
use App\Models\DetectLog;     //DetectLog
use App\Models\NodeInfoLog;   //NodeInfoLog
use App\Models\NodeOnlineLog; //NodeOnlineLog
use App\Models\Paylist;      //Paylist
use App\Models\LoginIp;     //LoginIp
use App\Models\Code;     //LoginIp

class Anylogs
{
	
    public function getNologinUser()
    {
        return User::where('ssrlink', '=', null)->count();
    }

    public function getDetectLog()
    {
        return DetectLog::all()->count();
    }
    
    public function getNodeInfoLog()
    {
        return NodeInfoLog::all()->count();
    }
    
    public function getNodeOnlineLog()
    {
        return NodeOnlineLog::all()->count();
    }
    
    public function getPaylist()
    {
        return Paylist::where('status', 0)->count();
    }
    
    public function getCodelist()
    {
        return code::where('isused', 1)->count();
    }
    
    public function getLoginIp()
    {
        return LoginIp::all()->count();
    }
}	