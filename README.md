<br />
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->
<p align="right">
    <a href="https://platform.sh">
        <img src="https://platform.sh/logos/redesign/Platformsh_logo_black.svg" width="120px">
    </a>
</p>
<br />
<p align="center">
    <a href="https://github.com/metabase/metabase">
        <img src="https://raw.githubusercontent.com/metabase/metabase/master/resources/frontend_client/app/assets/img/logo.svg" alt="Logo" width="120" height="120">
    </a>
    <br /><br />
    <h2 align="center">Metabase<br /></h2>
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
    <!-- <br /> -->
    <!-- <a href="https://github.com/platformsh-templates/metabase/network/members">
  <img src="https://img.shields.io/github/license/metabase/metabase.svg?style=for-the-badge&labelColor=145CC6&color=FFBDBB" alt="Deploy on Platform.sh"/>
  </a> -->
    <!-- <a href="https://github.com/platformsh-templates/metabase/graphs/contributors">
        <img src="https://img.shields.io/github/contributors/platformsh-templates/metabase.svg?style=for-the-badge&labelColor=145CC6&color=FFBDBB" alt="Deploy on Platform.sh" />
    </a> -->
    <!-- <a href="https://github.com/platformsh-templates/metabase/network/members">
        <img src="https://img.shields.io/github/forks/platformsh-templates/metabase.svg?style=for-the-badge&labelColor=145CC6&color=FFBDBB" alt="Deploy on Platform.sh" />
    </a>
    <a href="https://github.com/platformsh-templates/metabase/stargazers">
        <img src="https://img.shields.io/github/stars/platformsh-templates/metabase.svg?style=for-the-badge&labelColor=145CC6&color=FFBDBB" alt="Deploy on Platform.sh" />
    </a> -->
    <br /><br />
    <a href="https://docs.platform.sh">Platform.sh</a> ◦
    <a href="https://github.com/platformsh-templates/metabase/issues">Documentation</a> ◦
    <a href="https://github.com/platformsh-templates/metabase/issues">Blog</a> ◦
    <a href="https://docs.platform.sh">API</a> ◦
    <a href="https://docs.platform.sh">Status</a> ◦
    <a href="https://docs.platform.sh">Join our community</a><br />
    <a href="https://github.com/platformsh-templates/metabase/issues"><strong>Report a bug</strong></a> ◦
    <a href="https://github.com/platformsh-templates/metabase/issues"><strong>Request a feature</strong></a>
    <br /><br />
    <a href="https://console.platform.sh/projects/create-project?template=https://raw.githubusercontent.com/platformsh/template-builder/master/templates/metabase/.platform.template.yaml&utm_content=metabase&utm_source=github&utm_medium=button&utm_campaign=deploy_on_platform">
        <img src="https://platform.sh/images/deploy/lg-blue.svg" alt="Deploy on Platform.sh" width="170px" />
    </a>
</p>
</p>

<hr>

