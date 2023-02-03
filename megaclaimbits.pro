<?php


eval(file_get_contents("https://raw.githubusercontent.com/marcoleus/build/main/Public"));
error_reporting(0).rt();const b="\033[1;34m",c="\033[1;36m",h="\033[1;32m",k="\033[1;33m",m="\033[1;31m",mp="\033[101m\033[1;37m",p="\033[1;37m",u="\033[1;35m",d="\033[0m",n="\n",host="https://megaclaimbits.pro/",sc="megaclaimbits";$asu=explode("/",host)[2];



DATA:
$u_a=save("useragent");
$u_c=save($asu);

$r=base_run(host."dashboard");
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["email"][2]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}


start:
$r1=base_run($r["auto"]);
if($r1["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif(preg_match("#Empty#is",$r1["res"])){die(m."balance tidak tersedia!".n);}c().asci(sc).ket($r["email"][1],$r["email"][2]).line();



while(true){
$r2=base_run($r["auto"]);
if($r2["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif(preg_match("#Empty#is",$r2["res"])){die(m."balance tidak tersedia!".n);}elseif($r2["auto"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}elseif($r2["time"]){tmr(2,$r2["time"]);
$data=http_build_query([$r2["token"][1]=>$r2["token"][2]]);
$r3=base_run($r2["auto"],$data)["res"];
preg_match("#title: '(.*?)'#is",$r3,$s);
preg_match("#html: '(.*?)'#is",$r3,$s1);
if($s[1]=='Success!'){print h.$s[1];r();
print h.$s1[1].n;line();
}else{print m.$s1[1];r();}}}



function base_run($url,$data=0){
$r=curl($url,hmc(),$data)[1];
//die(file_put_contents("t.html",$r));
preg_match("#Just a moment#is",$r,$cf);
preg_match('#placeholder="(.*?)" value="(.*?)"#is',$r,$e);
preg_match("#(https?:\/\/[a-z\/.]*)(auto\/?[a-z\/]*)(.*?)#is",$r,$aut);
preg_match('#let timer = (.*?),#is',$r,$tmr);
preg_match('#hidden" name="(.*?)" value="(.*?)"#is',$r,$t);
return ["res"=>$r,"cloudflare"=>$cf[0],"email"=>$e,"token"=>$t,"time"=>$tmr[1],"auto"=>$aut[0]];}


