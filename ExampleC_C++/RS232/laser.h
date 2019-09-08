#ifndef LASER_H
#define LASER_H

#include <QSerialPort>
#include <QObject>

class Laser : public QObject
{
    Q_OBJECT

signals:
    QString getData(QString data);

public:
    struct Settings {
        QString name;
        qint32 baudRate;
        QString stringBaudRate;
        QSerialPort::DataBits dataBits;
        QString stringDataBits;
        QSerialPort::Parity parity;
        QString stringParity;
        QSerialPort::StopBits stopBits;
        QString stringStopBits;
        QSerialPort::FlowControl flowControl;
        QString stringFlowControl;
    };

    Laser();
    ~Laser();

public slots:
    void openSerialPort();
    void closeSerialPort();
    void writeData(QString msg);
    void readData();
    bool getConnectionStatus();

    void handleError(QSerialPort::SerialPortError error);

private:
    void updateSettings();

    QSerialPort *m_serial = nullptr;
    Settings m_settings;

};

#endif // LASER_H

