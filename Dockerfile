FROM debian

WORKDIR /myriad

COPY . .
COPY config.example.yaml config.yaml

RUN apt-get install -y build-essential curl
RUN curl -sSL https://get.haskellstack.org/ | sh
RUN stack install

CMD ["stack", "run"]
