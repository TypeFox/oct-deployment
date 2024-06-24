FROM node:lts

# Clone repo and checkout specific commit
RUN mkdir -p /home/app \
    && git clone https://github.com/TypeFox/open-collaboration-tools.git /home/app \
    && cd /home/app \
    && git checkout c44cd13d38a3d64b3240d8aee83d319e04881b1d

# Build
RUN cd /home/app \
    && npm i \
    && npm run build

EXPOSE 8100
WORKDIR /home/app
CMD [ "bash", "-c", "npm run start" ]
