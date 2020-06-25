# jmeter-docker

This dockerize project special form of justb4/docker-jmeter. I have just added jmeter plugins and some spesific improvements.

## Image on Docker Hub

Docker image for [Apache JMeter](http://jmeter.apache.org).
This Docker image can be run as the ``jmeter`` command. 

## Building

With the script [build.sh](build.sh) the Docker image can be build
from the [Dockerfile](Dockerfile) but this is not really necessary as
you may use your own ``docker build`` commandline. Or better: use one
of the pre-built Images from [Docker Hub](https://hub.docker.com/r/justb4/jmeter).

See end of this doc for more detailed build/run/test instructions (thanks to @wilsonmar!)

### Build Options

Build argumments (see [build.sh](build.sh)) with default values if not passed to build:

- **JMETER_VERSION** - JMeter version, default ``5.3``
- **IMAGE_TIMEZONE** - timezone of Docker image, default ``"Europe/Amsterdam"``

NB **IMAGE_TIMEZONE** setting is not working yet.

## Running

The Docker image will accept the same parameters as ``jmeter`` itself, assuming
you run JMeter non-GUI with ``-n``.

There is a shorthand [run.sh](run.sh) command.
See [test.sh](test.sh) for an example of how to call [run.sh](run.sh).

## User Defined Variables

This is a standard facility of JMeter: settings in a JMX test script
may be defined symbolically and substituted at runtime via the commandline.
These are called JMeter User Defined Variables or UDVs.

See [test.sh](test.sh) and the [trivial test plan](tests/trivial/test-plan.jmx) for an example of UDVs passed to the Docker 
image via [run.sh](run.sh).

See also: http://blog.novatec-gmbh.de/how-to-pass-command-line-properties-to-a-jmeter-testplan/


## Specifics

The Docker image built from the 
[Dockerfile](Dockerfile) inherits from the [Alpine Linux](https://www.alpinelinux.org) distribution:

> "Alpine Linux is built around musl libc and busybox. This makes it smaller 
> and more resource efficient than traditional GNU/Linux distributions. 
> A container requires no more than 8 MB and a minimal installation to disk 
> requires around 130 MB of storage. 
> Not only do you get a fully-fledged Linux environment but a large selection of packages from the repository."

See https://hub.docker.com/_/alpine/ for Alpine Docker images.

The Docker image will install (via Alpine ``apk``) several required packages most specificly
the ``OpenJDK Java JRE``.  JMeter is installed by simply downloading/unpacking a ``.tgz`` archive
from http://mirror.serversupportforum.de/apache/jmeter/binaries within the Docker image.

A generic [entrypoint.sh](entrypoint.sh) is copied into the Docker image and
will be the script that is run when the Docker container is run. The
[entrypoint.sh](entrypoint.sh) simply calls ``jmeter`` passing all argumets provided
to the Docker container, see [run.sh](run.sh) script:

```
export timestamp=$(date +%Y%m%d_%H%M%S) && \
export volume_path=/home/username/docker-datas/jmeter && \
export jmeter_path=/mnt/jmeter && \
sudo docker run \
  --volume ${volume_path}:${jmeter_path} \
  jmeter \
  -Jjmeter.save.saveservice.output_format=csv \
  -n -e -o ${jmeter_path}/Report \
  -t ${jmeter_path}/Load.jmx \
  -l ${jmeter_path}/Reports/result_${timestamp}.jtl \
  -j ${jmeter_path}/Reports/jmeter_${timestamp}.log 
```

## Credits

Thanks to https://github.com/justb4/docker-jmeter, https://github.com/hauptmedia/docker-jmeter
and https://github.com/hhcordero/docker-jmeter-server for providing
the Dockerfiles that inspired me.   @wilsonmar for contributing detailed instructions. Others
that tested/reported after version updates.
