[![Build](https://github.com/michael-lazar/pygopherd/workflows/Test/badge.svg)](https://github.com/michael-lazar/pygopherd/actions)
[![license GPLv2](https://img.shields.io/github/license/michael-lazar/pygopherd)](https://www.gnu.org/licenses/gpl-2.0.en.html)
[![Build and Push Docker Image](https://github.com/cmd644/pygopherd/actions/workflows/docker-image.yml/badge.svg)](https://github.com/cmd644/pygopherd/actions/workflows/docker-image.yml)

# PyGopherd

PyGopherd is a multiprotocol (gopher, gopher+, http, wap) information server. Now with Docker container support for easier setup!

[PyGopherd Online User Manual](https://michael-lazar.github.io/pygopherd/doc/pygopherd.html)

## History

This repo is a fork of [jgoerzen/pygopherd](https://github.com/jgoerzen/pygopherd)
that adds support for Python 3.

If you're upgrading from an old version of PyGopherd, see the [upgrade notes](UPGRADING.md).

## Quickstart

### Debian

Use the .deb:

```
dpkg -i pygopherd.deb
```

or

```
apt-get install pygopherd
```

### Non-Debian

First, download and install Python 3.7 or higher.

You can run pygopherd either in-place (as a regular user account) or
as a system-wide daemon. For running in-place, do this:

```
PYTHONPATH=. bin/pygopherd conf/local.conf
```

For installing,

```
python3 -m pip install .
```

Make sure that the ``/etc/pygopherd/pygopherd.conf`` names valid users
   (setuid, setgid) and valid document root (root).

### Docker Installation
There are a few ways to host a pygopherd server using Docker. Using GitHub Actions and the GHCR, a prebuilt Docker image is available.
1) Docker Run
2) Docker Compose
3) Unraid User Templates
#### Basic Docker Installation using Docker Run
Using any up-to-date version of Docker, you can run PyGopherd with: `docker run -d -p 70:70 -v /path/to/your/gopher/files:/app/gopher --name pygopherd pygopherd`
This will run the pygopherd server with the default configuration file, generating it. Gopherfiles are served from the /app/gopher directory.
If you want to use a custom configuration file (highly recommended!!!), you can add the following: `docker run -d -p 70:70 -v /path/to/your/pygopherd.conf:/app/pygopherd.conf -v /path/to/your/gopher/files:/app/gopher --name pygopherd pygopherd`

#### Docker Compose Installation
Here is an example docker-compose file that you can use:
```docker-compose.yml
version: '3'
services:
  pygopherd:
    image: ghcr.io/cmd644/pygopherd:latest
    container_name: pygopherd
    ports:
      - "70:70"
    volumes:
      - /path/to/your/pygopherd.conf:/app/pygopherd.conf
      - /path/to/your/gopher/files:/app/gopher
    restart: unless-stopped```
Then use: `docker compose up -d` which will pull the image from the prebuilt images and run using the compose file.

#### Unraid Docker Installation
Search for the "pygopherd" user template in Unraid's User Templates, and configure as necessary.
