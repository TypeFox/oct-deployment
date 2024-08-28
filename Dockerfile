FROM node:lts

# Clone repo and checkout specific commit
RUN mkdir -p /home/app \
    && git clone https://github.com/TypeFox/open-collaboration-tools.git /home/app \
    && cd /home/app \
    && git checkout 0bd4032fb5a0a154c9241b7f757c70e8738b5fdb

# Build
RUN cd /home/app \
    && npm i \
    && npm run build

EXPOSE 8100
WORKDIR /home/app
CMD [ "bash", "-c", "npm run start" ]
