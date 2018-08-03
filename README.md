# EAMP v1.1 schema plugin

This is the Environment Agency's extended metadata profile, based on Gemini 2.2, implemented as a schema plugin for GeoNetwork 3.4.x or greater.

## Installing the plugin

### GeoNetwork version to use with this plugin

Use GeoNetwork 3.4.0+.
It's not supported in previous versions of GeoNetwork, so don't plug it into it!

### Adding the plugin to the source code

The best approach is to add the plugin as a submodule into GeoNetwork schema module.

```
cd schemas
git submodule add -b 3.4.x https://github.com/AstunTechnology/iso19139.eamp iso19139.eamp
```

Add the new module to the schema/pom.xml:

```
  <module>iso19139</module>
  <module>iso19139.eamp</module>
</modules>
```

Add the dependency in the web module in web/pom.xml:

```
<dependency>
  <groupId>${project.groupId}</groupId>
  <artifactId>schema-iso19139.eamp</artifactId>
  <version>${gn.schemas.version}</version>
</dependency>
```

Add the module to the webapp in `web/pom.xml`:

```
<execution>
  <id>copy-schemas</id>
  <phase>process-resources</phase>
  ...
  <resource>
    <directory>${project.basedir}/../schemas/iso19139.eamp/src/main/plugin</directory>
    <targetPath>${basedir}/src/main/webapp/WEB-INF/data/config/schema_plugins</targetPath>
  </resource>
```
### Adding editor configuration

Editor configuration in GeoNetwork 3.4.x is done in `schemas/iso19139.eamp/src/main/plugin/iso19139.eamp/layout/config-editor.xml` inside each view. Default values are the following:

      <sidePanel>
        <directive data-gn-onlinesrc-list=""/>
        <directive gn-geo-publisher=""
                   data-ng-if="gnCurrentEdit.geoPublisherConfig"
                   data-config="{{gnCurrentEdit.geoPublisherConfig}}"
                   data-lang="lang"/>
        <directive data-gn-validation-report=""/>
        <directive data-gn-suggestion-list=""/>
        <directive data-gn-need-help="user-guide/describing-information/creating-metadata.html"/>
      </sidePanel>
      
### Build the application 

Once the application is build, the war file contains the schema plugin:

```
$ mvn clean install -Penv-prod
```

### Deploy the profile in an existing installation

After building the application, it's possible to deploy the schema plugin manually in an existing GeoNetwork installation:

- Copy the content of the folder `chemas/iso19139.eamp/src/main/plugin` to `INSTALL_DIR/geonetwork/WEB-INF/data/config/schema_plugins/iso19139.eamp `

- Copy the jar file `schemas/iso19139.eamp/target/schema-iso19139.eamp-3.4.2-SNAPSHOT.jar` to `INSTALL_DIR/geonetwork/WEB-INF/lib`.

If there's no changes to the profile Java code or the configuration (`config-spring-geonetwork.xml`), the jar file is not required to be deployed each time.