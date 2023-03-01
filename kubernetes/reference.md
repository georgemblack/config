# Kubernetes Reference

* [`kubectl` cheat sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)


```
kubectl apply -f app.yaml
kubectl get pods
```

To get all containers running in a given pod:

```
kubectl get pods POD_NAME_HERE -o jsonpath='{.spec.containers[*].name}'
```

kubectl get pods nginx-1-88597f87f-wt58t -o jsonpath='{.spec.containers[*].name}'
