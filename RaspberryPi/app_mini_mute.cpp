#include "app_mini_mute.h"
#include "ui_app_mini_mute.h"
#include "crpigpio.h"
#include <QTimer>
#include <QDebug>
#include <QChar>

#include <QFile>
#include <QTextStream>

// Definicion de GPIO pines
#define LED1 17
#define LED2 27
#define LED3 4
#define INT_FPGA 24
#define PPS 23
#define PPSFICTI 12



App_Mini_Mute::App_Mini_Mute(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::App_Mini_Mute)
{
    ui->setupUi(this);


    //Inicializacion de GPIO Raspberry con la libreria CRpigpio
    GPIO=new Crpigpio;
    GPIO->SetPinMode(LED1, PI_OUTPUT); //Configura como salida
    GPIO->SetPinMode(LED2, PI_OUTPUT); //Configura como salida
    GPIO->SetPinMode(LED3, PI_OUTPUT); //Configura como salida
    GPIO->SetPinMode(PPSFICTI, PI_OUTPUT); //Configura como salida

    GPIO->SetPinMode(PPS, PI_INPUT); //Configura como entrada
    GPIO->SetPinMode(INT_FPGA,PI_INPUT); //Configura como entrada

    DAC=new Crpigpio; // Es necesario otro objeto (DAC) pues el HanleSPI es unico para cada objeto.
    DAC->OpenSPI(2, 36000, 258);  //Configura el puerto SPI para la FPGA a 10MHz y el modo 1
    //---------------------------------------------------------

    //Inicializacion de Funciones CRpigpio

        //SPI
        GPIO->OpenSPI(0, 200000, 0xC001);  //Configura el puerto SPI para la FPGA a 10MHz y el modo 1
        //Interrupcion por pin
        GPIO->SetPullUpDown(INT_FPGA,PI_PUD_UP); //Abilita resistencias de positivo
        GPIO->SetISRgpio(INT_FPGA,1,100000); //Configura la interrupcion (pin,flanco,timeout uS) flanco=0 = rising

        GPIO->SetPullUpDown(PPS,PI_PUD_UP); //Abilita resistencias de positivo
        GPIO->SetISRgpio(PPS,1,100000);
    //Inicializacion de interrupciones por tiempo
        //Timer1=tmr1    temporizador para actualizar datos interfaz
        QTimer *tmr1=new QTimer();
        tmr1->setInterval(100); //mS
        tmr1->start();
        //---------------------------------------------------------

        //Timer2=tmr2    temporizador para manejo de tiempo en segundos
        tmr2=new QTimer();
        tmr2->setInterval(500); //mS
        tmr2->start();


        tmr3=new QTimer();
        tmr3->setInterval(1);
        tmr3->start();

        //---------------------------------------------------------
    //---------------------------------------------------------------

   //Coneccion de Signals & Slots
        connect(GPIO,&Crpigpio::OnCallBackISR,this,&App_Mini_Mute::OnISR); //interupcion por hardware
        connect(tmr1,&QTimer::timeout,this,&App_Mini_Mute::SHOW_NOW);
        connect(tmr2,&QTimer::timeout,this,&App_Mini_Mute::FTIME);
        connect(tmr3,&QTimer::timeout,this,&App_Mini_Mute::atentSincronizacion_RAM_FPGA);
   //----------------------------


  //Inicializacion Voltaje DAC
    Wirite_DAC(ui->Normal_actual_SpinVoltajeUmbral_5->value());


    uint64_t check=1;
    for(int i=0; i<64;i++)
    {
        checksum_AND.append(check);
        qDebug() << check << "Posicion =" << i ;
        check *=2;

    }
    for(int i=0; i<64;i++)
    {

        qDebug() << checksum_AND[i];
    }
    Sincronizacion_RAM_FPGA=false;
    Posicion_R_RAM =0;

    count=0;
    ant_FlujoMinuto=0;
    antcount=0;
}

App_Mini_Mute::~App_Mini_Mute()
{
    delete DAC;
    delete GPIO;
    delete ui;
}



void App_Mini_Mute::FTIME()
{
    qDebug() << "On_OFF Led";
    switch (PPS_ON) {
    case true:
        PPS_ON=false;
    default:
        if( GPIO->ReadGpio(LED1) == 0)
        {
            //cqDebug() << "On Led";
            GPIO->WriteGpio(LED1,PI_ON);
            GPIO->WriteGpio(LED2,PI_ON);
            GPIO->WriteGpio(LED3,PI_ON);
            GPIO->WriteGpio(PPSFICTI,PI_ON);
            tmr2->setInterval(1); //mS
            tmr2->start();

        }
        else
        {
            //qDebug() << "OFF Led";
            GPIO->WriteGpio(LED1,PI_OFF);
            GPIO->WriteGpio(LED2,PI_OFF);
            GPIO->WriteGpio(LED3,PI_OFF);
            GPIO->WriteGpio(PPSFICTI,PI_OFF);
            tmr2->setInterval(999); //mS
            tmr2->start();
        }   
    break;
    }
    ui->LCD_Normal_Flujo_por_segundo->display(count-antcount);
    antcount=count;
    minuto++;

    if (minuto >= 60)
    {
        minuto=0;
        ui->LCD_Normal_Flujo_por_minuto->display(count-ant_FlujoMinuto);
        ant_FlujoMinuto=count;

    }

}

