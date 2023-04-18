# sre-utils

- **Docker image:** [ar2pi/sre-utils](https://hub.docker.com/repository/docker/ar2pi/sre-utils)

## Use

```sh
# locally
docker run -it ar2pi/sre-utils /bin/bash

# in a running k8s pod
kubectl debug fooapp -it --image=ar2pi/sre-utils --share-processes --copy-to=fooapp-debug
# run a new tmp pod
kubectl run tmp-shell --restart=Never --rm -it --image ar2pi/sre-utils -- /bin/bash
```
