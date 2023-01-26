<?php



eval(file_get_contents("https://raw.githubusercontent.com/marcoleus/build/main/Public"));
error_reporting(0).unlink("cookie.txt").rt();const b="\033[1;34m",c="\033[1;36m",h="\033[1;32m",k="\033[1;33m",m="\033[1;31m",mp="\033[101m\033[1;37m",p="\033[1;37m",u="\033[1;35m",d="\033[0m",n="\n",host="https://tokenmix.pro/",sc="tokenmix";


DATA:
$u_a=save("useragent");
$email=save("email");

$u_c=str_replace("&",";",http_build_query(["session_new"=>$email,"auto"=>json_encode(["email"=>$email,"coins"=>["usdt"],"mode"=>"multi","boost"=>"10","payout_mode"=>"balance"])]));


function auto($data=0){
$r=curl(host."user/autofaucet",hmc(),$data)[1];
preg_match("#Just a moment#is",$r,$cf);
preg_match('#(Wallet?: *)([a-zA-Z0-9]*)(.*?)#is',$r,$u);
preg_match('#(Token?: *)([0-9.,]*)(.*?)#is',$r,$b);
preg_match('#Payment every (.*?) sec#is',$r,$s);
preg_match('#t.value="(.*?)"#is',$r,$t);
return ["res"=>$r,"cloudflare"=>$cf[0],"Wallet"=>$u[2],"Token"=>$b[2],"time"=>$s[1],"data"=>$t[1]];}



$r=auto();
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["Wallet"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}c().asci(sc).ket("Wallet",$r["Wallet"],"Token",$r["Token"]).line();


auto:
while(true){$r=auto();
if($r["cloudflare"]){print m.sc." cloudflare!".n;goto DATA;}elseif($r["Wallet"]==null){print m.sc." cookie expired!".n;goto DATA;}
if($r["time"]){tmr(2,$r["time"]);
$r1=auto(http_build_query(["user"=>$r["data"]]));

preg_match('#Successfully added (.*?)<a href="/withdraw" target="_blank">(.*?)</a>#is',$r1["res"],$s);
if($s[1]){print h.$s[1].$s[2].n;line().ket("Token",$r1["Token"]).line();}}else{die(m."shortlink dulu sana!".n);}}
