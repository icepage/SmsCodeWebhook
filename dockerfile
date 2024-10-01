FROM python:3.10.14-slim

# 设置工作目录
WORKDIR /app

# 复制应用文件
COPY . .

# 安装依赖
RUN pip install --no-cache-dir -r requirements.txt -i https://mirrors.aliyun.com/pypi/simple/

# 安装 Redis
RUN apt-get update && \
    apt-get install -y redis-server && \
    apt-get clean


# 时区
RUN apt-get install -y tzdata
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 定义启动命令，运行 main.py
CMD ["bash", "start.sh"]

