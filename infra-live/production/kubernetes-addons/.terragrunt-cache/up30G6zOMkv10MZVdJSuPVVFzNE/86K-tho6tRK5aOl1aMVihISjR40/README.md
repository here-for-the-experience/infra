

---
## Argo cd

### Check if argo cd is running

```bash
kubectl get pods -n argocd
help list -A
```

### Get the initial password:

```bash
 kubectl get secrets -n argocd -o yaml argocd-initial-admin-secret
```


The output will look something like this:
```yaml
apiVersion: v1
data:
  password: SzlkV0JlcG9CcWQ4MnR0Sw==
kind: Secret
metadata:
  creationTimestamp: "2023-07-06T20:52:13Z"
  name: argocd-initial-admin-secret
  namespace: argocd
  resourceVersion: "21400"
  uid: 8bcdfe3b-d7a0-4e2c-9c38-4f3b92656d83
type: Opaque
```

Then, base64 decode the password

```bash
echo "<password>" | base64 -d
```
In this case,

```bash
echo "SzlkV0JlcG9CcWQ4MnR0Sw==" | base64 -d
```

*Default username: admin*

### Access Argocd

Locally with port-forward:
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:80
```
And open 127.0.0.1:8080 in your browser.

