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


## 使用文档

## 1、docker部署(推荐)

### 下载镜像
```shell
docker pull icepage/scw:latest
```

### 运行

使用默认settings.py
```bash
docker run -p 8000:8000 icepage/scw:latest
```

自定义settings.py
```bash
docker run -v /本地路径/settings.py:/app/SmsCodebhook/settings.py -p 8000:8000 icepage/scw:latest
```

### 测试
开2个终端测试

#### 终端1
调用/api/getCode, 等待验证码
```shell
curl -X POST 'http://127.0.0.1:8000/api/getCode'  -d '{"phone_number": "13500000000"}'
```

#### 终端2
调用/api/sendSmsMsg，发送验证消息
```shell
curl -X POST 'http://127.0.0.1:8000/api/sendSmsMsg' -d '{"sms_msg": "【京东】请确认本人操作，切勿泄露给他人。您正在新设备上登录，验证码：475431。京东工作人员不会索取此验证码。"}'
```

#### 重回终端1
看到验证码返回


## 2、本地部署
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
python manage.py runserver
```


## TODO:
- 根据手机查询验证码(目前调用时只是假传手机号)


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
