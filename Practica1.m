(* ::Package:: *)

(* ::Title:: *)
(*Caso 1: Modelo de colas para analisis de rendimiento*)


(* ::Chapter:: *)
(*Parte Primera*)


(* ::Subchapter:: *)
(*1- Desarrollar un sistema generador de n\[UAcute]meros aleatorios basado en un generador lineal congruencial mixto que siga una distribuci\[OAcute]n uniforme entre [0,1]. *)


(* ::Input:: *)
(*a=314159269*)


(* ::Input:: *)
(*c=453806245*)


(* ::Input:: *)
(*m=2^31*)


(* ::Input:: *)
(*Module[{z0=16083844},RnData[]:=(z=Mod[a*z0+c,m];z0=z;z/m//N)]*)


(* ::Input:: *)
(*nlist=Table[RnData[], {i, 1, 10000}];*)


(* ::Subchapter:: *)
(*2- Probar el generador y demostrar mediante un histograma la bondad del generador.  *)


(* ::Input:: *)
(*Histogram[nlist,10000, ColorFunction->Function[{height},ColorData["Rainbow"][height]]]*)


(* ::Subchapter:: *)
(*3- Implementar el m\[EAcute]todo de transformada inversa para obtener una distribuci\[OAcute]n aleatoria exponencial de tiempo entre llegadas 1/\[Lambda]. Representar en un histograma los valores obtenidos. *)


(* ::Input:: *)
(*RndInv[landa_]:=-(1/landa)*Log[RnData[]];*)


(* ::Input:: *)
(*landa=10000*)


(* ::Text:: *)
(*Landa, tasa de llegadas pauqetes/seg*)


(* ::Input:: *)
(*listexp=Table[RndInv[landa],{i,1,10000}];*)


(* ::Text:: *)
(*listexp, indica  cuantos paquetes han caido en esa probabilidad, que probabilidad hay de que llegue un paquete en ese tiempo de llegada. Te da el tiempo entre lleve *)


(* ::Input:: *)
(*Histogram[listexp,10000,ColorFunction->Function[{height},ColorData["Rainbow"][height]]]*)


(* ::Input:: *)
(*Histogram[listexp,100,"CDF"]*)


(* ::Text:: *)
(*Funci\[OAcute]n distributiba acumulativa de la exponencial*)


(* ::Chapter:: *)
(*Parte segunda*)


(* ::Subchapter:: *)
(*4 Desarrollar un simulador de una cola M/M/1 con tasa \[Lambda] de llegadas y \[Mu] de servicio. Representar en un diagrama que evolucione en el tiempo el n\[UAcute]mero de usuarios en el sistema. *)


(* ::Input:: *)
(*landa=25000;*)


(* ::Input:: *)
(*InterArrivalsTime=Table[RndInv[landa],{i,1,10000}];*)


(* ::Input:: *)
(*Module[{z0=0}, AcumSerie[x_]:=z0=z0+x];*)


(* ::Text:: *)
(*OJO!!!! Ejecuta el comando anterior antes de volver a ejecutar el siguiente z0 no se reinicializa a 0, mantiene su valor*)


(* ::Input:: *)
(*z0=0;ArrivalsTime=Map[AcumSerie[#] &,InterArrivalsTime]*)


(* ::Text:: *)
(*& hace que te lo ejecute como funci\[OAcute]n, ArrivalsTime[[100::200]], trunca la lista desde los elementos 100 a 200*)


(* ::Input:: *)
(*ListPlot[ArrivalsTime]*)


(* ::Text:: *)
(*El service time es una distribuci\[OAcute]n exponencial como la generada en el InterArrivalsTime*)


(* ::Input:: *)
(*landa=25000;*)


(* ::Input:: *)
(*mu=25000;*)


(* ::Input:: *)
(*ro=1/mu;*)


(* ::Input:: *)
(*ServiceTime=Table[RndInv[mu],{i,1,10000}];*)


(* ::Text:: *)
(*Por que ro*landa dentro del RndInv?*)


(* ::Input:: *)
(*%110*)


(* ::Input:: *)
(*FifoSchedulling[arrivals_,service_]:=Module[{n,checkTime},n=1;checkTime=arrivals[[1]];*)
(*Map[*)
(*(If[checkTime>=#,checkTime+=service[[n++]],checkTime=#+service[[n++]]])&,arrivals]*)
(*]*)


(* ::Input:: *)
(*DeparturesTimestest=FifoSchedulling[{1,2,3,8},{1,2,1,1}]*)


(* ::Input:: *)
(*DeparturesTimes=FifoSchedulling[ArrivalsTime,ServiceTime];*)
(**)


(* ::Input:: *)
(*%112*)


(* ::Input:: *)
(*ListPlot[{ArrivalsTime,DeparturesTimes}]*)


(* ::Text:: *)
(*Calculo de usuarios en el sistema*)


(* ::Input:: *)
(*Arrivalusers=Table[{ArrivalsTime[[n]],n},{n,1,10000}]*)


(* ::Input:: *)
(*Departuresusers=Table[{DeparturesTimes[[n]],n},{n,1,10000}]*)


(* ::Input:: *)
(*ListPlot[{Arrivalusers,Departuresusers}]*)


(* ::Subchapter:: *)
(*5 Representar el tiempo medio de espera en el sistema normalizado por \[Mu] para diferentes valores de \[Rho]. Hacerlo con la curva te\[OAcute]rica y representar los puntos obtenidos en las simulaciones. *)


(* ::Input:: *)
(*mu=100;*)


(* ::Input:: *)
(*En[p_]=p/(1-p);*)


(* ::Input:: *)
(*Plot[En[p],{p,0,1}]*)


(* ::Input:: *)
(*Et[p_,muv_]=1/((1-p)*muv);*)
(**)


(* ::Input:: *)
(*1/(muv (1-p))*)


(* ::Input:: *)
(* Ew[p_,muv_]=Et[p,muv]-(1/muv);*)


(* ::Input:: *)
(*-(1/muv)+Et[p]*)


(* ::Input:: *)
(*Manipulate[ Plot[{Et[p,muv],Ew[p,muv]},{p,0,1}], {muv,100,25000}]*)


(* ::Input:: *)
(**)


(* ::Text:: *)
(*Puntos obtenidos en las simulaciones*)


(* ::Input:: *)
(*PuntosSim=DeparturesTimes-ArrivalsTime;*)


(* ::Input:: *)
(*ListPlot[PuntosSim]*)


(* ::Chapter:: *)
(*Parte 3*)


(* ::Input:: *)
(*Plot[{1/(1-ro),Et[1/ro,1000]},{ro,0,1}]*)
