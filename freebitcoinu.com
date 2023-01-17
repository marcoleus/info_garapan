<?php

eval(file_get_contents("https://raw.githubusercontent.com/marcoleus/build/main/Public"));
error_reporting(0).unlink("cookie.txt").rt();const b="\033[1;34m",c="\033[1;36m",h="\033[1;32m",k="\033[1;33m",m="\033[1;31m",mp="\033[101m\033[1;37m",p="\033[1;37m",u="\033[1;35m",d="\033[0m",n="\n",host="https://freebitcoinu.com/",sc="freebitcoinu";$asu="cookie_".explode("/",host)[2];
$disable=["clicksfly"];

DATA:
$u_a=save("useragent");
$u_c=save($asu);

function sl($byp=0){if($byp){$r=curl($byp,hmc())[1];}else{$r=curl(host."links",hmc())[1];}
preg_match("#Just a moment#is",$r,$cf);
preg_match('#Balance: (.*?)<#is',$r,$b);
preg_match_all('#card-title mt-0">(.*?)<#is',$r,$host);
preg_match_all("#(https?:\/\/[a-zA-Z0-9\/-\/.]*)(\/go\/?[a-zA-Z0-9\/-\/.]*)(.*?)#is",$r,$go);
preg_match_all('#View?: ([0-9\/0-9]*)(.*?)#is',$r,$left);
return ["res"=>$r,"cloudflare"=>$cf[0],"balance"=>$b[1],"go"=>$go[0],"host"=>$host[1],"left"=>$left[1]];}

function auto($data=0){if($data){$v="/verify";}
$r=curl(host."auto".$v,hmc(),$data)[1];
preg_match("#Just a moment#is",$r,$cf);
preg_match('#Balance: (.*?)<#is',$r,$b);
preg_match('#let timer = (.*?),#is',$r,$tmr);
preg_match_all('#token" value="(.*?)"#is',$r,$t);
$tk=http_build_query(["auto_faucet_token"=>$t[1][0],"csrf_token_name"=>$t[1][1],"token"=>$t[1][2]]);
return ["res"=>$r,"cloudflare"=>$cf[0],"balance"=>$b[1],"token"=>$tk,"time"=>$tmr[1],"reward"=>$out];}

function dashboard($data=0){if($data){$r=curl(host."withdraw",hmc(),$data)[1];}else{$r=curl(host."dashboard",hmc())[1];}
preg_match("#Just a moment#is",$r,$cf);
preg_match_all('#class="fw-bold">(.*?)<#is',$r,$b);
preg_match_all('#token" value="(.*?)"#is',$r,$t);
preg_match_all('#value="(.*?)" required>#is',$r,$c);
return ["res"=>$r,"cloudflare"=>$cf[0],"balance"=>$b[1][0],"energy"=>$b[1][1],"currency"=>$c[1],"csrf"=>$t[1][0],"token"=>$t[1][1]];}




$r=dashboard();
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["balance"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}c().asci(sc).ket("balance",$r["balance"],"energy",$r["energy"]).line();

menu:
ket(1,"autofaucet",2,"shorlink",3,"withdrawal");
$pil=tx("number").line();
if($pil==1){goto auto;}elseif($pil==2){goto shorlink;}elseif($pil==3){goto wd;}else{goto menu;}



auto:
while(true){$r=auto();
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["balance"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}elseif($r["time"]){tmr(2,$r["time"]);
$r1=auto($r["token"])["res"];
preg_match("#title: '(.*?)'#is",$r1,$s);
preg_match("#html: '(.*?)'#is",$r1,$s1);
if($s[1]=='Success!'){
print h.$s[1]." ".$s1[1].n;line();
}}else{print m."sorry no energy".n;goto menu;}}



shorlink:
while(true){$r=sl();
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["balance"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}
$re=find($r["host"],$r["go"],$r["left"]);
if($re["data"]==null){print m."bypass all shorlink fly family success".n;goto menu;}
$go=curl($re["go"],hmc());
$link=valid($go[0]);
if($link==0){goto shorlink;}
$r1=sl($link)["res"];
preg_match("#title: '(.*?)'#is",$r1,$s);
preg_match("#html: '(.*?)'#is",$r1,$s1);
if($s[1]=='Success!'){
print h.$s[1]." ".$s1[1].n;line();
}else{print m."invalid key";r();}}


wd:
$r=dashboard();
$c=$r["currency"];
for($k=1;$k<10;$k++){if($c[$k]){ket($k,$c[$k]);}}
$coi=tx("number").line();
if($coi==null){goto wd;}
$data=http_build_query(["csrf_token_name"=>$r["csrf"],"token"=>$r["token"],"amount"=>explode(" ",$r["balance"])[0],"currency"=>$c[$coi]]);
$rw=dashboard($data)["res"];
preg_match("#title: '(.*?)'#is",$rw,$s);
preg_match("#html: '(.*?)'#is",$rw,$s1);
if($s[1]=='Success!'){print h.$s[1]." ".$s1[1].n;line();goto menu;}else{print m.$s1[1].n;goto wd;}
