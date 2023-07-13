## Production Ready Repo located [here](https://github.com/reduan2660/devops-eks-with-monitoring)

## Cluster UP


*If you decided to us s3 backend,*

First, you need to set up a s3 bucket, a dynamodb table and an user. Follow this https://youtu.be/yduHaOj3XMg?t=2995
and update accordingly to this file /infra-live/terragrunt.hcl


## [Managing Multiple Environment](https://terragrunt.gruntwork.io/docs/features/work-with-multiple-aws-accounts/)



Set these two environment variable
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY

If that does not work:

Use environment variables and the AWS CLI. You first set the credentials for the security account (the one where your IAM users are defined) as the environment variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY and run aws sts assume-role --role-arn <ROLE>. This gives you back a blob of JSON that contains new AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY values you can set as environment variables to allow Terraform to use that role.

If still does not work click [here](https://terragrunt.gruntwork.io/docs/features/work-with-multiple-aws-accounts/).

---

Go to infra-live
(Go to a specific environment to ony publish that environment)

```bash
terragrunt run-all plan --terragrunt-exclude-dir kubernetes-addons
terragrunt run-all apply --terragrunt-exclude-dir kubernetes-addons


terragrunt run-all plan
terragrunt run-all apply
```
> --- 


To connect to aws eks

```bash
aws eks update-kubeconfig --name <cluster-name> --region us-east-1 --profile <profile>
```

(e.g.) aws eks update-kubeconfig --name dev-demo --region us-east-1 --profile terraform



---
## ArgoCD Configuration

Change git repo in these 2 files
- infra-live/dev/kubernetes-addons/terragrun.hcl

- infra-live/production/kubernetes-addons/terragrun.hcl
```bash
19 | deployment_git = "https://github.com/magpie-v1/deployment.git"
```

default domain : *dev.argocd.redevops.store*

### 2. Get the initial password:

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

### 3. Access Argocd

#### Configuration for modules/kubernetes-addons/6-argocd.tf

```yaml
27 |  source:
28 |    repoURL: https://github.com/reduan2660/devops-cd.git
29 |    targetRevision: HEAD
30 |    path: environments/dev/apps
```

- *repoURL:* The [repository url](https://github.com/reduan2660/devops-cd.git) where the deployment rests. 
    - If repo is private: 

- *path:* what file or directory to track. [The structure of this path points to is documented on that repo.](https://github.com/reduan2660/depops-cd/tree/main/environment/dev/apps)


Domain:

- dev.argocd.redevops.store
- argocd.redevops.store

## Monitoring

Default domains: 
- dev.grafana.redevops.store
  - admin
  - prom-operator

- grafana.redevops.store
  - admin
  - prom-operator

