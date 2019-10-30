#include "app_mini_mute.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    App_Mini_Mute w;
    w.show();

    return a.exec();
}
