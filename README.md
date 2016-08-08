# Sample project for STM 2016

This is a sample project to implement web applications in this STM.

This project is designed to quickly start up development.

Our evaluation is concentrating on business functions and code quality.
Basically you could change everything of this project to fit your need.
You can even use other frameworks if you like.

**But in order to deploy your application successfully, please pay attention on the "Cautions" part.**

## Background knowledge

To develop web applications, you should firstly have basic knowledge about HTML, CSS and JavaScript.

Besides, this sample project uses Spring Framework for server side, you need to check Spring Boot, Spring JDBC Template.

To access relational database, SQL is required.

## Development Environment

Set up [Project Lombok](https://projectlombok.org/) for your IDE (Eclipse) at first.

Use Eclipse and import this project as Maven project.

## Development Mode

This is the default mode, and embedded H2 database will be used.
You can customize its behaviour for your need.

But it is generally recommended that you should not use production database for development.

## Production Mode

At first, copy `src/main/resources/application-production.properties.example` to `src/main/resources/application-production.properties` and fill in your production database information.

But specifying `-Dspring.profiles.active=production` as VM options, such as what the `Procfile` does, the application will start up under production mode.

## Package & Submit

Run `mvnw assembly:single` (or `mvnw.cmd` in Windows) to package the bundle, and then submit the zip file generated in `target` through STM web system.

Hint: you can use `mvnw` instead of `mvn` during your development. `mvnw` will download and install maven automatically so you don't need to do it.

## Cautions

1. The submitted content should follow [Heroku Standard](https://devcenter.heroku.com/articles/getting-started-with-java#define-a-procfile),
`Procfile` must exist to describe how to run the application. You may need to change the jar file name in `Procfile` if you change application name or version.
2. Your applications will be deployed by STM web system using **Heroku Java Buildpack**.
3. `src/assembly/bundle.xml` describe the content of the zip bundle. If you add files which are required to run your application, you need to add them in it.
4. You **must** use production database in deployed application.