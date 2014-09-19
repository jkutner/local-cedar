FROM fabiokung/cedar

ADD . /app

WORKDIR /app

RUN ./setup.sh

ENV PATH "/app/.jdk/bin:/usr/local/bin:/usr/bin:/bin"

RUN java -Xms768M -Xmx1024M -Xss4M -XX:+CMSClassUnloadingEnabled \
         -Dfile.encoding=UTF8 -Dsbt.log.noformat=true \
         -jar .sbt_home/sbt-launch.jar \
         clean compile stage
