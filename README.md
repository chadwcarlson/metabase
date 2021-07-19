# Metabase template for Platform.sh

This template builds Metabase for Platform.sh.

Metabase is a simple and powerful analytics tool which lets anyone learn and make decisions from their company’s data. The Metabase jar file is downloaded on the fly during the build hook based on the version provided in the application's configuration.

## Features

* Java 11
* PostgreSQL 13
* Automatic TLS certificates
* Automatic Java heap size configuration

## Post-install

After the first deployment, give the JVM a minute to finish completing it's initialization tasks (until it does, you will see a 502 error page.) which take only a minute or so. Run through the Metabase installer as normal. You will not be asked for database credentials, as those are already provided via the [`.environment`](.environment) that is sourced during the deploy hook. With the installer you will be able to create admin credentials and choose your language. 

The installer will allow you to add databases. Configure the database you are trying to connect, or skip that step and Metabase will load an H2 Sample Dataset to start off with.

## Customizations

The following files have been added in order to download Metabase during the build hook and to deploy the application on Platform.sh. If using this project as a reference for your own existing project, replicated the changes below.

- The `.platform.app.yaml`, `.platform/services.yaml`, and `.platform/routes.yaml` files have been added. These provide Platform.sh-specific configuration and are present in all projects on Platform.sh. You may customize them as you see fit.
- A `.environment` file has been added to define database credentials and other environment variables for Metabase at runtime. 
- A `mb-build.sh` script is included, which used the `METABASE_VERSION` environment variable set in `.platform.app.yaml` to download a version of the Metabase jar file. This script grabs the `METABASE_VERSION` environment variable via the Platform.sh CLI locally.
- A `mb-start.sh` script has been added. This file actually runs the Metabase jar run the site. Locally, the Platform.sh CLI opens a tunnel to the PostgreSQL database and mocks connection credentials before starting. 

## Local development

### Requirements

- [Platform.sh CLI](https://docs.platform.sh/development/cli.html)

### Steps

You are able to run the `mb-build.sh` and `mb-start.sh` scripts just as defined in `.platform.app.yaml` to run Metabase locally. 

Download the project's current live committed version of Metabase (`variables.env.METABASE_VERSION` in `.platform.app.yaml`):

```
./mb-build.sh
```

Then start the application for the downloaded jar file:

```
./mb-start.sh
```

The script will automatically open a tunnel to the PostgreSQL instance on the current environment, so be sure to create a new one before making any changes. 

## References

* [Metabase.com](https://www.metabase.com/)
* [Metabase Documentation](https://www.metabase.com/docs/latest/)
* [Metabase Repository](https://github.com/metabase/metabase)
* [Java on Platform.sh](https://docs.platform.sh/languages/java.html)
