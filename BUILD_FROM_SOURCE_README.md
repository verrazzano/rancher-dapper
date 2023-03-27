## Build Instructions

The upstream tag this release is branched from is `v0.6.0`

### Create Environment Variables

```
export DOCKER_REPO=<Docker Repository>
export DOCKER_NAMESPACE=<Docker Namespace>
export DOCKER_TAG=<Docker Tag>
```

### Build and Push Images

By default, Dapper uses the latest tag on the Git branch as the image tag, so create the tag and run `make`:
```
git tag ${DOCKER_TAG}
make
```

Alternatively you can skip creating the tag and simply pass an environment variable to `make`:
```
TAG=${DOCKER_TAG} make
```

Once the build completes successfully, tag and push the images:
```
docker tag rancher/rancher-dapper:${DOCKER_TAG} ${DOCKER_REPO}/${DOCKER_NAMESPACE}/rancher-dapper:${DOCKER_TAG}
docker push ${DOCKER_REPO}/${DOCKER_NAMESPACE}/rancher-dapper:${DOCKER_TAG}
```
