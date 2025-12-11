FROM node:alpine3.20

WORKDIR /tmp

COPY . .

EXPOSE 3000/tcp

RUN apk update && apk upgrade &&\
    apk add --no-cache openssl curl gcompat iproute2 coreutils &&\
    apk add --no-cache bash &&\
    chmod +x index.js &&\
    npm install

# === 关键修改 ===
# 这行命令的意思是：
# 1. 启动 shell
# 2. 打印 "我想看看 /tmp 里到底有什么"
# 3. 列出当前目录 (/tmp) 下的所有文件 (ls -la)
# 4. 尝试运行 node index.js
CMD ["sh", "-c", "echo 'CHECKING FILES IN /tmp:' && ls -la /tmp && node index.js"]
