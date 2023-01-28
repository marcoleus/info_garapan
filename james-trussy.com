<?php

eval(file_get_contents("https://raw.githubusercontent.com/marcoleus/build/main/Public"));
error_reporting(0).unlink("cookie.txt").rt();const b="\033[1;34m",c="\033[1;36m",h="\033[1;32m",k="\033[1;33m",m="\033[1;31m",mp="\033[101m\033[1;37m",p="\033[1;37m",u="\033[1;35m",d="\033[0m",n="\n",host="https://james-trussy.com/",sc="james-trussy";$asu="cookie_".explode("/",host)[2];


DATA:
$u_a=save("useragent");
$u_c=save($asu);


function faucet($data=0){if($data){$v="/verify";}
$r=curl(host."faucet".$v,hmc(),$data)[1];
//die(file_put_contents("t.html",$r));
preg_match("#Just a moment#is",$r,$cf);
preg_match('#key="t-henry">(.*?)<#is',$r,$u);
preg_match_all('#token" value="(.*?)">#is',$r,$t);
preg_match('#var wait = (.*?) -#is',$r,$tmr);
preg_match_all('#(weight-bold">*)([0-9]*)(.*?)#is',$r,$left);
preg_match('#captcha.execute(.*?)"(.*?)"#is',$r,$k);
return ["res"=>$r,"cloudflare"=>$cf[1],"username"=>$u[1],"time"=>$tmr[1],"token"=>$t,"sitekey"=>$k[2],"left"=>$left[2][3]];}

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

menu:
ket(1,"autofaucet",2,"faucet",3,"update cookie");
$pil=tx("number").line();
if($pil==1){goto auto;}elseif($pil==2){goto faucet;}elseif($pil==3){unlink($asu);goto DATA;}else{goto menu;}

auto:
while(true){$r=auto();
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}
if($r["time"]){tmr(2,$r["time"]);
$r1=auto(http_build_query(["token"=>$r["token"]]))["res"];
preg_match("#Swal.fire(.*?)'(.*?)', '(.*?)', '#is",$r1,$s);
if($s[2]=="Good job!"){print h.$s[2]." ".$s[3].n;line();}}else{lah(1);goto menu;}}


faucet:
while(true){$r=faucet();$tmr=$r["time"];
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($tmr){tmr(1,$tmr);goto faucet;}elseif($r["left"]==0){die(m."faucet habis tolol".n);}

$rrep=anchor(host."faucet",$r["sitekey"]);
if($rrep==null){goto faucet;}
$data=http_build_query([
"csrf_token_name"=>$r["token"][1][0],
"token"=>$r["token"][1][1],
"captcha"=>"recaptchav3",
"recaptchav3"=>$rrep,
"g-recaptcha-response"=>""]);

$r1=faucet($data);
preg_match('#amation-circle"></i> (.*?)<#is',$r1["res"],$inv);
preg_match("#Swal.fire(.*?)'(.*?)', '(.*?)', '#is",$r1["res"],$out);
if($out[2]=="Good job!"){print h.$out[2];r();print h.$out[3].n;line();tmr(1,$r1["time"]);}else{print m.$inv[1];r();}}

function anchor($site_url,$sitekey){
$host="https://www.google.com/recaptcha/";
$hash=str_replace("=",".",base64_encode("https://".explode("/",host)[2].":443"));
date_default_timezone_set('UTC');
//$exp="cookie:".http_build_query(["1P_JAR"=>date("Y-m-d-i")]);



$exp="cookie:_GRECAPTCHA=09AOOcfws-8NZKoyCRB6Kx40RtVE4tqdU7fLB-Ke4jd6CX-CdM1_AOC8DW6kPeyFUQQKs0sO0tEMdHTegWQjk7Ono;".http_build_query(["1P_JAR"=>date("Y-m-d-i")]).";NID=511=Z0wFppuQI0CQm261gdL88g1H36GCmzsZ7KFjZn4s4yTVLj7cm0jFeaz_N8kp-86999xlwQJgdc9apus35N2Kk5nltKu1qAKQKqiJJWSemdlPyD_nS8REj8BrEdLya_hRnqoyE29vbzF5yw4EdBw4KchpAkF_AwvJNXO08qNU_FQ";






//$exp="cookie:_GRECAPTCHA=09AOOcfws-8NZKoyCRB6Kx40RtVE4tqdU7fLB-Ke4jd6CX-CdM1_AOC8DW6kPeyFUQQKs0sO0tEMdHTegWQjk7Ono;1P_JAR=2023-01-27-17;NID=511=Z0wFppuQI0CQm261gdL88g1H36GCmzsZ7KFjZn4s4yTVLj7cm0jFeaz_N8kp-86999xlwQJgdc9apus35N2Kk5nltKu1qAKQKqiJJWSemdlPyD_nS8REj8BrEdLya_hRnqoyE29vbzF5yw4EdBw4KchpAkF_AwvJNXO08qNU_FQ";

$h1=array("Host:".explode("/",$host)[2],"accept:*/*","referer:".$site_url,"accept-language:id,id-ID;q=0.9,en-US;q=0.8,en;q=0.7",$exp);
$render=curl($host."api.js?render=".$sitekey,$h1)[1];
preg_match('#/releases/(.*?)/#is',$render,$v);


$u_anchor=$host."api2/anchor?ar=1&k=".$sitekey."&co=".$hash."&hl=".["id","en"][rand(0,1)]."&v=".$v[1]."&size=invisible&cb=".substr(str_shuffle("0123456789abcdefghijklmnopqrstuvwxyz"),0,12);

$h2=array("Host:".explode("/",$host)[2],"accept:text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9","referer:".$site_url,"accept-language:id,id-ID;q=0.9,en-US;q=0.8,en;q=0.7",$exp);
$anchor=curl($u_anchor,$h2)[1];
preg_match('#token" value="(.*?)"#is',$anchor,$token);


$h3=array("Host:".explode("/",$host)[2],"accept:*/*","origin:https://".explode("/",$host)[2],
"referer:".$u_anchor,
"accept-language: id,id-ID;q=0.9,en-US;q=0.8,en;q=0.7",$exp);

$data=str_replace("version3","v",http_build_query(["version3"=>$v[1],"reason"=>"q","c"=>$token[1],"v"=>$v[1],"co"=>$hash]));
$reload=curl($host."api2/reload?k=".$sitekey,$h3,$data)[1];
preg_match('#rresp","(.*?)"#is',$reload,$bypas);
if($bypas[1]){return $bypas[1];}}



