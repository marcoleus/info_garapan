<?php


eval(file_get_contents("https://raw.githubusercontent.com/marcoleus/build/main/Public"));
error_reporting(0).rt();const b="\033[1;34m",c="\033[1;36m",h="\033[1;32m",k="\033[1;33m",m="\033[1;31m",mp="\033[101m\033[1;37m",p="\033[1;37m",u="\033[1;35m",d="\033[0m",n="\n",host="https://soltoshindo.com/member/",sc="soltoshindo";$asu=explode("/",host)[2];
$disable=["c"];



DATA:
$u_a=save("useragent");
$u_c=save($asu);

$r=base_run(host."dashboard");
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}elseif(preg_match("#([a-zA-Z0-9.]*)(@gmail.com|@yahoo.com)#is",$r["email"][2])==null){die(m."tambahkan email faucetpay dulu awokawokawok".n);}c().asci(sc).ket($r["email"][1],$r["email"][2],"username",$r["username"],"balance",$r["balance"]).line();

menu:
ket(1,"start all claim",2,"withdraw",3,"update cookie");
$pil=tx("number").line();
if($pil==1){ket("","start shorlink").line();goto sl;}elseif($pil==2){goto wd;}elseif($pil==3){unlink($asu);goto DATA;}else{goto menu;}



sl:
while(true){$r1=base_run(host."links");
if($r1["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r1["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}
$re=find($r1["host"],$r1["go"],$r1["left"]);
//die($r1["host"][$re["no"]]);
if($re["data"]==null){ket(k.explode("/",host)[2],m."target shorlink not found","","start achievements").line();L(5);goto acv;}
//$data=http_build_query([str_replace('" id="token','',$r1["token"][1][0])=>$r1["token"][2][0]]);
//$data=http_build_query([$r1["token"][1][$re["no"]]=>$r1["token"][2][$re["no"]]]);
$go=curl($re["go"],hmc());
//die($go[1]);
$link=valid($go[0]);
if($link==0){goto sl;}
$r2=base_run($link)["res"];
preg_match("#title: `(.*?)`#is",$r2,$s);
preg_match("#html: `(.*?)`#is",$r2,$s1);
if($s[1]=='Success!'){
print h.$s[1]." ".$s1[1].n;line();
}else{print m."invalid key";r();}}


acv:
while(true){
$r1=base_run(host."dashboard");
if($r1["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r1["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}elseif($r1["target"][2] >= $r1["target"][4]){
$data=http_build_query([str_replace('" id="token','',$r1["token"][1][0])=>$r1["token"][2][0]]);
$r2=base_run($r1["acv"],$data)["res"];
preg_match("#title: `(.*?)`#is",$r2,$s);
preg_match("#html: `(.*?)`#is",$r2,$s1);
if($s[1]=='Success!'){print h.$s[1];r();
print h.$s1[1].n;line();}}else{ket(k.explode("/",host)[2],m."achievements not found","","start autofaucet").line();L(5);goto auto;}}

auto:
while(true){
$r1=base_run(host."auto");
//die(print_r($r1["verify"]));
if($r1["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r1["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}elseif($r1["time"]){tmr(2,$r1["time"]);
$data=http_build_query([$r1["token"][1][0]=>$r1["token"][2][0]]);
$r2=base_run($r1["verify"],$data)["res"];
preg_match("#title: `(.*?)`#is",$r2,$s);
preg_match("#html: `(.*?)`#is",$r2,$s1);
if($s[1]=='Success!'){print h.$s[1];r();
print h.$s1[1].n;line();
}else{lah(1);goto menu;}}}

wd:
$r1=base_run(host."dashboard");
if($r1["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r1["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}
preg_match_all('#<option value="(.*?)"><b>(.*?)</b>(.*?)</option>#is',$r1["res"],$c);
for($k=0;$k<10;$k++){if($c[1][$k]){ket($k+1,$c[2][$k].$c[3][$k]);}}
$coi=tx("number").line();
if($coi==null){goto wd;}
$data=http_build_query([str_replace('" id="token','',$r1["token"][1][0])=>$r1["token"][2][0],$r1["token"][1][1]=>$r1["token"][2][1],"amount"=>explode(" ",$r1["balance"])[0],"currency"=>$c[1][$coi-1]]);
$r2=base_run(host."withdraw",$data)["res"];
preg_match("#title: `(.*?)`#is",$r2,$s);
preg_match("#html: `(.*?)`#is",$r2,$s1);
if($s[1]=='Success!'){print h.$s[1]." ".$s1[1].n;line();goto menu;}else{print m.$s1[1].n;L(5);goto wd;}


function base_run($url,$data=0){
$r=curl($url,hmc(),$data)[1];
//die(file_put_contents("sol.html",$r));
preg_match("#Just a moment#is",$r,$cf);
preg_match("#(https?:\/\/[a-z\/.]*)(achievement\/?[a-z0-9\/]*)(.*?)#is",$r,$u_acv);
preg_match("#(https?:\/\/[a-z\/.]*)(verify\/?[a-z\/]*)(.*?)#is",$r,$verify);
preg_match_all('#text-xl text-primary">(.*?)<#is',$r,$host);
preg_match_all("#(https?:\/\/[a-zA-Z0-9\/-\/.]*)(\/go\/?[a-zA-Z0-9\/-\/.]*)(.*?)#is",$r,$go);
preg_match_all('#View?: ([0-9\/0-9]*)(.*?)#is',$r,$left);
preg_match('#placeholder="(.*?)" value="(.*?)"#is',$r,$email);
preg_match('#font-medium">(.*?)<#is',$r,$username);
preg_match_all('#leading-8 mt-6">(.*?)<#is',$r,$balance);
preg_match('#let timer = (.*?),#is',$r,$a_tmr);
preg_match_all('#hidden" name="(.*?)" value="(.*?)"#is',$r,$t_cs);
preg_match('#(aria-valuemax="100">*)([0-9]*)(.*?)\/ ([0-9]*)(.*?)#is',$r,$target);
//die(print_r($left));
return ["res"=>$r,"cloudflare"=>$cf[0],"acv"=>$u_acv[0],"verify"=>$verify[0],"email"=>$email,"username"=>$username[1],"balance"=>$balance[1][0],"host"=>$host[1],"go"=>$go[0],"left"=>$left[1],"token"=>$t_cs,"time"=>$a_tmr[1],"target"=>$target];}


