# Environment Agency Metadata Profile (EAMP)

The Environment Agency Metadata Profile (EAMP) extends the UK Gemini Metadata Profile for the Environment Agency, including two additional elements:

 * **Approval for Access (AfA) status**: This is an additional access constraint element using a controlled vocabulary to define 
the outcome of an Environment Agency legal process decision as to whether or not data and information within the data source is legally safe to share.
 * **Approval for Access (AfA) code**: This is an additional element required alongside the AfA Status to indicate the process-derived unique identifier associated with the data source.
 

## EAMP schema plugin

This is the Environment Agency's extended metadata profile, based on UK Gemini, implemented as a schema plugin for GeoNetwork 3.12.x.

**EAMP Version 1.1 is the current version of the profile, based on UK Gemini 2.2.**

See https://github.com/AstunTechnology/iso19139.eamp/wiki/Version-History for details of previous versions.

### Installing the plugin

#### GeoNetwork version to use with this plugin

Use GeoNetwork 3.12.0+ and **choose the correct branch of this repository for your version of GeoNetwork**.
This plugin is not supported in previous versions of GeoNetwork, or in versions for which there is not a corresponding git branch.


### Adding to an existing installation

 * Download or clone this repository, ensuring you choose the correct branch. 
 * Copy `src/main/plugin/iso19139.eamp` to `INSTALL_DIR/geonetwork/WEB_INF/data/config/schema_plugins/iso19139.eamp` in your installation.
 * Copy `target/schema-iso19139.eamp-3.12-SNAPSHOT.jar` to `INSTALL_DIR/geonetwork/WEB_INF/lib`
 * Restart GeoNetwork
 * Check that the schema is registered by visiting Admin Console -> Metadata and Templates -> Standards in GeoNetwork. If you do not see iso19139.eamp then it is not correctly deployed. Check your GeoNetwork log files for errors.

### Adding the plugin to the source code prior to compiling GeoNetwork

The best approach is to add the plugin as a submodule. Use https://github.com/geonetwork/core-geonetwork/blob/3.12.x/add-schema.sh for automatic deployment:

```
.\add-schema.sh iso19139.eamp http://github.com/astuntechnology/iso19139.eamp 3.12.x
```

#### Building the application 

See https://geonetwork-opensource.org/manuals/trunk/en/maintainer-guide/installing/installing-from-source-code.html. 

Ensure that you build GeoNetwork with the directive `-DschemasCopy=True` (and also use the same directive if running using the embedded jetty server plugin). For example from the GeoNetwork root directory:

```
sudo mvn clean install -DskipTests -DschemasCopy=true -Pes
cd web
sudo mvn jetty:run -DschemasCopy=true
```


Once the application is built `web/target/geonetwork.war` will contain GeoNetwork with the EAMP schema plugin included.