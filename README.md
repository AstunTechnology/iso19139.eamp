# Environment Agency Metadata Profile (EAMP)

The Environment Agency Metadata Profile (EAMP) extends the UK Gemini Metadata Profile for the Environment Agency, including two additional elements:

 * **Approval for Access (AfA) status**: This is an additional access constraint element using a controlled vocabulary to define 
the outcome of an Environment Agency legal process decision as to whether or not data and information within the subject data product is legally safe to share.
 * **Approval for Access (AfA) code**: This is an additional element required alongside the AfA Status to indicate the process derived unique identifier associated with the subject data product.
 
**EAMP Version 1.1 is the current version of the profile, based on UK Gemini 2.2. A version based on UK Gemini 2.3 will be released in early 2020.**

## EAMP v1.1 schema plugin

This is the Environment Agency's extended metadata profile, based on Gemini 2.2, implemented as a schema plugin for GeoNetwork 3.2.x or greater.

### Installing the plugin

#### GeoNetwork version to use with this plugin

Use GeoNetwork 3.2.0+ and choose the correct branch of this repository for your version of GeoNetwork.
This plugin is supported in previous versions of GeoNetwork, or in versions for which there is not a corresponding branch.

#### Adding the plugin to the source code

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
#### Adding editor configuration

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
      
#### Build the application 

Once the application is built, the war file contains the schema plugin:

```
$ mvn clean install -Penv-prod
```

#### Deploying the profile in an existing installation

After building the application, it's possible to deploy the schema plugin manually in an existing GeoNetwork installation:

- Copy the content of the folder `chemas/iso19139.eamp/src/main/plugin` to `INSTALL_DIR/geonetwork/WEB-INF/data/config/schema_plugins/iso19139.eamp `

- Copy the jar file `schemas/iso19139.eamp/target/schema-iso19139.eamp-3.4.2-SNAPSHOT.jar` to `INSTALL_DIR/geonetwork/WEB-INF/lib`.

If there's no changes to the profile Java code or the configuration (`config-spring-geonetwork.xml`), the jar file is not required to be deployed each time.
