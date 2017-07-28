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

The entire documentation is generated with two markdown files.

/source/index.html.md       --> main markdown  
/source/includes/_errors.md --> markdown for the error section

The styles can be edited within the /source/stylesheets/ directory. screen.css.scss is the main css file.

Edit these documents and refresh the browser to see changes (http://localhost:4567).

## How to Deploy Documentation

To deploy the documentation, run the commands.

```shell
bundle exec middleman build --clean
```

Middleman will build your website to the build directory of your project, and you can copy those static HTML files to the server.

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

## Contributers

Sungwoo Bae - swbae31@gmail.com || sungwoo@blockchainofthings.com
