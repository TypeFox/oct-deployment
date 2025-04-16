FROM google/cloud-sdk:stable

# Prepare environment, create mounted directory and add gcloud completions
RUN mkdir -p /var/opt/gcloud \
    && echo "" && echo ". /usr/lib/google-cloud-sdk/completion.bash.inc" >> /root/.bashrc

WORKDIR /var/opt/gcloud
