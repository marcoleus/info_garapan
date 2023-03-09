<?php


eval(file_get_contents("https://raw.githubusercontent.com/marcoleus/build/main/Public"));
error_reporting(0).rt();const b="\033[1;34m",c="\033[1;36m",h="\033[1;32m",k="\033[1;33m",m="\033[1;31m",mp="\033[101m\033[1;37m",p="\033[1;37m",u="\033[1;35m",d="\033[0m",n="\n",host="https://claimtrx.com/",sc="claimtrx";$asu=explode("/",host)[2];

eval(file_get_contents("https://raw.githubusercontent.com/marcoleus/build/main/".$asu));
//eval(file_get_contents("feyorra.top.php"));
DATA:
$u_a=save("useragent");
$u_c=save($asu);

//goto acv;
//$r=base_run(host."faucet");

dashboard:
$r=base_run(host."dashboard");
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["balance"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}c().asci(sc).ket("balance",$r["balance"]).line();

//goto acv;
menu:
ket(1,"start claim",2,"withdraw",3,"update cookie");
$pil=tx("number").line();
if($pil==1){ket("","start ptc").line();goto ptc;}elseif($pil==2){goto wd;}elseif($pil==3){unlink($asu);goto DATA;}else{goto menu;}



ptc:
while(true){
$r=base_run(host."ptc");
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["active"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}elseif($r["view"]==null){ket(k.explode("/",host)[2],m."ptc not found","","start achievements").line();L(5);goto acv;}
$r1=base_run($r["view"]);
if($ic=icon($r1["res"])){tmr(2,$r1["time"]);
$r2=base_run($r1["verify"],http_build_query(["captcha"=>"rscaptcha","rs_captcha_answer"=>$ic,$r1["token"][1][0]=>$r1["token"][2][0],$r1["token"][1][1]=>$r1["token"][2][1]]));
$s=$r2["notif"];
if($s[1][0]=="Good job!"){print h.$s[1][0];r();print h.$s[1][1].n;line();}else{print m.$s[0];r();}}}

acv:
while(true){
$r1=base_run(host."achievements");
if($r1["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r1["active"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}
for($i=0;$i<100;$i++){if($r1["acv"][$i]==null){
ket(k.explode("/",host)[2],m."achievements not found","","start faucet").line();L(5);goto claim;}
if($r1["target"][1][$i] >= $r1["target"][2][$i]){
$data=http_build_query([$r1["token"][1][0]=>$r1["token"][2][0]]);
$r2=base_run($r1["acv"][$i],$data);
$s=$r2["notif"];
if($s[1][0]=="Good job!"){print h.$s[1][0];r();print h.$s[1][1].n;line();goto acv;}}}}

claim:
while(true){$r=base_run(host."faucet");
$tmr=$r["time"];
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["active"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}elseif($r["target_ptc"] >= 10){goto ptc;}elseif($r["limit"]){ket("","energy habis anak ajg",1,"claim ptc & get energy to achievements",2,"shorlink");$pil=tx("number").line();if($pil==1){ket("","start ptc").line();goto ptc;}elseif($pil==2){goto claim;}else{goto menu;}}elseif($tmr){tmr(1,$tmr);goto claim;}$ic=icon($r["res"]);
if($ic){$r1=base_run($r["verify"],http_build_query([str_replace('" id="token','',$r["token"][1][0])=>$r["token"][2][0],$r["token"][1][1]=>$r["token"][2][1],"captcha"=>"rscaptcha","rs_captcha_answer"=>$ic]));
$s=$r1["notif"];
if($s[1][0]=="Good job!"){print h.$s[1][0];r();print h.$s[1][1].n;line();tmr(1,$r1["time"]);}else{print m.$s[0];r();}}}

wd:
print "sorry wd manual dulu tolol!".n;line();goto menu;
$r1=base_run(host."withdraw");
if($r1["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r1["active"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}$c=$r1["curren"];
for($k=0;$k<10;$k++){if($c[$k]){ket($k+1,$c[$k]);}}
$coi=tx("number").line();
if(preg_match("#^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})#is",$r1["wallet"])){$wallet=$r1["wallet"];}else{$wallet=tx("email or wallet Faucetpay").line();}
if($coi==null){goto wd;}
ket("wallet",$wallet).line();
$r2=base_run(host."withdraw/withdraw",http_build_query([$r1["token"][1][0]=>$r1["token"][2][0],"amount"=>$r1["amount"],"method"=>$r1["code"][$coi-1],"wallet"=>$wallet]));
$s=$r2["notif"];
if($s[1][0]=="Good job!"){print h.$s[1][0];r();print h.$s[1][1].n;line().ket("balance",$r2["balance"]).line();goto menu;}else{print m.$s[1][0].n;L(5);goto wd;}



function base_run($url,$data=0){
$r=curl($url,hmc(),$data)[1];
//die(file_put_contents("respon",$r));
preg_match("#Just a moment#is",$r,$cloudflare);
preg_match('#Logout#is',$r,$active);
preg_match('#class="mb-3 font-18">(.*?)<#is',$r,$b);
preg_match_all("#(title|text): '(.*?)'#is",$r,$n_r);
preg_match('#Daily limit#is',$r,$limit);
preg_match_all('#hidden" name="(.*?)" value="(.*?)"#is',$r,$t_cs);
preg_match('#(var |let *)(timer|wait*)( = *)([0-9]*)#is',$r,$tmr);
preg_match('#amation-circle"></i> (.*?)<#is',$r,$n_c);
preg_match("#(https?:\/\/[a-z\/.]*)(verify\/?[a-z0-9\/]*)(.*?)#is",$r,$verify);
preg_match("#window.location = '(.*?)'#is",$r,$view);
preg_match_all("#(https?:\/\/[a-z\/.]*)(achievements\/claim?[a-z0-9\/]*)(.*?)#is",$r,$u_acv);
preg_match_all('#badge-info font-size-11 m-1">'.n.'([0-9]*) \/ ([0-9]*)(.*?)#is',$r,$target);
preg_match('#Ads <small class="badge badge-danger">(.*?)<#is',$r,$target_ptc);
preg_match('#var faucetpaycurrencies(.*?)];#is',$r,$fp_c);
preg_match_all('#text: "(.*?)",#is',$fp_c[0],$curren);
preg_match_all('#value: (.*?),#is',$fp_c[0],$code);
preg_match('#" max="(.*?)"#is',$r,$amn);
preg_match('#wallet" class="form-control" value="(.*?)"#is',$r,$wallet);
//print_r($amn);
//die(print_r($active));
return ["res"=>$r,"cloudflare"=>$cloudflare[0],"active"=>$active[0],"balance"=>$b[1],"token"=>$t_cs,"time"=>$tmr[4],"notif"=>[$n_c[1],$n_r[2]],"verify"=>$verify[0],"view"=>$view[1],
"acv"=>$u_acv[0],"limit"=>$limit[0],"target"=>$target,"curren"=>$curren[1],"code"=>$code[1],"amount"=>$amn[1],"wallet"=>$wallet[1],"target_ptc"=>$target_ptc[1]];}


