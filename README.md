# SmsCodeWebook

## 介绍
- 自用验证码的接收webhook, 基于django-ninja, redis 
- 提供/api/getCode和/api/sendSmsMsg 2个接口
- 整体步骤如下：
  - 业务方手动或自动触发发送短信验证码, 然后调用SmsCodeWebook的/api/getCode, 等待返回验证码；
  - 移动端(android等) 使用工具(如SmsForwarder) 监听手机短信
  - 当工具监听到验证码短信时, 调用SmsCodeWebook的/api/sendSmsMsg接口发送短信内容；
  - SmsCodeWebook接受到短信内容后, 将验证码从短信中匹配出来, 存到redis中；
  - SmsCodeWebook从redis取出key, 返回验证码给业务方。


## 接口说明
### 1. Send SMS Message

#### Endpoint
`POST /api/sendSmsMsg`

#### Description
发送验证码短信原文

#### Body
```json
{
    "sms_msg": "请确认本人操作，切勿泄露给他人。您正在新设备上登录，验证码：475431。"
}
```

##### Content-Type: `application/json`

### 2. Get Code

#### Endpoint
`POST /api/getCode`

#### Description
获取验证码

#### Body
```json
{
    "phone_number": "13500000000"
}
```

##### Content-Type: `application/json`


## 使用文档
### 安装依赖
```commandline
pip install -r requirements.txt
```
### 安装redis
自行安装

### 配置settings.py
复制settings_example.py, 重命名为settings.py

#### 添加redis配置
编辑settings.py
```python
redis_host = '127.0.0.1'
redis_port = '6379'
redis_pass = '123456'
redis_database = '0'

CACHES = {
    'default': {
        'BACKEND': 'django_redis.cache.RedisCache',
        'LOCATION': f'redis://:{redis_pass}@{redis_host}:{redis_port}/{redis_database}',
        'OPTIONS': {
            'CLIENT_CLASS': 'django_redis.client.DefaultClient',
        }
    }
}
```

## 运行服务
```commandline
python.exe manage.py runserver
```