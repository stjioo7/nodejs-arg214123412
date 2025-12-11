FROM node:alpine3.20

WORKDIR /tmp

# 1. 为了利用缓存，先只复制 package 文件
COPY package*.json ./

# 安装依赖
RUN apk update && apk upgrade &&\
    apk add --no-cache openssl curl gcompat iproute2 coreutils bash &&\
    npm install

# 2. 再复制其余代码
COPY . .

EXPOSE 3000/tcp

# 【关键步骤】添加这行来查看构建后的目录结构，看看 index.js 到底在不在
RUN ls -la /tmp

CMD ["node", "index.js"]
