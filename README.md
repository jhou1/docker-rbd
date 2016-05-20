Ceph RBD server pod for OpenShift testing.

# Making RBD server docker image
Copied from https://github.com/kubernetes/kubernetes/tree/master/test/images/volumes-tester/rbd. Made a few changes to meet our testing requirements.

# Creating Ceph RBD server pod
The rbd server pod needs to load `rbd` kernel module and needs to run as `privileged` with `hostNetwork=true`. Follow these steps to create an RBD server pod on OpenShift 3.

Edit `scc.yml`, replace `YOUR_USERNAME` with your login name, then:

```
oc create -f scc.yml
oc create -f rbd-server.json
oc create -f rbd-secret.yml
```

## Verifying your rbd server is functional

Run `oc exec rbd-server -- ceph health`, when you see **HEALTH_OK**, your rbd server pod is ready. If you haven't seen it, wait a short time until it is successfully deployed.

# Creating Persistent Volume and Claim
Run `oc get pod rbd-server -o yaml | grep podIP`, the ip of the pod is then used for you to access the rbd server.

Assume your service ip is `10.1.0.1`

```
sed -i s/#POD_IP#/10.1.0.1/ pv-rwo.json
oc create -f pv-rwo.json
oc create -f pvc-rwo.json
```

Run `oc get pv;oc get pvc`, you should see them Bound together.

# Creating tester pod

Create the pod: `oc create -f pod.json`, then run `oc get pods`, you should see the pod is `Running`.
