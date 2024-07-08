FROM node:lts

# Clone repo and checkout specific commit
RUN mkdir -p /home/app \
    && git clone https://github.com/TypeFox/open-collaboration-tools.git /home/app \
    && cd /home/app \
    && git checkout 3dec8a1f789851506d705a0e46086476cceb1235

# Build
RUN cd /home/app \
    && npm i \
    && npm run build

EXPOSE 8100
WORKDIR /home/app
CMD [ "bash", "-c", "npm run start" ]
