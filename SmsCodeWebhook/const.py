# redis的key名
code_key = "code"
# 验证码的redis的ttl
CODE_TIMEOUT = 60
# 轮询等待时间（秒）
WAIT_TIME = 1
# 获取验证码最大等待时间（秒）
MAX_WAIT_TIME = 60
# 匹配验证码正则表达式
sms_code_pattern = r'\b\d{6}\b'