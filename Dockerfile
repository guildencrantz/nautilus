from maven:3-jdk-8 AS builder

WORKDIR /wd

ADD https://archive.apache.org/dist/tinkerpop/3.3.2/apache-tinkerpop-gremlin-console-3.3.2-bin.zip /wd/

RUN set -x;                                                                      \
  unzip apache-tinkerpop-gremlin-console-3.3.2-bin.zip                        && \
  git clone https://github.com/aws/amazon-neptune-gremlin-java-sigv4.git      && \
  cd amazon-neptune-gremlin-java-sigv4                                        && \
  git checkout $(git describe --tags `git rev-list --tags --max-count=1`)     && \
  mvn package dependency:copy-dependencies                                    && \
  cp target/*.jar ../apache-tinkerpop-gremlin-console-3.3.2/lib               && \
  cp target/dependency/*.jar ../apache-tinkerpop-gremlin-console-3.3.2/lib    && \
  rm ../apache-tinkerpop-gremlin-console-3.3.2/lib/netty-all-4.0.56.Final.jar

from openjdk:8-jre

ENV SERVICE_REGION us-east-1

ENTRYPOINT /gremlin/bin/gremlin.sh

COPY --from=builder /wd/apache-tinkerpop-gremlin-console-3.3.2/ /gremlin
