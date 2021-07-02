FROM hashicorp/terraform:0.14.9

RUN apk update && apk upgrade
RUN apk add bash openssh git vim make curl

RUN touch /root/.bashrc \
    && terraform -install-autocomplete

RUN curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | \
    bash -s -- -i /usr -a

ENV EDITOR vim

RUN mkdir -p /yc-terraform
WORKDIR /yc-terraform

ENTRYPOINT ["/bin/bash", "-l", "-c"]
