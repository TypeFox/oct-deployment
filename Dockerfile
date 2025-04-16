FROM node:lts-slim

ARG BUILDDIR=/home/app/build
ARG CHECHKOUT_SHA=735fbe0b66983c2be7f3df9a75a67fef21ee6de4

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
CMD [ "bash", "-c", "node /home/app/app.js --hostname=0.0.0.0" ]
