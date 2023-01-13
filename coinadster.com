<?php

eval(file_get_contents("https://raw.githubusercontent.com/marcoleus/build/main/Public"));
error_reporting(0).unlink("cookie.txt").rt();const b="\033[1;34m",c="\033[1;36m",h="\033[1;32m",k="\033[1;33m",m="\033[1;31m",mp="\033[101m\033[1;37m",p="\033[1;37m",u="\033[1;35m",d="\033[0m",n="\n",host="https://coinadster.com/",sc="coinadster";$asu="cookie_".explode("/",host)[2];$disable="n";

DATA:
$u_a=save("useragent");
$u_c=save($asu);

function sl($x,$data=0){
if($x==0){$r=curlx(host."shortlink.html",hmc());}
elseif($x==1){$r=curlx($data,hmc(1));}
elseif($x==2){$r=curlx(host."system/libs/captcha/request.php",hmc(1),$data);}
elseif($x==3){$r=curlx(host."system/ajax.php",hmc(1),$data);}

preg_match("#Just a moment#is",$r,$cf);
preg_match('#text-success">(.*?)<#is',$r,$u);
preg_match('#text-primary"><b>(.*?)<#is',$r,$b);
preg_match('#text-warning"><b>(.*?)<#is',$r,$b1);
preg_match("#([a-z0-9]{64})#is",$r,$t);
preg_match_all('#class="align-middle">(.*?)</td><td class="align-middle text-center"><b class="badge badge-dark">(.*?)</b></td><td class="align-middle text-center"><b class="badge badge-dark">(.*?)</b></td><td class="text-right"><(.*?)" class="#',$r,$tes);
preg_match('#success mt-0" role="alert">(.*?)<#is',$r,$n);

return ["res"=>$r,"cloudflare"=>$cf[0],"username"=>$u[1],"balance"=>$b[1].$b[2].$b[3]." and ".$b1[1],"token"=>$t[1],"host"=>$tes[1],"left"=>$tes[3],"go"=>$tes[4],"links"=>json_decode($r)->shortlink,"notif"=>$n[1],"antibot"=>explode('"',$r)];}

$r=sl(0);
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}c().asci(sc).ket("username",$r["username"],"balance",$r["balance"]).line();

shorlink:$x=-1;$r=sl(0);
if($r["cloudflare"]){print m.sc." cloudflare!".n;unlink($asu);goto DATA;}elseif($r["username"]==null){print m.sc." cookie expired!".n;unlink($asu);goto DATA;}
$re=find($r["host"],$r["go"],$r["left"]);
if($re["data"]==null){print m."bypass all shorlink fly family success".n;tmr(1,60*60*24);goto shorlink;}

$data=http_build_query(["cID"=>0,"rT"=>1,"tM"=>"light"]);
$ic=sl(2,$data);
xxnxcom:
while(true){$x++; $x=$x+1;
If($x==11){goto xxnxcom;}
$data=http_build_query(["cID"=>0,"pC"=>$ic["antibot"][$x],"rT"=>2]);
sl(2,$data)["res"];
$data=http_build_query([
"a"=>"getShortlink",
"data"=>$re["data"],
"token"=>$r["token"],
"captcha-idhf"=>0,
"captcha-hf"=>$ic["antibot"][$x]]);
$go=sl(3,$data)["links"];
if($go){$link=valid($go);
if($link==0){goto shorlink;}
$rw=sl(1,$link)["notif"];
if($rw){print h.$rw.n;line().ket("balance",sl(0)["balance"]).line();goto shorlink;}else{print m."invalid key";r();goto shorlink;}}}


