FROM node:lts

# Clone repo and checkout specific commit
RUN mkdir -p /home/app \
    && git clone https://github.com/TypeFox/open-collaboration-tools.git /home/app \
    && cd /home/app \
    && git checkout 62fdd2c6795ba04fb5b9cb07415a484da5020e77

# Build
RUN cd /home/app \
    && npm i \
    && npm run build

EXPOSE 8100
WORKDIR /home/app
CMD [ "bash", "-c", "npm run start" ]
