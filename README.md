# test-challenge-API
Proyecto de automatización de pruebas API con Karate-Maven-Cucumber

## Herramientas:
- **Karate**: https://www.karatelabs.io
- **MVN**: https://maven.apache.org
- **Cucumber**: https://cucumber.io/docs/cucumber/

### Ejecución de pruebas

Para ejecutar localmente el script, se requiere:

#### Requisitos
- Instalar las herramientas: IDE Intellig IDEA, jdk v18.0.2.1, Apache Maven 3.9.5
- Abrir el script de pruebas en el IDE y compilarlo como proyecto maven

#### Ejecutar todos los test
Ejecutar a nivel de terminal, ejecutando el comando:
```
- mvn clean test -Dtest=RunnerRestfulBooker#testRunner 
```
Ejecutar desde el IDE el Runner `src/test/java/RunnerRestfulBooker.java` el método `testRunner`, donde se encuentra definido el directorio que contiene los feature a considerarse src/test/java/restfulBooker

#### Ejecución de los test con un Tag asignado
Ejecutar a nivel de terminal un comando del listado:
```
- mvn clean test -Dtest=RunnerRestfulBooker#testRunner -Dkarate.options="--tags @CreateTokenSuccessful"
- mvn clean test -Dtest=RunnerRestfulBooker#testRunner -Dkarate.options="--tags @UnHappyPaths"
- mvn clean test -Dtest=RunnerRestfulBooker#testRunner -Dkarate.options="--tags @HappyPaths"
```

- Ejecutar desde el IDE el Runner `src/test/java/RunnerRestfulBooker.java` el método `testRunnerUnHappyPathss`, donde se encuentra definido el directorio que contiene los feature a considerarse `src/test/java/restfulBooker`  y el tag `@UnHappyPaths`
- Ejecutar desde el IDE el Runner `src/test/java/RunnerRestfulBooker.java` el método `testRunnerHappyPaths`, donde se encuentra definido el directorio que contiene los feature a considerarse `src/test/java/restfulBooker`  y el tag `@HappyPaths`

### Resultados
Se generan los reportes:
- `target/karate-reports/karate-summary.html` reporte Karate con el resultado de la ejecución
- `target/cucumber-html-reports/overview-features.html` reporte Cucumber con el detalle el resultado de la ejecución