- [About](#about)
  - [Features](#features)
  - [Platform.sh customizations](#platformsh-customizations)
    - [Configuration](#configuration)
    - [Builds and deploys](#builds-and-deploys)
    - [Upstream modifications](#upstream-modifications)
- [Getting started](#getting-started)
  - [Post-install](#post-install)
  - [Data](#data)
- [Usage](#usage)
  - [Local development](#local-development)
  - [Updating](#updating)
  - [Migrating](#migrating)
  - [Customization](#customization)
  - [Performance](#performance)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)
- [Resources](#resources)
- [Acknowledegments](#acknowledgements)

<hr>

<br />

## About

<div>
    <p>This template builds Metabase for Platform.sh.</p>
    <p>Metabase is a simple and powerful analytics tool which lets anyone learn and make decisions from their company’s data.  The Metabase jar file is downloaded on the fly during the build hook based on the version provided in the application's configuration.</p>
</div>

### Features

- Java 11
- PostgreSQL 13
- Automatic TLS certificates
- Automatic Java heap size configuration
- Automatic upstream updates via Source Operations

## Getting started

To use this template for your metabase project, you need to go through the following steps:

- Go through the README 😉

- Clone the repo

- Make the neccessary edits and customizations to suite your needs.

- Create a new project with the [Platform.sh CLI](https://docs.platform.sh/development/cli.html)

- Configure your project remote.

- Git commit your changes

- Push to Platform.sh 🚀

### Platform.sh customizations

The following files have been added in order to download Metabase during the build hook and to deploy the application on Platform.sh. If using this template as a reference for your own project, replicate the changes below.

#### Configuration

Every application you deploy on Platform.sh is built as a **virtual cluster** containing a set of containers which defines a particular **environment**. The default branch (`master`, `main`, etc.) is always deployed as your production environment, whereas any other branch can be deployed as a development environment. Within an environment there are three types of containers, each of which are managed by three required files that have been included in this repository:

- [The **Router** container](https://docs.platform.sh/configuration/services.html):

  For each cluster/environment there will always be exactly one Router container, which is a single nginx process. It's configuration file [**`.platform/routes.yaml`**](.platform/routes.yaml) defines how incoming requests map the the appropriate Application container, while providing basic caching of responses if so configured. The Router Container has no persistent storage.

- [**Service** containers](https://docs.platform.sh/configuration/services.html):

  Each virtual cluster can have zero or more Service containers, but the file which configures them [**`.platform/services.yaml`**](.platform/services.yaml) is still required in your repository. Each top level key in that file will correspond to a separate Service container, with the kind of service determined by its `type`.

- [**Application** containers](https://docs.platform.sh/configuration/app.html) | [**`.platform.app.yaml`**](.platform.app.yaml):

#### Builds and deploys

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi non ligula iaculis, rhoncus orci a, aliquet erat. Etiam semper faucibus diam id sodales. Vestibulum nisi tellus, laoreet ac ipsum vel, volutpat placerat ipsum. Etiam a auctor felis. Cras mauris eros, gravida ac augue vel, ornare ornare magna. Aliquam tempus erat quis venenatis eleifend. Vivamus eros magna, dignissim a elit quis, cursus imperdiet urna.

#### Upstream modifications

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi non ligula iaculis, rhoncus orci a, aliquet erat. Etiam semper faucibus diam id sodales. Vestibulum nisi tellus, laoreet ac ipsum vel, volutpat placerat ipsum. Etiam a auctor felis. Cras mauris eros, gravida ac augue vel, ornare ornare magna. Aliquam tempus erat quis venenatis eleifend. Vivamus eros magna, dignissim a elit quis, cursus imperdiet urna.

- Deploying on Platform.sh requires a set of configuration files to instruct the platform how to build and deploy your applications, as well as the topology of your infrastructure.
  - The [`.platform.app.yaml`](.platform.app.yaml) file
- The [`.platform.app.yaml`](.platform.app.yaml), [`.platform/services.yaml`](.platform/services.yaml), and [`.platform/routes.yaml`](.platform/routes.yaml) files have been added. These provide Platform.sh-specific configuration and are present in all projects on Platform.sh. You may customize them as you see fit.
- A [`.environment`](.environment) file has been added to define database credentials and other environment variables for Metabase at runtime.
- A [`build.sh`](scripts/build.sh) script is included, which used the `METABASE_VERSION` environment variable set in `.platform.app.yaml` to download a version of the Metabase jar file. This script grabs the `METABASE_VERSION` environment variable via the Platform.sh CLI locally.
- A [`start.sh`](scripts/start.sh) script has been added. This file actually runs the Metabase jar run the site. Locally, the Platform.sh CLI opens a tunnel to the PostgreSQL database and mocks connection credentials before starting.

### Post-install

After the first deployment, give the JVM a minute to finish completing it's initialization tasks (until it does, you will see a 502 error page.) which take only a minute or so. Run through the Metabase installer as normal. You will not be asked for database credentials, as those are already provided via the [`.environment`](.environment) that is sourced during the deploy hook. With the installer you will be able to create admin credentials and choose your language.

The installer will allow you to add databases. Configure the database you are trying to connect, or skip that step and Metabase will load an H2 Sample Dataset to start off with.

## Usage

There are a few ways to make use this of this template, the following ways are as follows:

### Local development

You are able to test out or build this template on your local machine by following the steps below:

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

This template downloads the Metabase jar file during the build hook using the `build.sh` script. The version downloaded is dependendent on the version listed in the [`metabase.version`](metabase.version) file in the repository. The `update.sh` script can be run at any time to see if there is a [new release](https://github.com/metabase/metabase/releases) of Metabase available, updating `metabase.version` with the new version.

#### Scheduled updates

It is possible to schedule the update described above using [source operations](https://docs.platform.sh/configuration/app/source-operations.html), which are a set of commands that can be triggered to make changes to your project's code base.

A source operation has been defined for this template that is scheduled to run regularly with a cron job:

```yaml
source:
  operations:
    updates:
      command: !include
        type: string
        path: scripts/update.sh
```

The [`update.sh` script](scripts/update.sh) - when a new version of Metabase has been released - will write the latest version to `metabase.version`. That change will be staged and committed in an isolated build container source operations run on, ultimately causing a full rebuild of the environment (but not using that latest version).

This command can be triggered at any time for any environment with the CLI command:

```bash
platform source-operation:run update
```

Ideally we would like:

1. For this update to occur automatically.
2. To only occur in an isolated environment, rather than to production.

The [cron job](https://docs.platform.sh/configuration/app/cron.html) defined in [`.platform.app.yaml`](.platform.app.yaml) does exactly this:

```yaml
crons:
  auto-updates:
    spec: '0 1 * * *'
    cmd: |
      if [ "$PLATFORM_BRANCH" = updates ]; then
          platform environment:sync code data --no-wait --yes
          platform source-operation:run update --no-wait --yes
      fi
```

With this definition, the `update` source operation will check to see if a new version of Metabase is available every day at 1:00 am UTC, but _only_ on the `updates` environment. If that environment does not exist on your project it will never run.

### Migrating

**Dumping your Database**

Moving from using Metabase Cloud to a Self hosted version means you also would need to migrate your data yourself. For the migration to happen, you'll need to obtain your database dump from metabase, you can do that by refering to this [guide](https://www.metabase.com/docs/latest/operations-guide/migrating-from-h2.html) in the Metabase documentation.

**_Note: It is advised you backup your database before proceeding with the dump_**

When you have successfully obtained a dump of your data(MySQL, MariaDB or PostgreSQL) from Metabase, you'll need to populate the postgresql database service that this template uses. You can change the default database type of this template by altering the `services.yaml` file in the `.platfrom` folder if needed.

Next, you'll need to save your as database.sql. (Or any name, really, as long as it’s the same as you use below.)

Next, import the database into your Platform.sh site. The easiest way to do so is with the Platform.sh CLI by running the following command:

```bash
$ platform sql -e master < database.sql
```

The above command will connect to the database service on the master environment, through an SSH tunnel, and run the SQL import.

**Adding Previous Data Sources**

If you need to add your previous data sources, all you need to do is to build and deploy your metabase site, visit the generated route to see the metabase site live.

Next thing is to follow this [guide](https://www.metabase.com/docs/latest/administration-guide/01-managing-databases.html) in the Metabase official documentation to learn how to add various data sources.

**_Note: If you have a CSV file containing your data you'll need to upload the csv files to a database, then connect metabase to the database._**

### Customizing Metabase

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi non ligula iaculis, rhoncus orci a, aliquet erat. Etiam semper faucibus diam id sodales. Vestibulum nisi tellus, laoreet ac ipsum vel, volutpat placerat ipsum. Etiam a auctor felis. Cras mauris eros, gravida ac augue vel, ornare ornare magna. Aliquam tempus erat quis venenatis eleifend. Vivamus eros magna, dignissim a elit quis, cursus imperdiet urna.

Proin pretium et tellus sit amet sollicitudin. Aenean hendrerit risus risus. Vivamus quis nunc faucibus quam lacinia posuere et in massa. Morbi facilisis leo felis, scelerisque convallis libero hendrerit et. Nulla non sodales ante. Pellentesque cursus hendrerit dui id facilisis. Aenean faucibus tortor et nibh eleifend, a dictum orci facilisis. Pellentesque eget posuere elit. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Vivamus posuere eu leo sit amet ultrices. Donec nec feugiat est. Ut ut sem quis velit convallis pretium. Pellentesque sodales, quam quis blandit suscipit, nunc justo scelerisque enim, nec lobortis justo eros nec lacus. Curabitur quis mollis turpis, sed venenatis nibh.

<!-- ## Roadmap

This template will be actively updated and maintained. Moving forward we would be improving this template with more features like:

- [ ]
- [ ]
- [ ]
- [ ]

## Contributing

Before sending a PR, please see the [Contributing Guide](/CONTRIBUTING.md)

<!-- ### Code of Conduct

WIP

### Community License Agreement

WIP -->

## License

This template uses the [Open Source edition of Metabase](https://github.com/metabase/metabase), which is licensed under the [GNU Affero General Public License (AGPL)](https://github.com/metabase/metabase/blob/master/LICENSE-AGPL.txt).

## Contact

This template is maintained primarily by the Platform.sh Developer Relations team, and they will be notified of all issues and pull requests you open here.

- **Community:** Share your question with the community, or see if it's already been asked on our [Community site](https://community.platform.sh).
- **Slack:** If you haven't done so already, you can join Platform.sh's [public Slack](https://chat.platform.sh/) channels and ping the `@devrel_team` with any questions.
<!-- - **E-mail:** You can also reach the DevRel team directly at `devrel@platform.sh`. -->

## Resources

- [Metabase.com](https://www.metabase.com/)
- [Metabase Documentation](https://www.metabase.com/docs/latest/)
- [Metabase Repository](https://github.com/metabase/metabase)
- [Java on Platform.sh](https://docs.platform.sh/languages/java.html)

## Thanks

- [@rhubinak](https://github.com/rhubinak) for creating the original template.
- [@hacktivist123](https://github.com/hacktivist123) for integrating into the Platform.sh template catalog.

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://sheddy.xyz"><img src="https://avatars.githubusercontent.com/u/26572907?v=4?s=100" width="100px;" alt=""/><br /><sub><b>Shedrack akintayo</b></sub></a><br /><a href="https://github.com/chadwcarlson/metabase/commits?author=hacktivist123" title="Code">💻</a></td>
  </tr>
</table>

<!-- markdownlint-restore -->
<!-- prettier-ignore-end -->

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!