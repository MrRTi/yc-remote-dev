FROM hashicorp/terraform:0.14.9

RUN apk update && apk upgrade
RUN apk add bash openssh git vim make curl jq

RUN touch /root/.bashrc \
    && terraform -install-autocomplete

RUN curl https://storage.yandexcloud.net/yandexcloud-yc/install.sh | \
    bash -s -- -i /usr -a

RUN /bin/bash -c "echo \"PS1='\[\033[1;37m\]($(echo `terraform workspace show`)) \[\033[1;33m\]\u \[\033[1;36m\]\h \[\033[1;34m\]\w\[\033[0;35m\] \[\033[1;36m\]# \[\033[0m\]'\" >> /root/.bashrc "

ENV EDITOR vim

RUN mkdir -p /yc-terraform
WORKDIR /yc-terraform

ENTRYPOINT ["/bin/bash", "-l", "-c"]
