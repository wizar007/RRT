(* ::Package:: *)

(* ::Input:: *)
(*Needs["drawTx`"];*)


(* ::Input:: *)
(*Module[{RndNumber = 4406,a=314159269,c=453806245,m=2^31},*)
(*RandomData[]:=N[(RndNumber =Mod[(a RndNumber+c),m])/(m-1)];*)
(*RandomExp[rate_]:=(-Log[RandomData[]]/rate);*)
(*GetRndNumber[]:=RndNumber*)
(*]*)


(* ::Text:: *)
(*En esta parte del codigo se esta generando las  distribuciones aleatorias de datos, mediante la utilizaci\[OAcute]n de los numeros de kobayashi. Se realizan una funcion aletoria y exponencial.*)


(* ::Input:: *)
(**)
(*Module[{tp=0.01,tack=0.05,winMod=8,nsec=0},*)
(*SetIniPar[tP_,tAck_,nSec_]:=(tp=tP;tack=tAck;nsec=nSec;SetIniParDraw[tp,tack];{tp,tack,winMod});*)
(*GetIniPar[]:={tp,tack,winMod};*)
(*PacketArrivalsGenTimePeriod[lambdaArr_ ,muServ_,lastTime_,iniTime_:0]:=NestWhileList[ {(acumTime+=lambdaArr),muServ,nsec++,0,0}&,{acumTime=iniTime+lambdaArr,muServ,nsec++,0,0},(#[[1]] <lastTime )&]*)
(*;*)
(*SetAttributes[PacketArrivalsGenTimePeriod,HoldAll];*)
(**)
(**)
(*FifoPacketTxSW[arrivals_,pcomb_]:=*)
(*Module[{checkTime,nrTx},checkTime=arrivals[[1,1]];*)
(**)
(*SetCheckTimeSW[time_]:=(checkTime=time);*)
(**)
(*GetDepartureSW[arr_]:=*)
(*Module[{ret=arr[[1]]},(If[checkTime>=arr[[1]],ret=checkTime;checkTime+=arr[[2]],checkTime=arr[[1]]+arr[[2]]];checkTime+=2 tp+tack;ret)*)
(*];*)
(**)
(*GetPacketRTxSW[pck_,perror_]:=({GetDepartureSW[pck],pck[[2]],pck[[3]],If[RandomData[]<=perror,1,0],pck[[5]]+1});*)
(**)
(*Flatten[Map[(NestWhileList[(GetPacketRTxSW[#,pcomb]&),GetPacketRTxSW[#,pcomb],(#[[4]]==1)&])&,arrivals],1]*)
(*];*)
(*LaunchSimTxSW[tasa_,tp_,p_,time_,lambda_]:=(SetIniPar[tp,0,0];FifoPacketTxSW[PacketArrivalsGenTimePeriod[tasa,lambda,time,0],p]);*)
(*SetAttributes[LaunchSimTxSW,HoldAll];*)
(*]*)
(**)
(**)


(* ::Text:: *)
(*tp=tiempo de propagaci\[OAcute]n, tack=tiempo de acknowledge, nsecs.*)
(*PacketArrivalGenTimePeriod es la tasa de llegada de paquetes[landa, mu--> deberia ser tiempo de servicio, duraci\[OAcute]n de la simulaci\[OAcute]n, init time tiempo de inicio]= esto genera paquetes, con una tasa landa acumulativa. El paquete tiene es tiempo de inicio, la tasa de servicio, el n\.ba de secuencia.*)
(*En FIFOPacketTRSW se ejecuta el protocolo stop &Wait.*)
(*GetPacketRTxSW por si hay retransmisiones*)


(* ::Input:: *)
(**)
(*SetIniPar[0.01,0,0];*)
(**)
(*PacketsTx=FifoPacketTxSW[PacketArrivalsGenTimePeriod[RandomExp[1.5],RandomExp[2.5],20,0],.2];*)
(**)


(* ::Text:: *)
(*SetIniPar inicializa la libreria para la representaci\[OAcute]n grafica, llama a la funci\[OAcute]n con el randomExp con tasa de llegadas de 1.5, los hace con tama\[NTilde]o fijo por que en el matematica lo hace con el HOLDALL de arriva, por cada paquete ejecuta un random y simula un tiempo entre llegadas.*)


(* ::Input:: *)
(*Manipulate[*)
(*Show[DrawWin[tw,ww,10], Map[(DrawPacketTx[#])&,SelectPacketInWin[PacketsTx]]]*)
(**)
(*,{tw,0,30},{ww,0.01,10}*)
(*]*)


(* ::Text:: *)
(*tw, te desplaza en el tiempo y el ww controla el zoom de la ventana. Drawin dibuja el marco, Con el MAP se le todos los paquetes de la simulaci\[OAcute]n definidos en la lista, con el selectPacketIn Win se seleccionan los paquetes que estan dentro de la b\[DownExclamation]ventana, incluso si entra solo unaarte del paquete. y se elimnan los que no entran. DrawPacket dibuja cada paquete mas la transmision mas el ACK*)


(* ::Input:: *)
(*PacketList=Table[{i*0.100,0.05,i,0,0},{i,1,1000}];*)


(* ::Input:: *)
(*PacketList[[20;;40]]*)


(* ::Input:: *)
(*Manipulate[*)
(*Show[DrawWin[tw,ww,10], Map[(DrawPacketTx[#])&,SelectPacketInWin[PacketList]]]*)
(**)
(*,{tw,0,100},{ww,0.01,10}*)
(*]*)


(* ::Input:: *)
(*PacketListAlt=Table[{i*0.100,0.05,i,If[Mod[i,5]!=0,0,1],0},{i,1,1000}];*)


(* ::Input:: *)
(*PacketListAlt[[20;;40]]*)


(* ::Input:: *)
(*Manipulate[*)
(*Show[DrawWin[tw,ww,10], Map[(DrawPacketTx[#])&,SelectPacketInWin[PacketListAlt]]]*)
(**)
(*,{tw,0,100},{ww,0.01,10}*)
(*]*)
