<?php

eval(file_get_contents("https://raw.githubusercontent.com/marcoleus/build/main/Public"));
error_reporting(0).unlink("cookie.txt").rt();const b="\033[1;34m",c="\033[1;36m",h="\033[1;32m",k="\033[1;33m",m="\033[1;31m",mp="\033[101m\033[1;37m",p="\033[1;37m",u="\033[1;35m",d="\033[0m",n="\n",host="https://best-shopme.com/",sc="best-shopme";$asu="cookie_".explode("/",host)[2];
$disable=["linkfly"];

DATA:
$u_a=save("useragent");
$u_c=save($asu);

function sl($x,$data=0){
if($x==0){$r=curl(host."shortlinks.html",hmc())[1];}
elseif($x==1){$r=curl($data,hmc(1))[1];}
elseif($x==2){$r=curl(host."system/ajax.php",hmc(1),$data)[1];}
preg_match("#Just a moment#is",$r,$cf);
preg_match('#text-success">(.*?)<#is',$r,$u);
preg_match('#sidebarCoins">(.*?)</b> (.*?) <small class="text-success">(.*?)<#is',$r,$b);
preg_match('#text-success"><b>(.*?)<#is',$r,$b1);
preg_match("#([a-z0-9]{64})#is",$r,$t);
preg_match_all('#_blank" href="//(.*?)">(.*?)<#is',$r,$host);
preg_match_all('#   </p>(.*?)" class=#is',$r,$go);
//die(file_put_contents("t.html",$r));
//die(print_r($host));

preg_match_all('#fas fa-eye"></i> (.*?)<#is',$r,$left);
preg_match('#success mt-0" role="alert">(.*?)<#is',$r,$n);
return ["res"=>$r,"cloudflare"=>$cf[0],"username"=>$u[1],"balance"=>$b[1]." and ".$b1[1],"token"=>$t[1],"host"=>$host[2],"left"=>$left[1],"go"=>$go[1],"links"=>json_decode($r)->shortlink,"notif"=>$n[1]];}


function auto($x,$data=0){
if($x==0){$r=curl(host."faucet.html",hmc())[1];}
elseif($x==1){$r=curl(host."faucet/claim.html",hmc())[1];}
elseif($x==2){$r=curl(host."system/ajax.php?".$data,hmc(1))[1];}
elseif($x==3){$r=curl(host."system/ajax.php",hmc(1),$data)[1];}
preg_match("#Just a moment#is",$r,$cf);
preg_match('#text-success">(.*?)<#is',$r,$u);
preg_match('#sidebarCoins">(.*?)</b> (.*?) <small class="text-success">(.*?)<#is',$r,$b);
preg_match('#text-success"><b>(.*?)<#is',$r,$b1);
preg_match('#id="time">(.*?)<#is',$r,$tmr);
preg_match_all("#([a-z0-9]{64})#is",$r,$t);
preg_match('#\\\"><\\\/i> (.*?)!#is',$r,$n);
return ["res"=>$r,"cloudflare"=>$cf[0],"username"=>$u[1],"balance"=>$b[1].$b[2].$b[3]." and ".$b1[1],"token"=>$t[1][1],"time"=>$tmr[1],"data"=>json_decode($r),"notif"=>$n[1]];}

$r=sl(0);
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}c().asci(sc).ket("username",$r["username"],"balance",$r["balance"]).line();

menu:
ket(1,"auto bits",2,"shorlink");
$pil=tx("number").line();
if($pil==1){goto auto;}elseif($pil==2){goto shorlink;}else{goto menu;}

auto:
$r=auto(0);
preg_match_all('#id="auto-frequency" value="(.*?)"> (.*?)<#is',$r["res"],$m);
preg_match_all('#id="auto-boost" value="(.*?)"> (.*?)<#is',$r["res"],$b);
a:
print p."-> Timer".n;
for($t=0;$t<30;$t++){if($m[2][$t]){
ket($t+1,trim($m[2][$t]));}}
$min=tx("number").line();
$minute=$m[1][$min-1];
if($minute==null){goto a;}
b:
print p."-> Payment Boost".n;
for($t=0;$t<30;$t++){if($b[2][$t]){
ket($t+1,trim($b[2][$t]));}}
$bos=tx("number").line();
$boost=$b[1][$bos-1];
if($boost==null){goto b;}
$data=http_build_query(["a"=>"startClaim","autoToken"=>$r["token"],"payout"=>1,"frequency"=>$minute,"boost"=>$boost]);
$r3=auto(3,$data);
if($r3["data"]->status==200){
while(true){$r4=auto(1);
if($r4["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r4["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}
$tmr=$r4["time"];
ket("balance",$r4["balance"]).line();
if($tmr){tmr(2,explode(":",$tmr)[0]*60+explode(":",$tmr)[1]);}
$data=http_build_query(["a"=>"validateClaim","autoToken"=>$r4["token"]]);
$r5=auto(3,$data);
if($r5["data"]->status==200){
print h.$r5["notif"].n;line();}
elseif($r5["data"]->status==null){goto menu;}}}else{print m.$r3["notif"].n;goto menu;}


shorlink:
while(true){$r=sl(0);
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}
$re=find($r["host"],$r["go"],$r["left"]);
if($re["data"]==null){lah();tmr(1,60*60*8+60);goto shorlink;}
$data=http_build_query(["a"=>"getShortlink","data"=>$re["data"],"token"=>$r["token"]]);
$go=sl(2,$data)["links"];
if($go){$link=valid($go);
if($link==0){goto shorlink;}
$rw=sl(1,$link)["notif"];
if($rw){print h.$rw.n;line().ket("balance",sl(0)["balance"]).line();}}}
