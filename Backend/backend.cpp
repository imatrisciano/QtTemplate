#include "backend.h"
#include <QTransform>

Backend::Backend(QObject *parent) :
    QObject(parent)
{
    //When the temperature changes (due to the animation) notify external elements
    connect(&m_temperature, &AnimatedParam::valueChanged, this, &Backend::temperatureChanged);

    m_status.setBinding([this](){
        if (m_temperature.isRunning())
            return QString("Heating/Cooling");

        if (m_isHot.value())
            return QString("Hot");
        else
            return QString("Cold");
    });

    //When temperature changes, recalculate real feel (that will in turn update status)
    connect(&m_temperature, &AnimatedParam::valueChanged, this, &Backend::calculateRealFeel);
}

int Backend::temperature() const
{
    //qDebug() << "Getting value " << m_temperature.value();
    return m_temperature.value();
}

void Backend::setTemperature(const int temperature)
{
    //qDebug() << "Setting value " << temperature;
    m_temperature.setValue(temperature);
}

QString Backend::status() const
{
    return m_status;
}

QBindable<QString> Backend::bindableStatus() const
{
    return &m_status;
}

bool Backend::someFunction(const QString& message)
{
    qDebug() << "Called the C++ method with message: " << message;
    return true;
}

void Backend::calculateRealFeel()
{
    bool isHot = m_temperature.value() > 30; // Example threshold
    m_isHot.setValue(isHot);
}
