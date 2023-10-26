# test-challenge-API
Proyecto de automatización de pruebas API con Karate-Maven-Cucumber

## Herramientas:
- **Karate**: https://www.karatelabs.io
- **MVN**: https://maven.apache.org
- **Cucumber**: https://cucumber.io/docs/cucumber/

## Ejecución de todos los test
- mvn clean test -Dtest=RunnerRestfulBooker#testRunner 

## Ejecución de los test con un Tag asignado
- mvn clean test -Dtest=RunnerRestfulBooker#testRunner -Dkarate.options="--tags @CreateTokenSuccessful"
- mvn clean test -Dtest=RunnerRestfulBooker#testRunner -Dkarate.options="--tags @UnHappyPaths"
- mvn clean test -Dtest=RunnerRestfulBooker#testRunner -Dkarate.options="--tags @HappyPaths"
