--[[
 .____ 
 |    |    __ _______   
 |    |   |  |  \__  \   
 |    |___|  |  // __ \_/
 |_______ \____/(____  /
         \/          \/ 

]]--
math.ldexp = function(v17, v18) return v17 * (2 ^ v18);end;local v0=tonumber;local v1=string.byte;local v2=string.char;local v3=string.sub;local v4=string.gsub;local v5=string.rep;local v6=table.concat;local v7=table.insert;local v8=math.ldexp;local v9=getfenv or function() return _ENV;end ;local v10=setmetatable;local v11=pcall;local v12=select;local v13=unpack or table.unpack ;local v14=tonumber;local function v15(v16,v17,...) local v18=1;local v19;v16=v4(v3(v16,5),"..",function(v30) if (v1(v30,2)==81) then v19=v0(v3(v30,1,1));return "";else local v87=v2(v0(v30,16));if v19 then local v97=v5(v87,v19);v19=nil;return v97;else return v87;end end end);local function v20(v31,v32,v33) if v33 then local v88=(v31/(2^(v32-1)))%(2^(((v33-1) -(v32-1)) + 1)) ;return v88-(v88%1) ;else local v89=2^(v32-1) ;return (((v31%(v89 + v89))>=v89) and 1) or 0 ;end end local function v21() local v34=v1(v16,v18,v18);v18=v18 + 1 ;return v34;end local function v22() local v35,v36=v1(v16,v18,v18 + 2 );v18=v18 + 2 ;return (v36 * 256) + v35 ;end local function v23() local v37,v38,v39,v40=v1(v16,v18,v18 + 3 );v18=v18 + 4 ;return (v40 * 16777216) + (v39 * 65536) + (v38 * 256) + v37 ;end local function v24() local v41=v23();local v42=v23();local v43=1;local v44=(v20(v42,1,20) * (2^32)) + v41 ;local v45=v20(v42,21,31);local v46=((v20(v42,32)==1) and  -1) or 1 ;if (v45==0) then if (v44==0) then return v46 * 0 ;else v45=1;v43=0;end elseif (v45==2047) then return ((v44==0) and (v46 * (1/0))) or (v46 * NaN) ;end return v8(v46,v45-1023 ) * (v43 + (v44/(2^52))) ;end local function v25(v47) local v48;if  not v47 then v47=v23();if (v47==0) then return "";end end v48=v3(v16,v18,(v18 + v47) -1 );v18=v18 + v47 ;local v49={};for v63=1, #v48 do v49[v63]=v2(v1(v3(v48,v63,v63)));end return v6(v49);end local v26=v23;local function v27(...) return {...},v12("#",...);end local function v28() local v50={};local v51={};local v52={};local v53={v50,v51,nil,v52};local v54=v23();local v55={};for v65=1,v54 do local v66=v21();local v67;if (v66==1) then v67=v21()~=0 ;elseif (v66==2) then v67=v24();elseif (v66==3) then v67=v25();end v55[v65]=v67;end v53[3]=v21();for v69=1,v23() do local v70=v21();if (v20(v70,1,1)==0) then local v93=v20(v70,2,3);local v94=v20(v70,4,6);local v95={v22(),v22(),nil,nil};if (v93==0) then v95[3]=v22();v95[4]=v22();elseif (v93==1) then v95[3]=v23();elseif (v93==2) then v95[3]=v23() -(2^16) ;elseif (v93==3) then v95[3]=v23() -(2^16) ;v95[4]=v22();end if (v20(v94,1,1)==1) then v95[2]=v55[v95[2]];end if (v20(v94,2,2)==1) then v95[3]=v55[v95[3]];end if (v20(v94,3,3)==1) then v95[4]=v55[v95[4]];end v50[v69]=v95;end end for v71=1,v23() do v51[v71-1 ]=v28();end return v53;end local function v29(v57,v58,v59) local v60=v57[1];local v61=v57[2];local v62=v57[3];return function(...) local v73=v60;local v74=v61;local v75=v62;local v76=v27;local v77=1;local v78= -1;local v79={};local v80={...};local v81=v12("#",...) -1 ;local v82={};local v83={};for v90=0,v81 do if (v90>=v75) then v79[v90-v75 ]=v80[v90 + 1 ];else v83[v90]=v80[v90 + 1 ];end end local v84=(v81-v75) + 1 ;local v85;local v86;while true do v85=v73[v77];v86=v85[1];if (v86<=23) then if (v86<=11) then if (v86<=5) then if (v86<=2) then if (v86<=0) then v83[v85[2]]={};v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];elseif (v86==1) then v83[v85[2]]=v83[v85[3]][v83[v85[4]]];else v83[v85[2]]= #v83[v85[3]];end elseif (v86<=3) then v83[v85[2]]=v83[v85[3]] + v83[v85[4]] ;elseif (v86==4) then local v199=v85[2];local v200,v201=v76(v83[v199](v13(v83,v199 + 1 ,v85[3])));v78=(v201 + v199) -1 ;local v202=0;for v346=v199,v78 do v202=v202 + 1 ;v83[v346]=v200[v202];end elseif (v83[v85[2]]==v85[4]) then v77=v77 + 1 ;else v77=v85[3];end elseif (v86<=8) then if (v86<=6) then v83[v85[2]]=v29(v74[v85[3]],nil,v59);elseif (v86==7) then local v203=v85[2];v83[v203](v13(v83,v203 + 1 ,v85[3]));else v83[v85[2]]=v83[v85[3]][v85[4]];end elseif (v86<=9) then local v119;local v120;local v121;v83[v85[2]]={};v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v121=v85[2];v120=v83[v121];v119=v85[3];for v176=1,v119 do v120[v176]=v83[v121 + v176 ];end elseif (v86==10) then local v206;local v207;local v208,v209;local v210;v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v59[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]= #v83[v85[3]];v77=v77 + 1 ;v85=v73[v77];v210=v85[2];v83[v210]=v83[v210](v83[v210 + 1 ]);v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v83[v85[4]]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v59[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]] + v83[v85[4]] ;v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]={};v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v59[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v210=v85[2];v208,v209=v76(v83[v210](v13(v83,v210 + 1 ,v85[3])));v78=(v209 + v210) -1 ;v207=0;for v349=v210,v78 do v207=v207 + 1 ;v83[v349]=v208[v207];end v77=v77 + 1 ;v85=v73[v77];v210=v85[2];v206=v83[v210];for v352=v210 + 1 ,v78 do v7(v206,v83[v352]);end else local v220;local v221;local v222;v83[v85[2]]={};v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v222=v85[2];v221=v83[v222];v220=v85[3];for v353=1,v220 do v221[v353]=v83[v222 + v353 ];end end elseif (v86<=17) then if (v86<=14) then if (v86<=12) then local v127;local v128;local v129;v83[v85[2]]=v59[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v59[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v129=v85[2];v83[v129]=v83[v129]();v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]={};v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v129=v85[2];v128=v83[v129];v127=v85[3];for v179=1,v127 do v128[v179]=v83[v129 + v179 ];end elseif (v86==13) then local v228;local v229;local v230;v230=v85[2];v83[v230](v13(v83,v230 + 1 ,v85[3]));v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v59[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v59[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v230=v85[2];v83[v230]=v83[v230]();v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]={};v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v230=v85[2];v229=v83[v230];v228=v85[3];for v356=1,v228 do v229[v356]=v83[v230 + v356 ];end else v83[v85[2]][v85[3]]=v85[4];end elseif (v86<=15) then for v182=v85[2],v85[3] do v83[v182]=nil;end elseif (v86==16) then local v240;v83[v85[2]]=v59[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v240=v85[2];v83[v240]=v83[v240](v13(v83,v240 + 1 ,v85[3]));v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v59[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v240=v85[2];v83[v240]=v83[v240](v13(v83,v240 + 1 ,v85[3]));else v83[v85[2]][v85[3]]=v83[v85[4]];end elseif (v86<=20) then if (v86<=18) then v77=v85[3];elseif (v86==19) then local v250=v85[2];v83[v250]=v83[v250](v83[v250 + 1 ]);else local v252=v85[2];local v253=v83[v252];for v359=v252 + 1 ,v78 do v7(v253,v83[v359]);end end elseif (v86<=21) then v83[v85[2]]={};v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]={};v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]={};v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]={};v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];elseif (v86>22) then local v254=v85[2];local v255=v83[v254];local v256=v85[3];for v360=1,v256 do v255[v360]=v83[v254 + v360 ];end else v83[v85[2]]=v58[v85[3]];end elseif (v86<=35) then if (v86<=29) then if (v86<=26) then if (v86<=24) then local v142=v85[2];v83[v142]=v83[v142]();elseif (v86>25) then local v259=v74[v85[3]];local v260;local v261={};v260=v10({},{__index=function(v363,v364) local v365=v261[v364];return v365[1][v365[2]];end,__newindex=function(v366,v367,v368) local v369=v261[v367];v369[1][v369[2]]=v368;end});for v371=1,v85[4] do v77=v77 + 1 ;local v372=v73[v77];if (v372[1]==46) then v261[v371-1 ]={v83,v372[3]};else v261[v371-1 ]={v58,v372[3]};end v82[ #v82 + 1 ]=v261;end v83[v85[2]]=v29(v259,v260,v59);else local v263=v85[2];local v264=v85[4];local v265=v263 + 2 ;local v266={v83[v263](v83[v263 + 1 ],v83[v265])};for v374=1,v264 do v83[v265 + v374 ]=v266[v374];end local v267=v266[1];if v267 then v83[v265]=v267;v77=v85[3];else v77=v77 + 1 ;end end elseif (v86<=27) then local v144;local v145;local v146;v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]={};v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]][v85[3]]=v85[4];v77=v77 + 1 ;v85=v73[v77];v146=v85[2];v145=v83[v146];v144=v85[3];for v184=1,v144 do v145[v184]=v83[v146 + v184 ];end elseif (v86>28) then local v268=v85[2];local v269=v83[v268];for v377=v268 + 1 ,v85[3] do v7(v269,v83[v377]);end else v83[v85[2]]=v59[v85[3]];end elseif (v86<=32) then if (v86<=30) then local v154=v85[2];do return v13(v83,v154,v154 + v85[3] );end elseif (v86==31) then local v272=v85[2];v83[v272]=v83[v272](v13(v83,v272 + 1 ,v85[3]));else v83[v85[2]]=v85[3];end elseif (v86<=33) then local v155=v85[2];local v156={v83[v155](v83[v155 + 1 ])};local v157=0;for v187=v155,v85[4] do v157=v157 + 1 ;v83[v187]=v156[v157];end elseif (v86>34) then local v276=v85[2];v83[v276](v83[v276 + 1 ]);else local v277;v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]];v77=v77 + 1 ;v85=v73[v77];v277=v85[2];v83[v277]=v83[v277](v83[v277 + 1 ]);v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]];v77=v77 + 1 ;v85=v73[v77];if (v83[v85[2]]==v85[4]) then v77=v77 + 1 ;else v77=v85[3];end end elseif (v86<=41) then if (v86<=38) then if (v86<=36) then local v158;local v159;local v160;v83[v85[2]]={};v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v160=v85[2];v159=v83[v160];v158=v85[3];for v190=1,v158 do v159[v190]=v83[v160 + v190 ];end elseif (v86>37) then local v284;local v285;local v286,v287;local v288;v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v59[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]] + v83[v85[4]] ;v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]={};v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v59[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v288=v85[2];v286,v287=v76(v83[v288](v13(v83,v288 + 1 ,v85[3])));v78=(v287 + v288) -1 ;v285=0;for v378=v288,v78 do v285=v285 + 1 ;v83[v378]=v286[v285];end v77=v77 + 1 ;v85=v73[v77];v288=v85[2];v284=v83[v288];for v381=v288 + 1 ,v78 do v7(v284,v83[v381]);end else local v297;v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v297=v85[2];v83[v297](v13(v83,v297 + 1 ,v85[3]));v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]];v77=v77 + 1 ;v85=v73[v77];v297=v85[2];v83[v297](v13(v83,v297 + 1 ,v85[3]));v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]];v77=v77 + 1 ;v85=v73[v77];v297=v85[2];v83[v297](v13(v83,v297 + 1 ,v85[3]));v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v59[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v297=v85[2];v83[v297](v83[v297 + 1 ]);v77=v77 + 1 ;v85=v73[v77];do return;end end elseif (v86<=39) then v83[v85[2]]={};elseif (v86==40) then local v306;local v307;local v308;v83[v85[2]]={};v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v308=v85[2];v307=v83[v308];v306=v85[3];for v382=1,v306 do v307[v382]=v83[v308 + v382 ];end else local v314;local v315;local v316,v317;local v318;v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v318=v85[2];v83[v318](v13(v83,v318 + 1 ,v85[3]));v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v59[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]] + v83[v85[4]] ;v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]={};v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v59[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v318=v85[2];v316,v317=v76(v83[v318](v13(v83,v318 + 1 ,v85[3])));v78=(v317 + v318) -1 ;v315=0;for v385=v318,v78 do v315=v315 + 1 ;v83[v385]=v316[v315];end v77=v77 + 1 ;v85=v73[v77];v318=v85[2];v314=v83[v318];for v388=v318 + 1 ,v78 do v7(v314,v83[v388]);end end elseif (v86<=44) then if (v86<=42) then do return v83[v85[2]];end elseif (v86>43) then do return;end else local v327;v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v327=v85[2];v83[v327](v13(v83,v327 + 1 ,v85[3]));v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]];v77=v77 + 1 ;v85=v73[v77];v327=v85[2];v83[v327](v13(v83,v327 + 1 ,v85[3]));v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]];v77=v77 + 1 ;v85=v73[v77];v327=v85[2];v83[v327](v13(v83,v327 + 1 ,v85[3]));v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]];v77=v77 + 1 ;v85=v73[v77];v327=v85[2];v83[v327](v13(v83,v327 + 1 ,v85[3]));v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v58[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]];v77=v77 + 1 ;v85=v73[v77];v327=v85[2];v83[v327](v13(v83,v327 + 1 ,v85[3]));v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v59[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]][v85[4]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v327=v85[2];v83[v327](v83[v327 + 1 ]);v77=v77 + 1 ;v85=v73[v77];do return;end end elseif (v86<=45) then local v167;local v168;local v169;v83[v85[2]]=v83[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v59[v85[3]];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v83[v85[3]];v77=v77 + 1 ;v85=v73[v77];v169=v85[2];v168={v83[v169](v83[v169 + 1 ])};v167=0;for v193=v169,v85[4] do v167=v167 + 1 ;v83[v193]=v168[v167];end v77=v77 + 1 ;v85=v73[v77];v77=v85[3];elseif (v86==46) then v83[v85[2]]=v83[v85[3]];else local v338;local v339;local v340;v83[v85[2]]={};v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v83[v85[2]]=v85[3];v77=v77 + 1 ;v85=v73[v77];v340=v85[2];v339=v83[v340];v338=v85[3];for v389=1,v338 do v339[v389]=v83[v340 + v389 ];end end v77=v77 + 1 ;end end;end return v29(v28(),{},v17)(...);end return v15("LOL!473Q0003043Q006E616D65030F3Q00536D612Q6C476F644769726C6F336F2Q033Q00726964023Q0092C6E6A441030A3Q0042722Q6F6B2D48692Q6C023Q00242378984103083Q004D61674Q3756024Q0068E3AC41030E3Q004D6167696373776F726473746172023Q00B8F7379F4103083Q0053656C2Q653Q35023Q0096E725AB4103063Q00617A337A707A028Q0003063Q006D656D6F727903043Q007363616E03083Q00475441352E65786503053Q003444203541030E3Q00736F6369616C636C75622E642Q6C03043Q006D61696E023Q00800DB17D41025Q00B0A640025Q0008B140025Q00A8B040025Q00806F4003053Q006D61696E31023Q0080C1188341025Q002QB040026Q005840025Q00408740026Q006D402Q033Q00677461023Q00202Q228541023Q00605A918741023Q0060EC938741023Q00F8DD928741023Q0058401E8041023Q002012958741023Q00F8F9948741030A3Q00736F6369616C636C7562023Q0080C98E5141023Q00C019E15241024Q007A115341024Q00CC115341024Q00B2345341024Q0004355341024Q00BB68534103073Q006774615F726964024Q00E6938741023Q004072978741023Q0040FC948741023Q00C0EB938741023Q0040E0928741023Q0080C2C88641023Q008021228541023Q00C01B228541026Q005240030E3Q00736F6369616C636C75625F726964024Q004E745341024Q00B6685341024Q009E685341024Q002CE15241024Q0070F44D4103043Q006D656E7503063Q00616374696F6E03073Q006D795F722Q6F7403113Q00E694B9E5908DE4B8BA4754E5BC80E58F9103083Q00E7A0B4E8A7A34754034Q0003183Q00E694B9E5908DE4B8BA64616964616920556C74696D617465030C3Q00E7A0B4E8A7A364616964616900824Q00153Q00056Q00013Q000200302Q00010001000200302Q0001000300044Q00023Q000200302Q00020001000500302Q0002000300064Q00033Q000200302Q00030001000700302Q0003000300082Q002700043Q000200301B00040001000900302Q00040003000A4Q00053Q000200302Q00050001000B00302Q00050003000C6Q000500012Q0027000100014Q002700023Q000200300E00020001000D00300E00020003000E2Q001700010001000100020600025Q000206000300013Q000206000400023Q0012100005000F3Q00202Q00050005001000122Q000600113Q00122Q000700126Q00050007000200122Q0006000F3Q00202Q00060006001000122Q000700133Q00122Q000800126Q0006000800022Q002700073Q00062Q0009000800053Q00122Q000900153Q00122Q000A00163Q00122Q000B00173Q00122Q000C00183Q00122Q000D00196Q0008000500010010110007001400082Q0009000800053Q00122Q0009001B3Q00122Q000A001C3Q00122Q000B001D3Q00122Q000C001E3Q00122Q000D001F6Q0008000500010010110007001A00082Q0028000800073Q00122Q000900213Q00122Q000A00223Q00122Q000B00233Q00122Q000C00243Q00122Q000D00253Q00122Q000E00263Q00122Q000F00276Q0008000700010010110007002000082Q0028000800073Q00122Q000900293Q00122Q000A002A3Q00122Q000B002B3Q00122Q000C002C3Q00122Q000D002D3Q00122Q000E002E3Q00122Q000F002F6Q0008000700010010110007002800084Q000800093Q00122Q000900313Q00122Q000A00323Q00122Q000B00333Q00122Q000C00343Q00122Q000D00353Q00122Q000E00363Q00122Q000F00373Q00122Q001000383Q00122Q001100394Q00170008000900010010110007003000082Q0009000800053Q00122Q0009003B3Q00122Q000A003C3Q00122Q000B003D3Q00122Q000C003E3Q00122Q000D003F6Q0008000500010010110007003A000800120C000800403Q00202Q00080008004100122Q000900403Q00202Q0009000900424Q00090001000200122Q000A00436Q000B00013Q00122Q000C00446Q000B00010001001220000C00453Q00061A000D0003000100072Q002E8Q002E3Q00024Q002E3Q00054Q002E3Q00074Q002E3Q00034Q002E3Q00064Q002E3Q00044Q000D0008000D000100122Q000800403Q00202Q00080008004100122Q000900403Q00202Q0009000900424Q00090001000200122Q000A00466Q000B00013Q00122Q000C00476Q000B00010001001220000C00453Q00061A000D0004000100062Q002E3Q00014Q002E3Q00024Q002E3Q00054Q002E3Q00074Q002E3Q00034Q002E3Q00064Q00070008000D00012Q002C3Q00013Q00053Q00043Q0003063Q0069706169727303063Q006D656D6F727903093Q00726561645F6C6F6E67028Q0002134Q002D00025Q00122Q000300016Q000400016Q00030002000500044Q000F000100121C000800023Q0020220008000800034Q000900026Q0008000200024Q000200083Q00262Q0002000E000100040004123Q000E00012Q000F000800084Q002A000800024Q000300020002000700061900030005000100020004123Q000500012Q002A000200024Q002C3Q00017Q00043Q0003063Q0069706169727303063Q006D656D6F7279030C3Q0077726974655F737472696E6703043Q006E616D65030C3Q00121C000300014Q002E000400014Q00210003000200050004123Q0009000100121C000800023Q0020080008000800032Q000300093Q0007002008000A000200042Q00070008000A000100061900030004000100020004123Q000400012Q002C3Q00017Q00043Q0003063Q0069706169727303063Q006D656D6F7279030A3Q0077726974655F6C6F6E672Q033Q00726964030C3Q00121C000300014Q002E000400014Q00210003000200050004123Q0009000100121C000800023Q0020080008000800032Q000300093Q0007002008000A000200042Q00070008000A000100061900030004000100020004123Q000400012Q002C3Q00017Q00143Q0003043Q006D61746803063Q0072616E646F6D03063Q006D656D6F7279030C3Q0077726974655F737472696E6703043Q006D61696E026Q00F03F03053Q007461626C6503063Q00756E7061636B027Q004003043Q006E616D65030A3Q0077726974655F6C6F6E6703053Q006D61696E312Q033Q007269642Q033Q00677461030A3Q00736F6369616C636C756203073Q006774615F726964030E3Q00736F6369616C636C75625F72696403043Q007574696C03053Q00746F617374030C3Q00E4BFAEE694B9E68890E58A9F004A4Q000A7Q00122Q000100013Q00202Q0001000100024Q00028Q000200026Q0001000200028Q000100122Q000100033Q00202Q0001000100044Q000200016Q000300026Q000400033Q00202Q00040004000500202Q0004000400064Q0003000300044Q00045Q00122Q000500073Q00202Q0005000500084Q000600033Q00202Q00060006000500122Q000700096Q000500076Q00043Q00012Q001F00020004000200202900033Q000A4Q00010003000100122Q000100033Q00202Q00010001000B4Q000200016Q000300026Q000400033Q00202Q00040004000C00202Q0004000400064Q0003000300044Q00045Q00122Q000500073Q00202Q0005000500084Q000600033Q00202Q00060006000C00122Q000700096Q000500076Q00043Q00012Q001F00020004000200202B00033Q000D4Q0001000300014Q000100046Q000200026Q000300033Q00202Q00030003000E4Q00048Q0001000400014Q000100046Q000200056Q000300033Q00202Q00030003000F4Q00048Q0001000400014Q000100066Q000200026Q000300033Q00202Q0003000300104Q00048Q0001000400014Q000100066Q000200056Q000300033Q00202Q0003000300114Q00048Q00010004000100122Q000100123Q00202Q00010001001300122Q000200146Q0001000200016Q00017Q000D3Q00026Q00F03F03063Q006D656D6F7279030C3Q0077726974655F737472696E6703043Q006D61696E03053Q007461626C6503063Q00756E7061636B027Q004003043Q006E616D652Q033Q00677461030A3Q00736F6369616C636C756203043Q007574696C03053Q00746F617374030C3Q00E4BFAEE694B9E68890E58A9F00264Q00267Q00206Q000100122Q000100023Q00202Q0001000100034Q000200016Q000300026Q000400033Q00202Q00040004000400202Q0004000400014Q0003000300044Q00045Q00122Q000500053Q00202Q0005000500064Q000600033Q00202Q00060006000400122Q000700076Q000500076Q00043Q00012Q001F00020004000200202500033Q00084Q0001000300014Q000100046Q000200026Q000300033Q00202Q0003000300094Q00048Q0001000400014Q000100046Q000200056Q000300033Q00202Q00030003000A4Q00048Q00010004000100122Q0001000B3Q00202Q00010001000C00122Q0002000D6Q0001000200016Q00017Q00",v9(),...);