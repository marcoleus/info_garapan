<?php

eval(file_get_contents("https://raw.githubusercontent.com/marcoleus/build/main/Public"));
error_reporting(0).unlink("cookie.txt").rt();const b="\033[1;34m",c="\033[1;36m",h="\033[1;32m",k="\033[1;33m",m="\033[1;31m",mp="\033[101m\033[1;37m",p="\033[1;37m",u="\033[1;35m",d="\033[0m",n="\n",host="https://accessonto.com/",sc="accessonto";$asu="cookie_".explode("/",host)[2];
$disable=["clicksfly"];

DATA:
$u_a=save("useragent");
$u_c=save($asu);
sl();
function sl($byp=0){if($byp){$r=curl($byp,hmc())[1];}else{$r=curl(host."links",hmc())[1];}
preg_match("#Just a moment#is",$r,$cf);
preg_match('#key="t-henry">(.*?)<#is',$r,$u);
preg_match_all('#class="card-title mt-0">(.*?)<#is',$r,$host);
preg_match_all("#(https?:\/\/[a-zA-Z0-9\/-\/.]*)(\/go\/?[a-zA-Z0-9\/-\/.]*)(.*?)#is",$r,$go);
preg_match_all('#Claim <span class="badge badge-info">([0-9\/0-9]*)(.*?)#is',$r,$left);
return ["res"=>$r,"cloudflare"=>$cf[0],"username"=>$u[1],"go"=>$go[0],"host"=>$host[1],"left"=>$left[1]];}

function dashboard(){
$r=curl(host."dashboard",hmc())[1];
preg_match("#Just a moment#is",$r,$cf);
preg_match('#key="t-henry">(.*?)<#is',$r,$u);
preg_match_all('#<h4 class="mb-0">(.*?)<#is',$r,$b);
return ["res"=>$r,"cloudflare"=>$cf[0],"username"=>$u[1],"balance"=>$b[1][0],"energy"=>$b[1][1]];}

function auto($data=0){if($data){$v="/verify";}
$r=curl(host."auto".$v,hmc(),$data)[1];
preg_match("#Just a moment#is",$r,$cf);
preg_match('#key="t-henry">(.*?)<#is',$r,$u);
preg_match('#token" value="(.*?)"#is',$r,$t);
preg_match('#let timer = (.*?),#is',$r,$tmr);
return ["res"=>$r,"cloudflare"=>$cf[0],"username"=>$u[1],"token"=>$t[1],"time"=>$tmr[1]];}

$r=dashboard();
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}c().asci(sc).ket("username",$r["username"],"balance",$r["balance"],"energy",$r["energy"]).line();

menu:
ket(1,"auto faucet",2,"shorlink");
$pil=tx("number").line();
if($pil==1){goto auto;}elseif($pil==2){goto shorlink;}else{goto menu;}

auto:
while(true){$r=auto();
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}
if($r["time"]){tmr(2,$r["time"]);
$r1=auto(http_build_query(["token"=>$r["token"]]))["res"];
preg_match("#Swal.fire(.*?)'(.*?)', '(.*?)', '#is",$r1,$s);
if($s[2]=="Good job!"){print h.$s[2]." ".$s[3].n;line();}}else{print m."sorry no energy".n;goto menu;}}

shorlink:
while(true){$r=sl();
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}
$re=find($r["host"],$r["go"],$r["left"]);
if($re["data"]==null){print m."bypass all shorlink fly family success".n;goto menu;}
$go=curl(str_replace("pre_verify","go",$re["go"]),hmc());
$link=valid($go[0]);
if($link==0){goto shorlink;}
$r1=sl($link)["res"];
preg_match("#Swal.fire(.*?)'(.*?)', '(.*?)', '#is",$r1,$s);
if($s[2]=="Good job!"){print h.$s[2]." ".$s[3].n;line();}else{print m."invalid key";r();}}




