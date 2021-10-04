#ifndef SCREENSHOT_H
#define SCREENSHOT_H

#include <QObject>
#include <QProcess>

class Screenshot : public QObject
{
    Q_OBJECT

public:
    explicit Screenshot(QObject *parent = 0);
    ~Screenshot();

    QString launch(const QString &program);

public slots:
    void takePicture();

private:
    QProcess *m_process;
};

#endif // SCREENSHOT_H
