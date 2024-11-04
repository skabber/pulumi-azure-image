FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
  apt-transport-https ca-certificates curl gnupg lsb-release \
  build-essential procps file git golang
RUN mkdir -p /etc/apt/keyrings
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | \
  gpg --dearmor | \
  tee /etc/apt/keyrings/microsoft.gpg > /dev/null
# ENV SUITE="$(lsb_release -cs)" # noble
RUN echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ noble main" | \
  tee /etc/apt/sources.list.d/microsoft.list
COPY 99microsoft /etc/apt/preferences.d/99-microsoft
RUN apt-get update && \
  apt-get install -y azure-cli

RUN curl -fsSL https://get.pulumi.com | sh -s -- --install-root "/usr/"
