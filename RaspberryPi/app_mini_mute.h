#ifndef APP_MINI_MUTE_H
#define APP_MINI_MUTE_H
#include <crpigpio.h>
#include <QMainWindow>
#include "crpigpio.h"
#include <QBitArray>
#include <QTime>
#include <QList>

namespace Ui {
class App_Mini_Mute;
}

class App_Mini_Mute : public QMainWindow
{
    Q_OBJECT

public:
    explicit App_Mini_Mute(QWidget *parent = 0);
    ~App_Mini_Mute();

    typedef union __tag_mosi
    {
        struct
        {
            unsigned relleno : 7;
            unsigned checksum : 3;
            unsigned info : 5;
            unsigned modo : 1;
        };
        char Full[2];
        unsigned short debug;
    } MOSI_FPGA;

    typedef union __tag_mosi_ram_fpga
    {
        struct
        {
            char NUll[6];
            MOSI_FPGA data;
        };
        uint64_t debug_buffer;
    } MOSI_RAM_FPGA;


    typedef union __tag_miso
    {
        struct
        {
            unsigned relleno: 4;
            unsigned checksum : 6;
            unsigned sincr: 1;
            unsigned Posicion_W_RAM : 5;
            unsigned Bit_PPS : 1;
            unsigned Tiempo_FPGA_Evento : 26;
            unsigned Particulas : 12;
            unsigned Null: 9;
        };
        char Full[8];
        uint64_t debug;
    } MISO_FPGA;

private slots:

    void on_comboBox_activated(const QString &arg1);

    void on_Normal_actual_SpinVoltajeUmbral_5_valueChanged(double arg1);
    void atentSincronizacion_RAM_FPGA();
    void Read_save_data_FPGA(uint8_t MODO);

    void on_pushButton_3_pressed();

private:
    Ui::App_Mini_Mute *ui;
    QTimer *tmr2;
    QTimer *tmr3;

    Crpigpio *GPIO;     //Declaracion de GPIO
    Crpigpio *DAC;      //Declaracion de objeto DAC
    int count;
    void FTIME();       //Funcion para actualizar el tiempo
    uint8_t Posicion_R_RAM;
    void SHOW_NOW();    //Funcion para actualizar interfaz
    void Wirite_DAC(double Voltaje);
    void OnISR(int gpio,int level,quint32 timeout);
    unsigned short Funcion_FPGA(int Funcion); // Funcion con las Funciones posibles de la FPGA del detector
    bool PPS_ON;
    bool Sincronizacion_RAM_FPGA;
    int antcount;
    uint8_t minuto;
    int ant_FlujoMinuto;
    QList<uint64_t> checksum_AND;
};

#endif // APP_MINI_MUTE_H
