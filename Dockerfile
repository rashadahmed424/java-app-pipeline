FROM alpine
RUN apk add --no-interactive --no-cache openjdk11
WORKDIR /APP
COPY ./target/spring-petclinic-*.jar .
EXPOSE 8080
CMD java -jar spring-petclinic*.jar
