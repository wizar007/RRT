//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

#include "fuente.h"
#include <string.h>
#include <omnetpp.h>
#include <iostream>
#include <deque>

using namespace omnetpp;
class Fuente : public cSimpleModule{
    int contador=0;
    int indiceP3=0;
    int indiceP2=0;
        std::deque<cPacket *> colaFuente;
        std::deque<cPacket *> colaP1;
        std::deque<cPacket *> colaP2;
        std::deque<cPacket *> colaP3;
        std::vector<simtime_t> entradaP2;
        std::vector<simtime_t> salidaP2;
        std::vector<int> numeromensajeP2;
        std::vector<simtime_t> entradaP3;
        std::vector<simtime_t> salidaP3;
        std::vector<int> numeromensajeP3;
        virtual void initialize() override;
        virtual void handleMessage(cMessage *msg) override;
    };
    //std::deque<cPacket *> colaFuente;
    Define_Module(Fuente);
    void Fuente::initialize()
    {
        //SourceBase::initialize();
        //startTime = par("startTime");
       // stopTime = par("stopTime");
        //numJobs = par("numMsgs");

        // schedule the first message timer for start time
        scheduleAt(0, new cMessage("newJobTimer"));
    }

    void Fuente::handleMessage(cMessage *msg)
    {
        char message[20];
        int length;
        simtime_t entradaT;
        simtime_t salidaT;
        simtime_t entradaT2;
        simtime_t salidaT2;

        length=rand()%(1500*8-50*8+1)+50*8;
       /* std::cout<<"contador a ";
        std::cout<<contador;
        std::cout<<"\n";*/
        if(strcmp("recep",msg->getName())==0){
            if(colaP1.empty()==false)
            {
                cPacket *salida=colaP1.front();
                colaP1.pop_front();
                send(salida,"out");
            }
            else
            {
                //std::cout<<"ColaP1 vacia \n";
                if(colaP2.empty()==false)
                {
                    cPacket *salida=colaP2.front();
                    colaP2.pop_front();
                    send(salida,"out");
                    salidaT2=simTime();
                    salidaP2.push_back(salidaT2);
                    std::cout<<"PaqueteP2";
                    std::cout<<"\t ";
                            std::cout<<indiceP2;
                            std::cout<<"\t ";
                            std::cout<<numeromensajeP2[indiceP2];
                            std::cout<<"\t";
                            std::cout<<entradaP2[indiceP2];
                            std::cout<<"\t";
                            std::cout<<salidaP2[indiceP2];
                            std::cout<<"\t";
                            std::cout<<colaP2.size();
                            std::cout<<"\n";
                    indiceP2++;
                }
                else
                {
                    //std::cout<<"ColaP2 vacia \n";
                    if(colaP3.empty()==false)
                    {
                        cPacket *salida=colaP3.front();
                        colaP3.pop_front();
                        send(salida,"out");
                        salidaT=simTime();
                        salidaP3.push_back(salidaT);
                        std::cout<<"PaqueteP3";
                        std::cout<<"\t ";
                                std::cout<<indiceP3;
                                std::cout<<"\t ";
                                std::cout<<numeromensajeP3[indiceP3];
                                std::cout<<"\t";
                                std::cout<<entradaP3[indiceP3];
                                std::cout<<"\t";
                                std::cout<<salidaP3[indiceP3];
                                std::cout<<"\t";
                                std::cout<<colaP3.size();
                                std::cout<<"\n";
                        indiceP3++;
                    }
                    else
                    {
                        std::cout<<"ColaP3 vacia \n";
                        int length=50*8;
                        cPacket *salida = new cPacket("recep",0,length);
                        send(salida,"out");
                    }
                }
            }
            }
            else{
                float n=rand()%10;
                if(n>=5)
                {
                    if(n>=8)
                    {
                        sprintf(message,"Msg%dP1",contador);
                        cPacket *job = new cPacket(message,0,length);
                        contador++;
                        colaP1.push_back(job);
                        /*std::cout<<"Paquetes en colaP1  ";
                                std::cout<<colaP1.size();
                                std::cout<<"\n";*/
                    }
                    else
                    {
                        sprintf(message,"Msg%dP2",contador);
                        cPacket *job = new cPacket(message,0,length);
                        numeromensajeP2.push_back(contador);
                        contador++;
                        colaP2.push_back(job);
                        entradaT2=simTime();
                        entradaP2.push_back(entradaT2);
                    }
                }
                else
                {
                    sprintf(message,"Msg%dP3",contador);
                    cPacket *job = new cPacket(message,0,length);
                    numeromensajeP3.push_back(contador);
                    contador++;
                    colaP3.push_back(job);
                    entradaT=simTime();
                    entradaP3.push_back(entradaT);

                }
                    //sprintf(message,"Msg%d",contador);
                    /*std::cout<<"Id mensaje ";
                    std::cout<<message;
                    std::cout<<"\n";*/

                ASSERT(msg->isSelfMessage());

                //if ((numJobs < 0 || numJobs > jobCounter) && (stopTime < 0 || stopTime > simTime())) {
                    // reschedule the timer for the next message
                    scheduleAt(simTime() + par("interArrivalTime").doubleValue(), msg);
                //scheduleAt(simTime() + 2, msg);

            }
   /* int contador=0;
    std::deque<cPacket *> colaFuente;
    virtual void initialize() override;
    virtual void handleMessage(cMessage *msg) override;
};
//std::deque<cPacket *> colaFuente;
Define_Module(Fuente);
void Fuente::initialize()
{
    //SourceBase::initialize();
    //startTime = par("startTime");
   // stopTime = par("stopTime");
    //numJobs = par("numMsgs");

    // schedule the first message timer for start time
    scheduleAt(0, new cMessage("newJobTimer"));
}

void Fuente::handleMessage(cMessage *msg)
{
    char message[20];
    std::cout<<"contador a ";
    std::cout<<contador;
    if(strcmp("recep",msg->getName())==0){
            if (!colaFuente.empty()){
                cPacket *salida=colaFuente.front();
                colaFuente.pop_front();
                send(salida,"out");
            }
            else{
                scheduleAt(simTime()+0.1, new cMessage("recep"));
            }
        }
        else{
            float n=rand()%10;
            if(n>=5)
            {
                if(n>=9)
                {
                    sprintf(message,"Msg%dP1",contador);
                }
                else
                {
                    sprintf(message,"Msg%dP2",contador);
                }
            }
            else
            {
                sprintf(message,"Msg%dP3",contador);
            }
                //sprintf(message,"Msg%d",contador);
                std::cout<<"Id mensaje";
                std::cout<<n;
                int length;
                    length=rand()%(1500*8-50*8+1)+50*8;
            ASSERT(msg->isSelfMessage());

            //if ((numJobs < 0 || numJobs > jobCounter) && (stopTime < 0 || stopTime > simTime())) {
                // reschedule the timer for the next message
                scheduleAt(simTime() + par("interArrivalTime").doubleValue(), msg);
            //scheduleAt(simTime() + 2, msg);

                cPacket *job = new cPacket(message,0,length);
                contador++;
                colaFuente.push_back(job);
        }*/
                /*
    char message[20];
    int contador=0;
        sprintf(message,"Msg%d",contador);
        int length;
            length=rand()%(1500*8-50*8+1)+50*8;
    ASSERT(msg->isSelfMessage());

    //if ((numJobs < 0 || numJobs > jobCounter) && (stopTime < 0 || stopTime > simTime())) {
        // reschedule the timer for the next message
        scheduleAt(simTime() + par("interArrivalTime").doubleValue(), msg);
    //scheduleAt(simTime() + 2, msg);

        cPacket *job = new cPacket(message,0,length);
        contador++;
        send(job, "out");
    //}
    //else {
        // finished
      //  delete msg;*/
    //}
}

