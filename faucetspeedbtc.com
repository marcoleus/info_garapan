<?php

eval(file_get_contents("https://raw.githubusercontent.com/marcoleus/build/main/Public"));
error_reporting(0).rt();const b="\033[1;34m",c="\033[1;36m",h="\033[1;32m",k="\033[1;33m",m="\033[1;31m",mp="\033[101m\033[1;37m",p="\033[1;37m",u="\033[1;35m",d="\033[0m",n="\n",host="https://faucetspeedbtc.com/",sc="faucetspeedbtc";
$asu="cookie_".explode("/",host)[2];
$disable=["n"];

DATA:
$u_a=save("useragent");
$u_c=save("cookie");

function sl($byp=0){if($byp){$r=curl($byp,hmc())[1];}else{$r=curl(host."links",hmc())[1];}
preg_match("#Just a moment#is",$r,$cf);
preg_match("#siteUserFullName: '(.*?)<#is",$r,$u);
preg_match('#<h4 class="mb-0">(.*?)<#is',$r,$b);
preg_match_all('#card-title mt-0">(.*?)<#is',$r,$host);
preg_match_all("#(https?:\/\/[a-zA-Z0-9\/-\/.]*)(\/go\/?[a-zA-Z0-9\/-\/.]*)(.*?)#is",$r,$go);
preg_match_all('#Claim <span class="badge badge-info">([0-9\/0-9]*)(.*?)#is',$r,$left);
return ["res"=>$r,"cloudflare"=>$cf[0],"username"=>$u[1],"balance"=>$b[1],"go"=>$go[0],"host"=>$host[1],"left"=>$left[1]];}


$r=sl();
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}c().asci(sc).ket("username",$r["username"],"balance",$r["balance"]).line();


shorlink:
while(true){$r=sl();
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}
$re=find($r["host"],$r["go"],$r["left"]);
if($re["data"]==null){die(m."bypass all shorlink fly family success".n);}
$go=curl($re["go"],hmc());
$link=valid($go[1]);
if($link==0){goto shorlink;}
$r1=sl($link)["res"];
preg_match("#Swal.fire(.*?)'(.*?)', '(.*?)', '#is",$r1,$s);
if($s[2]=="Good job!"){print h.$s[2]." ".$s[3].n;line();}else{print m."invalid key";r();}}

