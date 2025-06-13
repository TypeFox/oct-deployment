FROM node:lts-slim

ARG BUILDDIR=/home/app/build
ARG CHECHKOUT_SHA=77ee813dd7b15b5aff0f4fc195efaeb1092bd0c7

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