void App_Mini_Mute::SHOW_NOW()
{
    ui->Normal_LCD_Particulas_Totales->display(count);
}

void App_Mini_Mute::Wirite_DAC(double Voltaje)
{

    QByteArray DAC_bytes;
    int Voltaje_DAC;
    DAC_bytes.reserve(3);
    qDebug() << "Treshold = " << Voltaje;
    Voltaje_DAC=  int(Voltaje * 1228.8);   // Conversion a unidades DAC de 12 bits 1228.8=4096/3.3333333
    DAC_bytes[0]= 0x00;
    DAC_bytes[1]= (Voltaje_DAC >> 4) & 0b0000000011111111;
    DAC_bytes[2]= (Voltaje_DAC & 0b000000001111)<< 4;
    DAC->WriteSPI(DAC_bytes);
}

void App_Mini_Mute::OnISR(int gpio,int level,quint32 timeout)
{
    switch (gpio)
    {
    case INT_FPGA:
        if(level== 0)
        {
            Sincronizacion_RAM_FPGA = false;
        }
        break;
    case PPS:
        if(level== 0)
        {
            qDebug()<< "PPS";
            PPS_ON=true;
            tmr2->setInterval(1010); //mS
            tmr2->start();

        }
        break;
    default:
           qDebug()<< "NULL Interrupcion";
        break;
    }

    return;
    qDebug()<< timeout;
}




void App_Mini_Mute::on_comboBox_activated(const QString &arg1)
{
    qDebug() << arg1 ;
    ushort FuncionFPGA;
    QByteArray MOSI;
    MOSI.resize(2);
    if(arg1.operator ==("Conteos"))
    {
        FuncionFPGA = Funcion_FPGA(43);

    }
    else if (arg1.operator ==("Flujo de particulas"))
    {
        FuncionFPGA = Funcion_FPGA(44);
    }
    else if (arg1.operator ==("Errores"))
    {
       FuncionFPGA = Funcion_FPGA(42);
    }
    else{ qDebug() << "Error";return;}
    MOSI[0]=FuncionFPGA>>8;
    MOSI[1]=FuncionFPGA;
    GPIO->WriteSPI(MOSI);
}


