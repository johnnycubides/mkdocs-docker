### IMAGEN BASE ###
FROM debian:unstable-slim

### TOOLS ###
RUN apt-get update

RUN apt-get install -y python3 python3-pip

RUN pip3 install mkdocs mkdocs-exclude mkdocs-material

CMD '/bin/bash'
