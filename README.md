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