unsigned short App_Mini_Mute::Funcion_FPGA(int Funcion)
{
    MOSI_FPGA Mosi;
    Mosi.debug=0;
    switch(Funcion) {
    //Inicio posiciones de RAM
        case 0:
            Mosi.modo=0;
            Mosi.info=0b00000;
            Mosi.checksum=0b000;
            break;
        case 1:
            Mosi.modo=0;
            Mosi.info=0b00001;
            Mosi.checksum=0b001;
            break;
        case 2:
            Mosi.modo=0;
            Mosi.info=0b00010;
            Mosi.checksum=0b001;
            break;
        case 3:
            Mosi.modo=0;
            Mosi.info=0b00011;
            Mosi.checksum=0b010;
            break;
        case 4:
            Mosi.modo=0;
            Mosi.info=0b00100;
            Mosi.checksum=0b001;
            break;
        case 5:
            Mosi.modo=0;
            Mosi.info=0b00101;
            Mosi.checksum=0b010;
            break;
        case 6:
            Mosi.modo=0;
            Mosi.info=0b00110;
            Mosi.checksum=0b010;
            break;
        case 7:
            Mosi.modo=0;
            Mosi.info=0b00111;
            Mosi.checksum=0b011;
            break;
        case 8:
            Mosi.modo=0;
            Mosi.info=0b01000;
            Mosi.checksum=0b001;
            break;
        case 9:
            Mosi.modo=0;
            Mosi.info=0b01001;
            Mosi.checksum=0b010;
            break;
        case 10:
            Mosi.modo=0;
            Mosi.info=0b01010;
            Mosi.checksum=0b010;
            break;
        case 11:
            Mosi.modo=0;
            Mosi.info=0b01011;
            Mosi.checksum=0b011;
            break;
        case 12:
            Mosi.modo=0;
            Mosi.info=0b01100;
            Mosi.checksum=0b010;
            break;
        case 13:
            Mosi.modo=0;
            Mosi.info=0b01101;
            Mosi.checksum=0b011;
            break;

        case 14:
            Mosi.modo=0;
            Mosi.info=0b01110;
            Mosi.checksum=0b011;
            break;
        case 15:
            Mosi.modo=0;
            Mosi.info=0b01111;
            Mosi.checksum=0b100;
            break;
        case 16:
            Mosi.modo=0;
            Mosi.info=0b10000;
            Mosi.checksum=0b001;
            break;
        case 17:
            Mosi.modo=0;
            Mosi.info=0b10001;
            Mosi.checksum=0b010;
            break;
        case 18:
            Mosi.modo=0;
            Mosi.info=0b10010;
            Mosi.checksum=0b010;
            break;
        case 19:
            Mosi.modo=0;
            Mosi.info=0b10011;
            Mosi.checksum=0b011;
            break;
        case 20:
            Mosi.modo=0;
            Mosi.info=0b10100;
            Mosi.checksum=0b010;
            break;
        case 21:
            Mosi.modo=0;
            Mosi.info=0b10101;
            Mosi.checksum=0b011;
            break;
        case 22:
            Mosi.modo=0;
            Mosi.info=0b10110;
            Mosi.checksum=0b011;
            break;
        case 23:
            Mosi.modo=0;
            Mosi.info=0b10111;
            Mosi.checksum=0b100;
            break;
        case 24:
            Mosi.modo=0;
            Mosi.info=0b11000;
            Mosi.checksum=0b010;
            break;
        case 25:
            Mosi.modo=0;
            Mosi.info=0b11001;
            Mosi.checksum=0b011;
            break;
        case 26:
            Mosi.modo=0;
            Mosi.info=0b11010;
            Mosi.checksum=0b011;
            break;
        case 27:
            Mosi.modo=0;
            Mosi.info=0b11011;
            Mosi.checksum=0b100;
            break;
        case 28:
            Mosi.modo=0;
            Mosi.info=0b11100;
            Mosi.checksum=0b011;
            break;
        case 29:
            Mosi.modo=0;
            Mosi.info=0b11101;
            Mosi.checksum=0b100;
            break;
        case 30:
            Mosi.modo=0;
            Mosi.info=0b11110;
            Mosi.checksum=0b100;
            break;
        case 31:
            Mosi.modo=0;
            Mosi.info=0b11111;
            Mosi.checksum=0b101;
            break;
     /// Fin Posiciones de RAM

        case 40:   //Borrar RAM
            Mosi.modo=1;
            Mosi.info=0b10000;
            Mosi.checksum=0b010;
            break;

        case 41:   //Reiniciar contadores
            Mosi.modo=1;
            Mosi.info=0b11000;
            Mosi.checksum=0b011;
            break;

        case 42:   //Desplegar Errores
            Mosi.modo=1;
            Mosi.info=0b11100;
            Mosi.checksum=0b100;
            break;
        case 43:   //Desplegar Conteo
            Mosi.modo=1;
            Mosi.info=0b11110;
            Mosi.checksum=0b101;
            break;
        case 44:   //Desplegar Flujo0b11110110
            Mosi.modo=1;
            Mosi.info=0b11101;
            Mosi.checksum=0b101;
            break;
        case 45:   //Generar error en la comunicacion
            Mosi.modo=1;
            Mosi.info=0b11111;
            Mosi.checksum=0b000;
            break;

        default:    //Opcion no valida retorno en alto
            Mosi.debug=0xFF0F;
            break;
    }
    return Mosi.debug;
}
void App_Mini_Mute::on_Normal_actual_SpinVoltajeUmbral_5_valueChanged(double arg1)
{
     Wirite_DAC(arg1);
}

void App_Mini_Mute::atentSincronizacion_RAM_FPGA()
{
    Read_save_data_FPGA(3);
}

