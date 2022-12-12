FROM openjdk:11

EXPOSE 8080

ADD /target/ExamThourayaS2.jar ExamThourayaS2-1.0.jar

ENTRYPOINT ["java", "-jar", "/ExamThourayaS2-1.0.jar"]
