<?php


eval(file_get_contents("https://raw.githubusercontent.com/marcoleus/build/main/Public"));
error_reporting(0).rt();const b="\033[1;34m",c="\033[1;36m",h="\033[1;32m",k="\033[1;33m",m="\033[1;31m",mp="\033[101m\033[1;37m",p="\033[1;37m",u="\033[1;35m",d="\033[0m",n="\n",host="https://faucetoshi.com/",sc="faucetoshi";
$asu="cookie_".explode("/",host)[2];


DATA:
$u_a=save("useragent");
$u_c=save($asu);

function ptc($url,$data=0){
$r=curl($url,hmc(),$data)[1];
//$r=file_get_contents("t.html");
preg_match("#Just a moment#is",$r,$cf);
preg_match('#key="t-henry">(.*?)<#is',$r,$u);
preg_match("#window.location = '(.*?)'#is",$r,$go);
preg_match('#<form action="(.*?)"#is',$r,$ver);
preg_match_all('#hidden" name="(.*?)" value="(.*?)">#is',$r,$t);

preg_match('#var timer = (.*?);#is',$r,$tmr);
preg_match('#captcha.execute(.*?)"(.*?)"#is',$r,$k);
return ["res"=>$r,"cloudflare"=>$cf[1],"username"=>$u[1],"go"=>$go[1],"time"=>$tmr[1],"token"=>$t,"sitekey"=>$k[2],"verify"=>$ver[1]];}



function faucet($data=0){if($data){$v="/verify";}
$r=curl(host."faucet".$v,hmc(),$data)[1];
preg_match("#Just a moment#is",$r,$cf);
preg_match('#key="t-henry">(.*?)<#is',$r,$u);
preg_match_all('#token" value="(.*?)">#is',$r,$t);
preg_match('#var wait = (.*?) -#is',$r,$tmr);
preg_match_all('#(weight-bold">*)([0-9]*)(.*?)#is',$r,$left);
preg_match('#captcha.execute(.*?)"(.*?)"#is',$r,$k);
preg_match_all('#rel=\\\"(.*?)\\\">#is',$r,$ab);
return ["res"=>$r,"cloudflare"=>$cf[1],"username"=>$u[1],"time"=>$tmr[1],"token"=>$t,"sitekey"=>$k[2],"left"=>$left[2][3],"antb"=>antb($ab)];}





function acv($url,$data=0){
$r=curl($url,hmc(),$data)[1];
//die(file_put_contents("t.html",$r));
preg_match("#Just a moment#is",$r,$cf);
preg_match('#key="t-henry">(.*?)<#is',$r,$u);
preg_match('#(aria-valuemax="100">*)([0-9]*)(.*?)\/ ([0-9]*)(.*?)#is',$r,$get);
preg_match('#hidden" name="(.*?)" value="(.*?)">#is',$r,$t);
preg_match('#<form action="(.*?)"#is',$r,$l);
return ["res"=>$r,"cloudflare"=>$cf[1],"username"=>$u[1],"url"=>$l[1],"csrf"=>$t,"target"=>$get];}

function auto($data=0){if($data){$v="/verify";}
$r=curl(host."auto".$v,hmc(),$data)[1];
preg_match("#Just a moment#is",$r,$cf);
preg_match('#key="t-henry">(.*?)<#is',$r,$u);
preg_match('#token" value="(.*?)"#is',$r,$t);
preg_match('#let timer = (.*?),#is',$r,$tmr);
return ["res"=>$r,"cloudflare"=>$cf[0],"username"=>$u[1],"token"=>$t[1],"time"=>$tmr[1]];}

function dashboard(){
$r=curl(host."dashboard",hmc())[1];
preg_match("#Just a moment#is",$r,$cf);
preg_match('#key="t-henry">(.*?)<#is',$r,$u);
preg_match_all('#<h4 class="mb-0">(.*?)<#is',$r,$b);
return ["res"=>$r,"cloudflare"=>$cf[0],"username"=>$u[1],"balance"=>$b[1][0],"energy"=>$b[1][2]];}



$r=dashboard();
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}c().asci(sc).ket("username",$r["username"],"balance",$r["balance"]).line();
goto faucet;
menu:
ket(1,"start all claim",2,"update cookie");
$pil=tx("number").line();
if($pil==1){goto faucet;}elseif($pil==2){unlink($asu);goto DATA;}else{goto menu;}


faucet:
$r=faucet();$tmr=$r["time"];
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($tmr){tmr(1,$tmr);goto faucet;}elseif($r["left"]==0){print m."faucet habis tolol".n;L(5);goto ptc;}
$rrep=rev3(host."faucet",$r["sitekey"]);
if($rrep==null){goto faucet;}
while(true){$r=faucet();
$data=http_build_query(["antibotlinks"=>implode(" ",$r["antb"][0]),
"csrf_token_name"=>$r["token"][1][0],
"token"=>$r["token"][1][1],
"captcha"=>"recaptchav3",
"recaptchav3"=>$rrep]);
print $data.n.n;
$r1=faucet($data);
preg_match('#amation-circle"></i> (.*?)<#is',$r1["res"],$inv);
preg_match("#Swal.fire(.*?)'(.*?)', '(.*?)', '#is",$r1["res"],$s);

if($inv[1]=="Invalid Captcha"){goto faucet;}else{print m.$inv[1];r();}
if($s[2]=="Nice!"){print h.$s[2];r();print h.$s[3].n;line();tmr(1,$r1["time"]);goto faucet;}}


ptc:
while(true){$r=ptc(host."ptc");
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["go"]==null){print m."ptc habis tolol".n;L(5);goto acv;}
$r1=ptc($r["go"]);
$rrep=rev3(host."ptc",$r1["sitekey"]);
if($rrep==null){goto ptc;}
tmr(1,$r1["time"]);
$data=http_build_query(["captcha"=>"recaptchav3",
"recaptchav3"=>$rrep,
$r1["token"][1][0]=>$r1["token"][2][0],$r1["token"][1][1]=>$r1["token"][2][1]]);
$r2=ptc($r1["verify"],$data);
preg_match('#amation-circle"></i> (.*?)<#is',$r2["res"],$inv);
preg_match("#Swal.fire(.*?)'(.*?)', '(.*?)', '#is",$r2["res"],$s);
if($s[2]=="Nice!"){print h.$s[2];r();print h.$s[3].n;line();tmr(1,$r1["time"]);}else{print m.$inv[1];r();}}

acv:
while(true){
$r=acv(host."achievements");
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}
if($r["target"][2] >= $r["target"][4]){
$data=http_build_query([$r["csrf"][1]=>$r["csrf"][2]]);
$r1=acv($r["url"],$data);
preg_match("#Swal.fire(.*?)'(.*?)', '(.*?)', '#is",$r1["res"],$s);
if($s[2]=="Nice!"){print h.$s[2];r();print h.$s[3].n;line();L(5);}}else{print m."achievements habis tolol".n;L(5);goto auto;}}


auto:
while(true){$r=auto();
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}
if($r["time"]){tmr(2,$r["time"]);
$r1=auto(http_build_query(["token"=>$r["token"]]));
preg_match("#Swal.fire(.*?)'(.*?)', '(.*?)', '#is",$r1["res"],$s);
if($s[2]=="Nice!"){print h.$s[2];r();print h.$s[3].n;line();}}else{lah(1);goto menu;}}
