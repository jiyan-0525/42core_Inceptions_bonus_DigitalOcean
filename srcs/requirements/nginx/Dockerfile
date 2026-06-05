FROM debian:bullseye

# 安装 Nginx 和 OpenSSL
RUN apt-get update && apt-get install -y nginx openssl && rm -rf /var/lib/apt/lists/*

# 创建存放 SSL 证书的目录
RUN mkdir -p /etc/nginx/ssl

# 生成自签名 SSL 证书 (替换为你自己的 42 login 字段)
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=DE/ST=BW/L=Heilbronn/O=42/OU=42Heilbronn/CN=login.42.fr"

# 将本地写好的配置文件复制到容器中
COPY conf/nginx.conf /etc/nginx/sites-available/default

# 暴露 443 端口
EXPOSE 443

# 让 Nginx 在前台运行（DevOps 容器化标准：容器内的核心主进程不能在后台挂起，否则容器会自动退出）
CMD ["nginx", "-g", "daemon off;"]