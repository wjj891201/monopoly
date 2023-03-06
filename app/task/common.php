<?php



function get_parent($data=[],$pid=0){
    $dep = [];
    foreach($data as $k => $v){
        if($v['pid'] == $pid){
            $node=get_parent($data, $v['id']);
            array_push($dep,$v);
            if(!empty($node)){
                $dep=array_merge($dep,$node);
            }
        }
    }
    return array_values($dep);
}