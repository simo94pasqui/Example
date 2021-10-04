#include "screenshot.h"

#include <QDebug>

Screenshot::Screenshot(QObject *parent) :
    QObject(parent),
    m_process(new QProcess(this))
{
}

Screenshot::~Screenshot()
{
}

QString Screenshot::launch(const QString &program)
{
    m_process->start(program);
    m_process->waitForFinished(-1);
    QByteArray bytes = m_process->readAllStandardOutput();
    QString output = QString::fromLocal8Bit(bytes);
    return output;
}

void Screenshot::takePicture()
{
    QString ret;

#ifdef __x86_64__
    ret = this->launch("import -window root /home/doss/screen.png");
#else
    ret = this->launch("./magick import  -window root /home/doss/screen.png");
#endif

    qDebug()<<__PRETTY_FUNCTION__<<ret;
}
