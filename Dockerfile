FROM node:lts-slim

ARG BUILDDIR=/home/app/build
ARG CHECHKOUT_SHA=b8d8f2a1e20d9f84783d4b75c15e04626ce5a602

# Install git
# Clone repo and checkout specific commit
# Then build, copy bundle and clean-up build
# Remove git again
RUN apt update \
    && apt install -y git \
    && mkdir -p ${BUILDDIR} \
    && git clone https://github.com/TypeFox/open-collaboration-tools.git ${BUILDDIR} \
    && cd ${BUILDDIR} \
    && git checkout ${CHECHKOUT_SHA} \
    && cd ${BUILDDIR} \
    && npm i \
    && npm run build \
    && cp ${BUILDDIR}/packages/open-collaboration-server/bundle/app.* /home/app \
    && rm -fr ${BUILDDIR} \
    && apt remove -y git \
    && apt autoremove -y

EXPOSE 8100
WORKDIR /home/app
CMD [ "bash", "-c", "node /home/app/app.js start --hostname=0.0.0.0" ]
