#include "laser.h"

#include <QDebug>
#include <QSerialPort>

Laser::Laser()
{
    m_serial = new QSerialPort(this);

    connect(m_serial, &QSerialPort::errorOccurred, this, &Laser::handleError);
    connect(m_serial, &QSerialPort::readyRead, this, &Laser::readData);

    updateSettings();
}

Laser::~Laser()
{
    m_serial->close();
}

void Laser::openSerialPort()
{
    m_serial->setPortName(m_settings.name);
    m_serial->setBaudRate(m_settings.baudRate);
    m_serial->setDataBits(m_settings.dataBits);
    m_serial->setParity(m_settings.parity);
    m_serial->setStopBits(m_settings.stopBits);
    m_serial->setFlowControl(m_settings.flowControl);
    if (m_serial->open(QIODevice::ReadWrite)) {
        QString msg = tr("Connected to %1 : %2, %3, %4, %5, %6")
                          .arg(m_settings.name).arg(m_settings.stringBaudRate).arg(m_settings.stringDataBits)
                          .arg(m_settings.stringParity).arg(m_settings.stringStopBits).arg(m_settings.stringFlowControl);
        emit getData(msg);
        //qDebug() << msg;
    } else {
        QString err = tr("Error ") + m_serial->errorString();
        emit getData(err);
        //qDebug() << err;
    }
}

void Laser::closeSerialPort()
{
    if(m_serial->isOpen())
        m_serial->close();
    emit getData("Disconnected");
}

void Laser::writeData(QString msg)
{
    const QByteArray &dataArray = msg.toUtf8();
    m_serial->write(dataArray);
}

void Laser::readData()
{
    if (m_serial->canReadLine()){
        QString data = QString::fromLatin1(m_serial->readAll());
        emit getData(data);
    }
}

bool Laser::getConnectionStatus()
{
    return m_serial->isOpen();
}

void Laser::handleError(QSerialPort::SerialPortError error)
{
    if (error == QSerialPort::ResourceError) {
        qDebug() << "Critical Error" + m_serial->errorString();
        closeSerialPort();
    }
}

void Laser::updateSettings()
{
    m_settings.name = "/dev/ttymxc0";
    m_settings.baudRate = QSerialPort::Baud9600;
    m_settings.stringBaudRate = QString::number(m_settings.baudRate);
    m_settings.dataBits = QSerialPort::Data8;
    m_settings.stringDataBits = "8";
    m_settings.parity = QSerialPort::NoParity;
    m_settings.stringParity = "None";
    m_settings.stopBits = QSerialPort::OneStop;
    m_settings.stringStopBits = "1";
    m_settings.flowControl = QSerialPort::NoFlowControl;
    m_settings.stringFlowControl = "None";
}

