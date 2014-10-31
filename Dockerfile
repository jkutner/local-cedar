FROM fabiokung/cedar

ADD . /app

WORKDIR /app

RUN ./setup.sh

ENV PATH "/app/.jdk/bin:/usr/local/bin:/usr/bin:/bin"
