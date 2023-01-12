<?php

eval(file_get_contents("https://raw.githubusercontent.com/marcoleus/build/main/Public"));
error_reporting(0).unlink("cookie.txt").rt();const b="\033[1;34m",c="\033[1;36m",h="\033[1;32m",k="\033[1;33m",m="\033[1;31m",mp="\033[101m\033[1;37m",p="\033[1;37m",u="\033[1;35m",d="\033[0m",n="\n",host="https://freecc.click/",sc="freecc";$disable="n";


DATA:
$u_a=save("useragent");
$u_c=save("cookie");

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
return ["res"=>$r,"cloudflare"=>$cf[0],"username"=>$u[1],"balance"=>$b[1][1],"csrf"=>$t[1][0],"token"=>$t[1][1]];}

function wd($data=0){
if($data){$w="wdfaucetpay";}else{$w="withdraw";}
$r=curl(host.$w,hmc(),$data)[1];
preg_match("#Just a moment#is",$r,$cf);
preg_match('#font-medium">(.*?)<#is',$r,$u);
preg_match('#text-success"></i>: (.*?) Coins#is',$r,$b);
preg_match_all('#token" value="(.*?)"#is',$r,$t);
return ["res"=>$r,"cloudflare"=>$cf[0],"username"=>$u[1],"balance"=>$b[1],"csrf"=>$t[1][0],"token"=>$t[1][1]];}


$r=dashboard();
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink('Cookie');goto DATA;}elseif($r["username"]==null){print m.sc." cookie expired!".n;unlink('Cookie');goto DATA;}c().asci(sc).ket("username",$r["username"],"balance",$r["balance"]).line();

menu:
ket(1,"autofaucet",2,"shorlink",3,"withdrawal");
$pil=tx("number").line();
if($pil==1){goto auto;}elseif($pil==2){goto shorlink;}elseif($pil==3){goto wd;}else{goto menu;}



auto:
while(true){$r=auto();
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink('Cookie');goto DATA;}elseif($r["username"]==null){print m.sc." cookie expired!".n;unlink('Cookie');goto DATA;}elseif($r["time"]){tmr(2,$r["time"]);
$r1=auto(http_build_query(["token"=>$r["token"]]))["res"];
preg_match("#title: `(.*?)`#is",$r1,$s);
preg_match("#html: `(.*?)`#is",$r1,$s1);
if($s[1]=='Success!'){
print h.$s[1]." ".$s1[1].n;line();
}}else{print m."sorry no energy".n;goto menu;}}


wd:
$r=wd();
preg_match_all('#<option value="(.*?)"><b>(.*?)</b>(.*?)</option>#is',$r["res"],$c);
for($k=0;$k<10;$k++){if($c[1][$k]){ket($k+1,$c[2][$k].$c[3][$k]);}}
$coi=tx("number").line();
if($coi==null){goto wd;}
$data=http_build_query(["csrf_token_name"=>$r["csrf"],"token"=>$r["token"],"method"=>"faucetpay","amount"=>$r["balance"],"currency"=>$c[1][$coi-1]]);
$r1=wd($data)["res"];
preg_match("#title: `(.*?)`#is",$r1,$s);
preg_match("#html: `(.*?)`#is",$r1,$s1);
if($s[1]=='Success!'){print h.$s[1]." ".$s1[1].n;line();goto menu;}else{print m.$s1[1].n;goto wd;}


shorlink:
while(true){$r=sl();
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink('Cookie');goto DATA;}elseif($r["username"]==null){print m.sc." cookie expired!".n;unlink('Cookie');goto DATA;}
$re=find($r["host"],str_replace("go","cancel",$r["go"]),$r["left"]);
if($re["data"]==null){print m."bypass all shorlink fly family success".n;goto menu;}
$go=curl(str_replace("go","cancel",$re["go"]),hmc());
$link=valid($go[0],1);
if($link==0){goto shorlink;}
$r1=sl($link)["res"];
preg_match("#title: `(.*?)`#is",$r1,$s);
preg_match("#html: `(.*?)`#is",$r1,$s1);
if($s[1]=='Success!'){
print h.$s[1]." ".$s1[1].n;line();
}else{print m."invalid key";r();}}
