<?php

eval(file_get_contents("https://raw.githubusercontent.com/marcoleus/build/main/Public"));
error_reporting(0).unlink("cookie.txt").rt();const b="\033[1;34m",c="\033[1;36m",h="\033[1;32m",k="\033[1;33m",m="\033[1;31m",mp="\033[101m\033[1;37m",p="\033[1;37m",u="\033[1;35m",d="\033[0m",n="\n",host="https://aearns.com/",sc="aearns";$asu="cookie_".explode("/",host)[2];
$disable=["n"];

DATA:
$u_a=save("useragent");
$u_c=save($asu);

function sl($byp=0){if($byp){$r=curl($byp,hmc())[1];}else{$r=curl(host."links",hmc())[1];}
preg_match("#Just a moment#is",$r,$cf);
preg_match('#font-medium">(.*?)<#is',$r,$u);
preg_match_all('#text-primary">(.*?)<#is',$r,$host);
preg_match_all("#(https?:\/\/[a-zA-Z0-9\/-\/.]*)(\/go\/?[a-zA-Z0-9\/-\/.]*)(.*?)#is",$r,$go);
preg_match_all('#View?: ([0-9\/0-9]*)(.*?)#is',$r,$left);
return ["res"=>$r,"cloudflare"=>$cf[0],"username"=>$u[1],"go"=>$go[0],"host"=>$host[1],"left"=>$left[1]];}

function auto($data=0){if($data){$v="/verify";}
$r=curl(host."auto".$v,hmc(),$data)[1];
preg_match("#Just a moment#is",$r,$cf);
preg_match('#font-medium">(.*?)<#is',$r,$u);
preg_match('#token" value="(.*?)"#is',$r,$t);
preg_match('#let timer = (.*?),#is',$r,$tmr);
preg_match("#Swal.fire(.*?)'(.*?)', '(.*?)', '#is",$r,$out);
return ["res"=>$r,"cloudflare"=>$cf[0],"username"=>$u[1],"token"=>$t[1],"time"=>$tmr[1],"reward"=>$out];}


function dashboard(){
$r=curl(host."dashboard",hmc())[1];
preg_match("#Just a moment#is",$r,$cf);
preg_match('#font-medium">(.*?)<#is',$r,$u);
preg_match_all('#leading-8 mt-6">(.*?)<#is',$r,$b);
preg_match_all('#token" value="(.*?)"#is',$r,$t);
return ["res"=>$r,"cloudflare"=>$cf[0],"username"=>$u[1],"balance"=>$b[1][0],"csrf"=>$t[1][0],"token"=>$t[1][1]];}




function wd($r,$coin){$data=http_build_query(["csrf_token_name"=>$r["csrf"],"token"=>$r["token"],"amount"=>str_replace("$","",$r["balance"]),"currency"=>$coin]);
return curl(host."withdraw",hmc(),$data)[1];}

$r=dashboard();
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}c().asci(sc).ket("username",$r["username"],"balance",$r["balance"]).line();

menu:
ket(1,"autofaucet",2,"shorlink",3,"withdrawal",4,"update cookie");
$pil=tx("number").line();
if($pil==1){goto auto;}elseif($pil==2){goto shorlink;}elseif($pil==3){goto wd;}elseif($pil==4){unlink($asu);goto DATA;}else{goto menu;}

auto:
while(true){$r=auto();
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}elseif($r["time"]){tmr(2,$r["time"]);
$r1=auto(http_build_query(["token"=>$r["token"]]))["res"];
preg_match("#title: '(.*?)'#is",$r1,$n);
preg_match("#html: '(.*?)'#is",$r1,$out);
if($n[1]=='Success!'){
print h.$n[1]." ".$out[1].n;line();
}}else{lah(1);goto menu;}}

wd:
$r=dashboard();
preg_match_all('#<option value="(.*?)"><b>(.*?)</b>(.*?)</option>#is',$r["res"],$c);
for($k=0;$k<10;$k++){if($c[1][$k]){ket($k+1,$c[2][$k].$c[3][$k]);}}
$coi=tx("number").line();
if($coi==null){goto wd;}
$rw=wd($r,$c[1][$coi-1]);
preg_match("#title: '(.*?)'#is",$rw,$s);
preg_match("#html: '(.*?)'#is",$rw,$s1);
if($s[1]=='Success!'){print h.$s[1]." ".$s1[1].n;line();goto menu;}else{print m.$s1[1].n;goto wd;}

shorlink:
while(true){$r=sl();
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}
$re=find($r["host"],$r["go"],$r["left"]);
if($re["data"]==null){lah();goto menu;}
$go=curl($re["go"],hmc());
$link=valid($go[0]);
if($link==0){goto shorlink;}
$r1=sl($link)["res"];
preg_match("#title: '(.*?)'#is",$r1,$n);
preg_match("#html: '(.*?)'#is",$r1,$out);
if($n[1]=='Success!'){
print h.$n[1]." ".$out[1].n;line();
}else{print m."invalid key";r();}}




