# Catenis API Documentation Generator

This project uses [slate](https://github.com/lord/slate) to generate documentation for the Catenis API services.

## How to Set up Development Environment

Within the project root directory run the commands.

```shell
bundle install
bundle exec middleman server
```

You might need to install [bundler](http://bundler.io/) to run the bundle commands.

You can now see the docs at http://localhost:4567.

## How to edit the docs.

The documentation is comprised of one main markdown file (`/sorce/index.html.md`) and several include markdown files found
in the `/source/includes/` directory.

The styles can be edited within the `/source/stylesheets/` directory. `screen.css.scss` is the main css file.

Edit these documents and refresh the browser to see changes (http://localhost:4567).

## How to Deploy Documentation

Execute the shell script `predeploy.sh` to prepare the Catenis API documentation to be deployed.

To build the static site for the target API version, pass the argument `build` to the pre-deploy script. The static
contents of the site is built to the `build/` directory and copied to the appropriate directory under the
`deploy/` directory according to the target API version.

To bundle up the documentation for deployment, including the static site for all target API versions already built, pass
the argument `bundle` to the pre-deploy script. The bundled up documentation — a compressed tar file
named CatenisAPIDoc.tar.gz — is placed in the `deploy` directory.

> **UPDATE**: the bundle (tar) file should **NOT** be generated in this project anymore. To deploy the documentation, after
>building the static site(s), go to the CatenisAPIDocFrontPage project and follow the steps described in its README file.

## How to Update Slate

Some times Slate has to be updated for compatibility with new browser versions. To do this run the following commands.

```shell
git remote add upstream https://github.com/lord/slate.git
git fetch upstream
git checkout master
git merge upstream/master
```

After calling merge, the repo will likely have merge conflicts with the .md files we customized. To automatically fix the conflicts run the commands.

```shell
git checkout --ours .
```

This will let us only keep our local files. Then commit and push!

## Contributors

Sungwoo Bae - swbae31@gmail.com || sungwoo@blockchainofthings.com
