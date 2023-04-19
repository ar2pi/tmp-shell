# tmp shell

- **Docker image:** [ar2pi/tmp-shell](https://hub.docker.com/repository/docker/ar2pi/tmp-shell)

## Use

```sh
# run locally
docker run --rm -it ar2pi/tmp-shell /bin/bash

# run in a running k8s pod
kubectl debug fooapp -it --image=ar2pi/tmp-shell --share-processes --copy-to=fooapp-debug
# run as a new tmp pod
kubectl run tmp-shell --restart=Never --rm -it --image ar2pi/tmp-shell -- /bin/bash
# OR
kubectl apply -f kubernetes/pod.yaml
```

## Build

```sh
docker build -t ar2pi/tmp-shell --platform linux/amd64 .
docker push ar2pi/tmp-shell
```
