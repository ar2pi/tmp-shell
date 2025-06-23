# tmp shell

[Dockerhub](https://hub.docker.com/repository/docker/ar2pi/tmp-shell)

## Use

Run locally
```sh
docker run --rm -it ar2pi/tmp-shell /bin/bash
```

Run in an existing kubernetes pod
```sh
kubectl config set-context --current --namespace=$YOUR_NAMESPACE    # optional
kubectl debug -it --image=ar2pi/tmp-shell --share-processes --copy-to=$YOUR_PODNAME-debug --profile=general $YOUR_PODNAME
```

Run as a new kubernetes pod
```sh
kubectl run tmp-shell --restart=Never --rm -it --image ar2pi/tmp-shell -- /bin/bash
# OR
kubectl apply -f kubernetes/pod.yaml
```

## Build

```sh
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  -t ar2pi/tmp-shell:latest \
  --push .
```
