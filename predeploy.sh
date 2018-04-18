#!/bin/bash
API_DIR="0.5"

# Check if static site should be built
if [[ $1 = "build" || $2 = "build" ]]
  then
    echo "Building static site..."

    # Build static site
    bundle exec middleman build --clean

    # Create deploy directory if it does not yet exist
    if [ ! -d deploy ]
      then
        mkdir deploy
    fi

    # Copy static site contents to specific directory according to API version
    if [ -d deploy/$API_DIR ]
      then
        rm -r deploy/$API_DIR
    fi

    cp -R build/ deploy/$API_DIR/
fi

# Check if bundle (tar) file should be generated
if [[ $1 = "bundle" || $2 = "bundle" ]]
  then
    echo "Generating bundle (tar) file to deploy..."

    # Create deploy directory if it does not yet exist
    if [ ! -d deploy ]
      then
        mkdir deploy
    fi

    if [ -f deploy/CatenisAPIDoc.tar.gz ]
      # Save previous bundle file by changing its name (add time stamp to it)
      then
        t=`stat -t %C%y-%m-%d -f %Sm deploy/CatenisAPIDoc.tar.gz`
        mv deploy/CatenisAPIDoc.tar.gz "deploy/CatenisAPIDoc.$t.tar.gz"
    fi

    # Generate the bundle file itself
    cd deploy
    tar -czf CatenisAPIDoc.tar.gz --exclude '*.tar.gz' *
fi
