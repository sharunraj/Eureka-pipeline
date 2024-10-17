FROM openjdk:21-oracle
COPY ./target/Eurekaserver-0.0.1-SNAPSHOT.jar eurekaserver.jar

CMD ["java","-jar","eurekaserver.jar"]
