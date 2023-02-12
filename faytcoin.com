<?php
eval(file_get_contents("https://raw.githubusercontent.com/marcoleus/build/main/public"));
error_reporting(0).rt();const b="\033[1;34m",c="\033[1;36m",h="\033[1;32m",k="\033[1;33m",m="\033[1;31m",mp="\033[101m\033[1;37m",p="\033[1;37m",u="\033[1;35m",d="\033[0m",n="\n",host="https://faytcoin.com/",sc="faytcoin";
$asu="cookie_".explode("/",host)[2];

DATA:
$u_a=save("useragent");
$u_c=save($asu);
save("proxy");




$r=base_run(host."dashboard");
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}c().asci(sc).ket("username",$r["username"],"balance",$r["balance"]).line();

menu:
ket(1,"start all claim",2,"ptc",3,"update cookie");
$pil=tx("number").line();
if($pil==1){goto acv;}elseif($pil==2){goto ptc;}elseif($pil==3){unlink($asu);goto DATA;}else{goto menu;}

ptc:
while(true){
$r=base_run(host."ptc");
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["view"]==null){ket(k.explode("/",host)[2],m."ptc not found","","start achievements").line();L(5);goto acv;}
$r1=base_run($r["view"]);
tmr(2,$r1["time"]);
again:
$rrep=rev3(host."ptc",$r["sitekey"]);
if($rrep==null){goto ptc;}
$r2=base_run($r1["verify"],http_build_query([
"captcha"=>"recaptchav3","recaptchav3"=>$rrep,
$r1["token"][1][0]=>$r1["token"][2][0],$r1["token"][1][1]=>$r1["token"][2][1]]));
$s=$r2["notif"];
if($s[1][2]=="Good job!"){print h.$s[1][2];r();print h.$s[1][3].n;line();}else{print m.$s[0];r();goto ptc;}}



acv:
while(true){
$r1=base_run(host."achievements");
if($r1["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r1["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}
for($i=0;$i<100;$i++){if($r1["acv"][$i]==null){ket(k.explode("/",host)[2],m."achievements not found","","start autofaucet").line();L(5);goto auto;}
if($r1["target"][1][$i] >= $r1["target"][3][$i]){
$data=http_build_query([$r1["token"][1][0]=>$r1["token"][2][0]]);
$r2=base_run($r1["acv"][$i],$data);
$s=$r2["notif"];
if($s[1][2]=="Good job!"){print h.$s[1][2];r();print h.$s[1][3].n;line();goto acv;}}}}



auto:
while(true){$r=base_run(host."auto");
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}
if($r["time"]){tmr(2,$r["time"]);
$r1=base_run($r["verify"],http_build_query([$r["token"][1][0]=>$r["token"][2][0]]));
$s=$r1["notif"];
if($s[2]=="Good job!"){print h.$s[2];r();print h.$s[3].n;line();}}else{ket(k.explode("/",host)[2],m."energy not found","","start faucet").line();L(5);goto faucet;}}


faucet:
$r=base_run(host."faucet");$tmr=$r["time"];
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($tmr){tmr(1,$tmr);goto faucet;}
$rrep=rev3(host."faucet",$r["sitekey"]);
if($rrep==null){goto faucet;}
while(true){$r=base_run(host."faucet");
$data=http_build_query(["antibotlinks"=>implode(" ",$r["antb"][0]),str_replace('" id="token','',$r["token"][1][1])=>$r["token"][2][1],$r["token"][1][2]=>$r["token"][2][2],"captcha"=>"recaptchav3","recaptchav3"=>$rrep,"g-recaptcha-response"=>"","h-captcha-response"=>""]);
$r1=base_run($r["verify"],$data);
$s=$r1["notif"];
if($s[0]=="Invalid Captcha"){print m.$s[0];r();goto faucet;}elseif($s[1][2]=="Good job!"){print h.$s[1][2];r();print h.$s[1][3].n;line();tmr(1,$r1["time"]);goto faucet;}else{print m.$s[0];r();}}


function base_run($url,$data=0){
$r=curl($url,hmc(),$data)[1];
//die(file_put_contents("icon.html",$r));
preg_match("#Just a moment#is",$r,$cloudflare);
preg_match('#key="t-henry">(.*?)<#is',$r,$username);
preg_match('#<h4 class="mb-0">(.*?)<#is',$r,$balance);
preg_match_all('#hidden" name="(.*?)" value="(.*?)"#is',$r,$t_cs);
preg_match('#(let |var *)(timer|wait*)( = *)([0-9]*)#is',$r,$tmr);
preg_match('#amation-circle"></i> (.*?)<#is',$r,$n_c);
preg_match("#Swal.fire(.*?)'(.*?)', '(.*?)', '#is",$r,$n_r);
preg_match_all('#rel=\\\"(.*?)\\\">#is',$r,$ab);
preg_match("#(https?:\/\/[a-z\/.]*)(verify\/?[a-z0-9\/]*)(.*?)#is",$r,$verify);
preg_match("#window.location = '(.*?)'#is",$r,$view);
preg_match_all("#(https?:\/\/[a-z\/.]*)(achievements\/claim?[a-z0-9\/]*)(.*?)#is",$r,$u_acv);
preg_match_all('#aria-valuemax="100">([0-9]*)([ \/]*)([0-9]*)(.*?)#is',$r,$target);
//print_r($amn);
//die(print_r($target));
$k="6LeJUT8iAAAAAG5CVYgIdKLSznxFCPEXkImq8jat";
//preg_match('#captcha.execute(.*?)"(.*?)"#is',$r,$k);
return ["res"=>$r,"cloudflare"=>$cloudflare[0],"username"=>$username[1],"balance"=>$balance[1],"token"=>$t_cs,"time"=>$tmr[4],"notif"=>[$n_c[1],$n_r],"sitekey"=>$k,"antb"=>antb($ab),"verify"=>$verify[0],"view"=>$view[1],
"acv"=>$u_acv[0],"target"=>$target];}
