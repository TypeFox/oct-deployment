FROM node:lts

# Clone repo and checkout specific commit
RUN mkdir -p /home/app \
    && git clone https://github.com/TypeFox/open-collaboration-tools.git /home/app \
    && cd /home/app \
    && git checkout 420a2242509ce5cb1239540d1e5ab1c35b798ce7

# Build
RUN cd /home/app \
    && npm i \
    && npm run build

EXPOSE 8100
WORKDIR /home/app
CMD [ "bash", "-c", "npm run start" ]
