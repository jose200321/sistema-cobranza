

FROM maven:3.8.5-openjdk-8 AS build

WORKDIR /app


COPY pom.xml .

# 2. Copiamos todo tu código fuente (Java, JSP, WEB-INF, etc.)
COPY src ./src

# 3. Ejecutamos el comando Maven para empaquetar el proyecto (genera el archivo .war)
RUN mvn clean package -DskipTests


FROM tomcat:9.0-jdk8-openjdk-slim


RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war


EXPOSE 8080


CMD ["catalina.sh", "run"]