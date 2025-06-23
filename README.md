# tmp shell

[Dockerhub](https://hub.docker.com/repository/docker/ar2pi/tmp-shell)

## Use

Run locally
```sh
docker run --rm -it ar2pi/tmp-shell /bin/bash
```

Run in an existing kubernetes pod
```sh
kubectl debug -n $YOUR_NAMESPACE -it --image=ar2pi/tmp-shell --share-processes --copy-to=$YOUR_PODNAME-debug --profile=general $YOUR_PODNAME
```

Run as a new kubernetes pod
```sh
kubectl run tmp-shell --restart=Never --rm -it --image ar2pi/tmp-shell -- /bin/bash
# OR
kubectl apply -f kubernetes/pod.yaml
```

## Build

```sh
# amd64 (linux)
docker build -t ar2pi/tmp-shell --platform linux/amd64 .
docker push ar2pi/tmp-shell

# arm64 (macos)
docker build -f Dockerfile.arm64 -t ar2pi/tmp-shell:arm64 .
docker push ar2pi/tmp-shell:arm64
```
