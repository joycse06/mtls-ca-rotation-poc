FROM ruby:2.7.1-alpine3.12

ARG CONSUL_TEMPLATE_VERSION="0.25.0"
ENV TEMPLATE_HOME   /app/consul_template
ENV SCRIPTS_HOME    /app/scripts

RUN apk --no-cache add curl unzip bash

ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 /usr/local/bin/dumb-init
RUN chmod +x /usr/local/bin/dumb-init

RUN mkdir -p /tmp
RUN curl -L https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip > /tmp/consul_template.zip

# Unzip consul-template
RUN unzip /tmp/consul_template.zip -d /usr/local/bin

# Update consul-template permissions
RUN chmod 0755 /usr/local/bin/consul-template && \
    chown root:root /usr/local/bin/consul-template

# Copy custom configuration files from the current directory
RUN mkdir -p /app 
WORKDIR /app

COPY template ${TEMPLATE_HOME}
COPY scripts ${SCRIPTS_HOME}

# Setup ENV vars and Args to allow building images with different defaults
# We have validation on the script which will validate the values, so setting them to '' by default is OK
ARG vault_token=''
ARG pki_consul_root_key=''
ARG pki_output_path=''
ARG pki_certificate_issue_role=''
ARG pki_ttl=''
ARG vault_addr=''
ARG consul_address=''


ENV VAULT_ADDR=$vault_addr
ENV CONSUL_ADDRESS=$consul_address
ENV VAULT_RENEW_TOKEN="false"
ENV VAULT_TOKEN=$vault_token
ENV PKI_CONSUL_ROOT_KEY=$pki_consul_root_key
ENV PKI_OUTPUT_PATH=$pki_output_path
ENV PKI_CERTIFICATE_ISSUE_ROLE=$pki_certificate_issue_role
ENV PKI_TTL=$pki_ttl

ENTRYPOINT ["/usr/local/bin/dumb-init"]
CMD ["/app/scripts/run_consul_template"]
