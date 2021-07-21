<br />
<p align="right">
    <a href="https://platform.sh">
        <img src="https://platform.sh/logos/redesign/Platformsh_logo_black.svg" width="150px">
    </a>
        <br />
    <a href="https://platform.sh/blog">Blog</a> ◦
    <a href="https://docs.platform.sh">Docs</a> ◦
    <a href="https://community.platform.sh">Join our community</a>
</p>
<br />
<p align="center">
    <a href="https://github.com/metabase/metabase">
        <img src="https://raw.githubusercontent.com/metabase/metabase/master/resources/frontend_client/app/assets/img/logo.svg" alt="Logo" width="80" height="80">
    </a>
    <br /><br />
    <h2 align="center">Metabase<br /><br /></h2>
</p>

<p align="center">
    <a href="https://github.com/platformsh-templates/metabase/network/members">
        <img src="https://img.shields.io/github/workflow/status/platformsh/config-reader-python/Quality%20Assurance/master.svg?style=for-the-badge&labelColor=145CC6&color=FFBDBB" alt="Deploy on Platform.sh" />
    </a>
    <a href="https://github.com/platformsh-templates/metabase/issues">
        <img src="https://img.shields.io/github/issues/platformsh-templates/metabase.svg?style=for-the-badge&labelColor=145CC6&color=FFBDBB" alt="Deploy on Platform.sh" />
    </a>
    <a href="https://github.com/platformsh-templates/pulls">
        <img src="https://img.shields.io/github/issues-pr/platformsh-templates/metabase.svg?style=for-the-badge&labelColor=145CC6&color=FFBDBB" alt="Deploy on Platform.sh" />
    </a>
    <br />
    <!-- <a href="https://github.com/platformsh-templates/metabase/network/members">
  <img src="https://img.shields.io/github/license/metabase/metabase.svg?style=for-the-badge&labelColor=145CC6&color=FFBDBB" alt="Deploy on Platform.sh"/>
  </a> -->
    <a href="https://github.com/platformsh-templates/metabase/graphs/contributors">
        <img src="https://img.shields.io/github/contributors/platformsh-templates/metabase.svg?style=for-the-badge&labelColor=145CC6&color=FFBDBB" alt="Deploy on Platform.sh" />
    </a>
    <a href="https://github.com/platformsh-templates/metabase/network/members">
        <img src="https://img.shields.io/github/forks/platformsh-templates/metabase.svg?style=for-the-badge&labelColor=145CC6&color=FFBDBB" alt="Deploy on Platform.sh" />
    </a>
    <a href="https://github.com/platformsh-templates/metabase/stargazers">
        <img src="https://img.shields.io/github/stars/platformsh-templates/metabase.svg?style=for-the-badge&labelColor=145CC6&color=FFBDBB" alt="Deploy on Platform.sh" />
    </a>
    <br /><br />
    <a href="https://docs.platform.sh">Read the docs</a> ◦
    <a href="https://github.com/platformsh-templates/metabase/issues">Report a bug</a> ◦
    <a href="https://github.com/platformsh-templates/metabase/issues">Request a feature</a>
    <br /><br />
    <a href="https://console.platform.sh/projects/create-project?template=https://raw.githubusercontent.com/platformsh/template-builder/master/templates/metabase/.platform.template.yaml&utm_content=metabase&utm_source=github&utm_medium=button&utm_campaign=deploy_on_platform">
        <img src="https://platform.sh/images/deploy/lg-blue.svg" alt="Deploy on Platform.sh" width="170px" />
    </a>
</p>
</p>

<br />
<br />
<hr>
<br />

- [About](#about)
    - [Features](#features)
    - [Platform.sh customizations](#platformsh-customizations)
- [Getting started](#getting-started)
    - [Post-install](#post-install)
    - [Data](#data)
- [Usage](#usage)
    - [Local development](#local-development)
    - [Updates](#updates)
    - [Customization](#customization)
    - [Performance](#performance)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)
- [Resources](#resources)
- [Acknowledegments](#acknowledgements)

<br />

## About

<div>
    <p>This template builds Metabase for Platform.sh.</p>
    <p>Metabase is a simple and powerful analytics tool which lets anyone learn and make decisions from their company’s data.  The Metabase jar file is downloaded on the fly during the build hook based on the version provided in the application's configuration.</p>
</div>

### Features

* Java 11
* PostgreSQL 13
* Automatic TLS certificates
* Automatic Java heap size configuration

### Platform.sh customizations

The following files have been added in order to download Metabase during the build hook and to deploy the application on Platform.sh. If using this project as a reference for your own existing project, replicated the changes below.

- The `.platform.app.yaml`, `.platform/services.yaml`, and `.platform/routes.yaml` files have been added. These provide Platform.sh-specific configuration and are present in all projects on Platform.sh. You may customize them as you see fit.
- A `.environment` file has been added to define database credentials and other environment variables for Metabase at runtime. 
- A `build.sh` script is included, which used the `METABASE_VERSION` environment variable set in `.platform.app.yaml` to download a version of the Metabase jar file. This script grabs the `METABASE_VERSION` environment variable via the Platform.sh CLI locally.
- A `start.sh` script has been added. This file actually runs the Metabase jar run the site. Locally, the Platform.sh CLI opens a tunnel to the PostgreSQL database and mocks connection credentials before starting. 

## Getting started

### Post-install

After the first deployment, give the JVM a minute to finish completing it's initialization tasks (until it does, you will see a 502 error page.) which take only a minute or so. Run through the Metabase installer as normal. You will not be asked for database credentials, as those are already provided via the [`.environment`](.environment) that is sourced during the deploy hook. With the installer you will be able to create admin credentials and choose your language. 

The installer will allow you to add databases. Configure the database you are trying to connect, or skip that step and Metabase will load an H2 Sample Dataset to start off with.

### Migrating

## Usage

### Local development

#### Requirements

- [Platform.sh CLI](https://docs.platform.sh/development/cli.html)

#### Steps

You are able to run the `build.sh` and `start.sh` `scripts` just as they're defined in `.platform.app.yaml` to run Metabase locally. 

Download the project's current live committed version of Metabase (`variables.env.METABASE_VERSION` in `.platform.app.yaml`):

```
./scripts/build.sh
```

Then start the application for the downloaded jar file:

```
./scripts/start.sh
```

The script will automatically open a tunnel to the PostgreSQL instance on the current environment, so be sure to create a new one before making any changes. 

### Updating

This template downloads the Metabase jar file during the build hook using the `build.sh` script. The version downloaded is dependendent on the `variables.env.METABASE_VERSION` defined in `.platform.app.yaml`. 

### Customizing Metabase

## Roadmap

## Contributing

## License

## Contact

## Resources

## Acknowledgments

* [Metabase.com](https://www.metabase.com/)
* [Metabase Documentation](https://www.metabase.com/docs/latest/)
* [Metabase Repository](https://github.com/metabase/metabase)
* [Java on Platform.sh](https://docs.platform.sh/languages/java.html)
