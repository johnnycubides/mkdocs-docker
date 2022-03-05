# mkdocs-docker

## Realizar PUSH en dockerhub

Instalar de podman
```bash
sudo apt install podman -y
```

Realizar el login a *dockerhub*
```bash
podman login docker.io
```

**Observación**: si se genera el siguiente error deberá configurar los permisos o hacer uso de `sudo` en los comando que requieran **podman**

> :warning:
> Error: command required for rootless mode with multiple IDs: exec: "newuidmap": executable file not found in $PATH


Clonar este proyecto y entrar al directorio
```bash
git clone git@github.com:johnnycubides/mkdocs-docker.git
cd mkdocs-docker/
```

Construir la imagen localmente
```bash
podman build -t docker.io/johnnycubides/catalejo-mkdocs-compiler:latest .
```

Hacer el push de la imagen a dockerhub
```bash
podman push docker.io/johnnycubides/catalejo-mkdocs-compiler:latest
```

## ¿Cómo remover imágenes de contenedores?

Listar imágenes

```bash
sudo podman images
```

Ejemplo:
```bash
podman images
REPOSITORY                                        TAG            IMAGE ID      CREATED         SIZE
docker.io/johnnycubides/catalejo-mkdocs-compiler  latest         e62f8392ab2a  43 minutes ago  517 MB
docker.io/library/debian                          unstable-slim  e71fe6da6d20  4 days ago      85.6 MB
```

Con el *IMAGE ID* puede remover la imagen con el comando `podman rmi IMAGE_ID`, ejemplo:

```bash
podman rmi e62f8392ab2a
Untagged: docker.io/johnnycubides/catalejo-mkdocs-compiler:latest
Deleted: e62f8392ab2a0eadda23fea2211f1f36a30e1332f1e2138e98b7c07decab4b55
Deleted: 571eeba3b5e0360e703929e47a1d50662b3ee101a3bd29b76ba7ecb29cb3416a
Deleted: 6c6c2960267a02e60b655e7f7d97f098a023b94de649cabdba7c272459152e7d
Deleted: 00df5777114fffe2e659a2f873ec36f0f91a2ff79153541fe5d6365e4475c9e8
```

## Hacer uso de CI/CD

A continuación se muestra un **ejemplo** de uso en `gitlab`; se crea una archivo con el nombre `.gitlab-ci.yml` con
el siguiente contenido:

```yalm
# This file is a template, and might need editing before it works on your project.
# To contribute improvements to CI/CD templates, please follow the Development guide at:
# https://docs.gitlab.com/ee/development/cicd/templates.html
# This specific template is located at:
# https://gitlab.com/gitlab-org/gitlab/-/blob/master/lib/gitlab/ci/templates/Bash.gitlab-ci.yml

# See https://docs.gitlab.com/ee/ci/yaml/README.html for all available options

# you can delete this line if you're not using Docker
# image: busybox:latest

image: johnnycubides/catalejo-mkdocs-compiler:latest

pages:
  stage: deploy
  script:
    - mkdocs build -c -f malokalabs-app/mkdocs-web.yml
    - mkdir public
    - mv malokalabs-app/build public/malokalabs-app
  artifacts:
    paths:
      - public
  #only:
  #- master
  rules:
    - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH

```
