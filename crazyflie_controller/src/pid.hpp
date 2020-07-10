#pragma once

#include <ros/ros.h>

class PID
{
public:
    PID(
        float kp,
        float kd,
        float ki,
        float minOutput,
        float maxOutput,
        float integratorMin,
        float integratorMax,
        const std::string& name)
        : m_kp(kp)
        , m_kd(kd)
        , m_ki(ki)
        , m_minOutput(minOutput)
        , m_maxOutput(maxOutput)
        , m_integratorMin(integratorMin)
        , m_integratorMax(integratorMax)
        , m_integral(0)
        , m_previousError(0)
        , m_previousError1(0)
        , m_previousTime(ros::Time::now())
        , m_previousTime1(ros::Time::now())
    {
    }

    void reset()
    {
        m_integral = 0;
        m_previousError = 0;
        m_previousTime = ros::Time::now();
        m_previousError1 = 0;
        m_previousTime1 = ros::Time::now();
    }

    void setIntegral(float integral)
    {
        m_integral = integral;
    }

    float ki() const
    {
        return m_ki;
    }

    float update(float value, float targetValue)
    {
        ros::Time time = ros::Time::now();
        float dt = time.toSec() - m_previousTime.toSec();
        float error = targetValue - value;
        m_integral += error * dt;
        m_integral = std::max(std::min(m_integral, m_integratorMax), m_integratorMin);
        float p = m_kp * error;
        float d = 0;
        if (dt > 0)
        {
            d = m_kd * (error - m_previousError) / dt;
        }
        float i = m_ki * m_integral;
        float output = p + d + i;
        m_previousError = error;
        m_previousTime = time;
        // self.pubOutput.publish(output)
        // self.pubError.publish(error)
        // self.pubP.publish(p)
        // self.pubD.publish(d)
        // self.pubI.publish(i)
        return std::max(std::min(output, m_maxOutput), m_minOutput);
    }
    
    float velocity(float value1, float targetValue1)
    {
        ros::Time time1 = ros::Time::now();
        float dt1 = time1.toSec() - m_previousTime1.toSec();
        float error1 = targetValue1 - value1;
        float d1 = 0;
        if (dt1 > 0)
        {
            d1 = (error1 - m_previousError1) / dt1;
        }
        float output1 = d1;
        m_previousError1 = error1;
        m_previousTime1 = time1;
        // self.pubOutput.publish(output)
        // self.pubError.publish(error)
        // self.pubP.publish(p)
        // self.pubD.publish(d)
        // self.pubI.publish(i)
        return output1;
    }

private:
    float m_kp;
    float m_kd;
    float m_ki;
    float m_minOutput;
    float m_maxOutput;
    float m_integratorMin;
    float m_integratorMax;
    float m_integral;
    float m_previousError;
    float m_previousError1;
    ros::Time m_previousTime;
    ros::Time m_previousTime1;
};
