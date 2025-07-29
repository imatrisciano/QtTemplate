#pragma once

#include <QDebug>
#include <QObject>
#include <qqmlregistration.h>
#include "animatedparam.h"

class Backend : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(int temperature READ temperature WRITE setTemperature NOTIFY temperatureChanged)
    Q_PROPERTY(QString status READ status BINDABLE bindableStatus NOTIFY statusChanged)

public:
    explicit Backend(QObject *parent = nullptr);

    int temperature() const;
    void setTemperature(const int temperature);

    QString status() const;
    QBindable<QString> bindableStatus() const;

    Q_INVOKABLE bool someFunction(const QString &msg);

signals:
    void temperatureChanged();
    void statusChanged();

private:
    AnimatedParam m_temperature;
    QProperty<QString> m_status;
    QProperty<bool> m_isHot;

    void calculateRealFeel();
};
