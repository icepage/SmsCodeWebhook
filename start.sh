#!/bin/bash

echo -e "======================1. 启动redis========================\n"
service redis-server start 2>/dev/null 
echo -e "redis启动成功...\n"

echo -e "======================2. 启动SmsCodeWebhook========================\n"
echo -e "SmsCodeWebhook正在接收请求...\n"
python manage.py runserver 0.0.0.0:8000
