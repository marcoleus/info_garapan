<?php



eval(file_get_contents("https://raw.githubusercontent.com/marcoleus/build/main/Public"));
error_reporting(0).rt();const b="\033[1;34m",c="\033[1;36m",h="\033[1;32m",k="\033[1;33m",m="\033[1;31m",mp="\033[101m\033[1;37m",p="\033[1;37m",u="\033[1;35m",d="\033[0m",n="\n",host="https://bits.re/",sc="bits";$asu=explode("/",host)[2];
eval(file_get_contents("https://raw.githubusercontent.com/marcoleus/build/main/".$asu));


$coi=1;
DATA:
$u_a=save("useragent");
$u_c=save($asu);
//$r=base_run(host."withdraw");




dashboard:
$r=base_run(host."dashboard");
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["firewal"]){$firewall=base_run(host."firewall");base_run($firewall["verify"],http_build_query(["g-recaptcha-response"=>"","captchaType"=>"recaptchav2",$firewall["token"][1][1]=>$firewall["token"][2][1]]));goto dashboard;}elseif($r["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}c().asci(sc).ket($r["email"][1],$r["email"][2],"username",$r["username"],"balance",$r["balance"]).line();
//goto acv;
menu:
ket(1,"start claim",2,"achievements",3,"withdraw",4,"update cookie");
$pil=tx("number").line();
if($pil==1){ket("","start ptc").line();goto ptc;}elseif($pil==2){goto acv;}elseif($pil==3){goto wd;}elseif($pil==4){unlink($asu);goto DATA;}else{goto menu;}



ptc:
while(true){
$r=base_run(host."ptc");
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["firewal"]){$firewall=base_run(host."firewall");base_run($firewall["verify"],http_build_query(["g-recaptcha-response"=>"","captchaType"=>"recaptchav2",$firewall["token"][1][1]=>$firewall["token"][2][1]]));goto ptc;}elseif($r["view"]==null){ket(k.explode("/",host)[2],m."ptc not found","","start faucet").line();L(5);goto claim;}
$r1=base_run($r["view"]);
if($ic=icon($r1["res"])){tmr(2,$r1["time"]);
$r2=base_run($r1["verify"],http_build_query(["captcha"=>"mooncaptchav2","answer"=>$ic,$r1["token"][1][0]=>$r1["token"][2][0],$r1["token"][1][1]=>$r1["token"][2][1]]));
if(preg_match("#Swal.fire(.*?)'(.*?)', '(.*?)', '#is",$r2["res"],$s)){print h.$s[2];r();print h.$s[3].n;line();}else{print m.$r2["notif"];r();}}}


claim:
while(true){$r=base_run(host."faucet");
$tmr=$r["time"];
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["firewal"]){$firewall=base_run(host."firewall");base_run($firewall["verify"],http_build_query(["g-recaptcha-response"=>"","captchaType"=>"recaptchav2",$firewall["token"][1][1]=>$firewall["token"][2][1]]));goto claim;}elseif($tmr){tmr(1,$tmr);goto claim;}$ic=icon($r["res"]);
if($ic){$r1=base_run($r["verify"],http_build_query([str_replace('" id="token','',$r["token"][1][0])=>$r["token"][2][0],$r["token"][1][1]=>$r["token"][2][1],"antibotlinks"=>implode(" ",$r["antb"][2]),"captcha"=>"mooncaptchav2","answer"=>$ic]));
preg_match("#Swal.fire(.*?)'(.*?)', '(.*?)', '#is",$r1["res"],$s);
if($s[2]=="Good job!"){print h.$s[2];r();print h.$s[3].n;line();tmr(1,$r1["time"]);}else{print m.$r1["notif"];r();}}}


acv:
while(true){
$r1=base_run(host."achievements");
if($r1["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r1["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}
for($i=0;$i<100;$i++){if($r1["acv"][$i]==null){ket(k.explode("/",host)[2],m."achievements not found").line();goto menu;}
if($r1["target"][2][$i] >= $r1["target"][4][$i]){
$data=http_build_query([$r1["token"][1][0]=>$r1["token"][2][0]]);
$r2=base_run($r1["acv"][$i],$data);
preg_match("#Swal.fire(.*?)'(.*?)', '(.*?)', '#is",$r2["res"],$s);
if($s[2]=="Good job!"){print h.$s[2];r();print h.$s[3].n;line();goto acv;}}}}


wd:
$r1=base_run(host."withdraw");
if($r1["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["firewal"]){$firewall=base_run(host."firewall");base_run($firewall["verify"],http_build_query(["g-recaptcha-response"=>"","captchaType"=>"recaptchav2",$firewall["token"][1][1]=>$firewall["token"][2][1]]));goto dashboard;}elseif($r1["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}$c=$r1["curren"];
for($k=0;$k<10;$k++){if($c[$k]){ket($k+1,$c[$k]);}}
$coi=tx("number").line();
$wallet=tx("email_wallet").line();
if($coi==null){goto wd;}
$r2=base_run(host."withdraw/withdraw",http_build_query([$r1["token"][1][0]=>$r1["token"][2][0],"amount"=>$r1["amount"],"method"=>$r1["code"][$coi-1],"wallet"=>$wallet]));
preg_match("#Swal.fire(.*?)'(.*?)', '(.*?)', '#is",$r2["res"],$s);
if($s[2]=="Good job!"){print h.$s[2];r();print h.$s[3].n;line();goto menu;}else{print m.$s[2].n;L(5);goto wd;}




function base_run($url,$data=0){
$r=curl($url,hmc(),$data)[1];
//die(file_put_contents("auto.html",$r));
preg_match("#Just a moment#is",$r,$cloudflare);
preg_match("#Firewall#is",$r,$firewal);
preg_match('#user-info-text">(.*?)<#is',$r,$username);
preg_match_all('#stats-title">(.*?)<#is',$r,$balance);
preg_match_all('#hidden" name="(.*?)" value="(.*?)"#is',$r,$t_cs);
preg_match('#(var *)(timer|wait*)( = *)([0-9]*)#is',$r,$tmr);
preg_match('#amation-circle"></i> (.*?)<#is',$r,$notif);
preg_match_all('#rel=\\\"(.*?)\\\">#is',$r,$ab);
preg_match("#(https?:\/\/[a-z\/.]*)(verify\/?[a-z0-9\/]*)(.*?)#is",$r,$verify);
preg_match("#window.location = '(.*?)'#is",$r,$view);
preg_match_all("#(https?:\/\/[a-z\/.]*)(achievements\/claim?[a-z0-9\/]*)(.*?)#is",$r,$u_acv);
preg_match_all('#(aria-valuemax="100">*)([0-9]*)(.*?)\/ ([0-9]*)(.*?)#is',$r,$target);

preg_match('#var faucetpaycurrencies(.*?)];#is',$r,$fp_c);
preg_match_all('#text: "(.*?)",#is',$fp_c[0],$curren);
preg_match_all('#value: (.*?),#is',$fp_c[0],$code);
preg_match('#" max="(.*?)"#is',$r,$amn);

//print_r($u_acv);
//die(print_r($amn));
return ["res"=>$r,"cloudflare"=>$cloudflare[0],"firewal"=>$firewal[0],"username"=>$username[1],"balance"=>$balance[1][0],"token"=>$t_cs,"time"=>$tmr[4],"notif"=>$notif[1],"antb"=>antb($ab),"verify"=>$verify[0],"view"=>$view[1],
"acv"=>$u_acv[0],"target"=>$target,"curren"=>$curren[1],"code"=>$code[1],"amount"=>$amn[2]];}