void App_Mini_Mute::Read_save_data_FPGA(uint8_t MODO)
{
    if(MODO == 1 || MODO == 2 || !Sincronizacion_RAM_FPGA)
    {
        uint8_t chksum=0;
        MOSI_RAM_FPGA MOSI; //Escritura buffer
        MISO_FPGA MISO;     //Lectura buffer
        char MOSI_char[8];  //Escritura en comunicacion
        char MISO_char[8];  //Lectura en comunicacion

        MOSI.debug_buffer=0; //inicializacion bufffer escritura
        chksum=0;   //inicializacion checksum
        bool RTA=false;
        uint8_t intentos;
          switch (MODO) {
        case 1:
            MOSI.data.debug = Funcion_FPGA(30);
            MOSI_char[7]=MOSI.NUll[0];    MOSI_char[6]=MOSI.NUll[1];    MOSI_char[5]=MOSI.NUll[2];    MOSI_char[4]=MOSI.NUll[3];
            MOSI_char[3]=MOSI.NUll[4];    MOSI_char[2]=MOSI.NUll[5];    MOSI_char[1]=MOSI.data.Full[0];    MOSI_char[0]=MOSI.data.Full[1];

            while(!RTA)
            {
                chksum=0;   //inicializacion checksum
                GPIO->WriteAndReadSPI(&MOSI_char[0], &MISO_char[0],8); //Funcion de comunicacion SPI con PIgpio
                MISO.Full[7] = MISO_char[0];
                MISO.Full[6] = MISO_char[1];
                MISO.Full[5] = MISO_char[2];
                MISO.Full[4] = MISO_char[3];
                MISO.Full[3] = MISO_char[4];
                MISO.Full[2] = MISO_char[5];
                MISO.Full[1] = MISO_char[6];
                MISO.Full[0] = MISO_char[7];
                for(int i=63;i>8;i--)
                {
                    if((checksum_AND[i] & MISO.debug) != 0) chksum +=1;
                }
                RTA =  (chksum && MISO.checksum) || (intentos == 5);
                intentos++;
            }
            break;
        case 2:

              MOSI.data.debug = Funcion_FPGA(31);
              MOSI_char[7]=MOSI.NUll[0];    MOSI_char[6]=MOSI.NUll[1];    MOSI_char[5]=MOSI.NUll[2];    MOSI_char[4]=MOSI.NUll[3];
              MOSI_char[3]=MOSI.NUll[4];    MOSI_char[2]=MOSI.NUll[5];    MOSI_char[1]=MOSI.data.Full[0];    MOSI_char[0]=MOSI.data.Full[1];
              while(!RTA)
              {
                  chksum=0;   //inicializacion checksum
                  GPIO->WriteAndReadSPI(&MOSI_char[0], &MISO_char[0],8); //Funcion de comunicacion SPI con PIgpio
                  MISO.Full[7] = MISO_char[0];
                  MISO.Full[6] = MISO_char[1];
                  MISO.Full[5] = MISO_char[2];
                  MISO.Full[4] = MISO_char[3];
                  MISO.Full[3] = MISO_char[4];
                  MISO.Full[2] = MISO_char[5];
                  MISO.Full[1] = MISO_char[6];
                  MISO.Full[0] = MISO_char[7];
                  for(int i=63;i>8;i--)
                  {
                      if((checksum_AND[i] & MISO.debug) != 0) chksum +=1;
                  }
                  RTA =  (chksum && MISO.checksum) || (intentos == 5);
                  intentos++;
              }
            break;
        default:

              while(!Sincronizacion_RAM_FPGA)
              {
                  RTA=false;
                  intentos=0;
                  qDebug() << "Entro = " << Sincronizacion_RAM_FPGA;
                  while(!RTA)
                  {
                      chksum=0;
                      GPIO->WriteAndReadSPI(&MOSI_char[0], &MISO_char[0],8); //Funcion de comunicacion SPI con PIgpio
                      MISO.Full[7] = MISO_char[0];
                      MISO.Full[6] = MISO_char[1];
                      MISO.Full[5] = MISO_char[2];
                      MISO.Full[4] = MISO_char[3];
                      MISO.Full[3] = MISO_char[4];
                      MISO.Full[2] = MISO_char[5];
                      MISO.Full[1] = MISO_char[6];
                      MISO.Full[0] = MISO_char[7];
                      for(int i=63;i>8;i--)
                      {
                          if((checksum_AND[i] & MISO.debug) != 0) chksum +=1;
                      }
                      RTA =  (chksum && MISO.checksum) || (intentos == 5);
                      intentos++;
                  }

                  if(MISO.Posicion_W_RAM == 0) Sincronizacion_RAM_FPGA = Posicion_R_RAM == 28;
                  else Sincronizacion_RAM_FPGA = (Posicion_R_RAM ==(MISO.Posicion_W_RAM - 1));
                  qDebug() << MISO.Posicion_W_RAM <<"  POS_R_RAM = "<< Posicion_R_RAM <<"  Sincronizacion_RAM = " << Sincronizacion_RAM_FPGA;
                  Posicion_R_RAM++;
                  if(Posicion_R_RAM == 29) Posicion_R_RAM =0;
                  count++;
              }

            break;
        }
    }

}



void App_Mini_Mute::on_pushButton_3_pressed()
{
    QByteArray tx;
    tx.resize(2);
    tx[0]=0b11100001;
    tx[1]=0b10000000;
    GPIO->WriteSPI(tx);
    count=0;
    qDebug() << "Borrar Contadores";

    tx[0]=0b11000001;
    tx[1]=0b00000000;
    GPIO->WriteSPI(tx);
    qDebug() << "Borrar RAM";
}
