#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

#include "screenshot.h"

/*
 * Example Screenshot Linux with ImageMagick
 * https://imagemagick.org/script/install-source.php
 * https://imagemagick.org/script/import.php
 */

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QApplication app(argc, argv);
    QQmlApplicationEngine engine;

    Screenshot s;
    engine.rootContext()->setContextProperty("screenshot", &s);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if(engine.rootObjects().isEmpty())
    {
        return -1;
    }

    return app.exec();
}
