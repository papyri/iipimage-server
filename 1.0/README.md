# IIPImage v1.0 container image

## Requirements

- Docker + docker-compose OR Docker for Mac/Windows
- [source-to-image](https://github.com/openshift/source-to-image)

## Usage

    $ docker pull gitlab-registry.oit.duke.edu/devops/containers/images/iipimage/1.0
    $ docker run --rm gitlab-registry.oit.duke.edu/devops/containers/images/iipimage/1.0

The default command runs the FCGI script and binds to port 9000.

## Full stack

To run a web server on port 8080 that has a reverse proxy to the image server, first build
the web server image:

    $ ./build-web.sh

Copy images to mount on the server into the `./data` folder (they will be ignored by git).
They will be mounted at the path `/data` in the container.

Then, start the stack:

    $ docker-compose up -d

Go to `http://localhost:8080/fcgi-bin/iipsrv.fcgi` in your browser. You will see the IIPImage
splash page if it is working. You can append query strings in the usual way with IIPimage
server.

If you have a file at `data/test.ptif`, it should display with an OpenSeadragon test page at
`http://localhost:8080`.

Stop the stack with:

    $ docker-compose down