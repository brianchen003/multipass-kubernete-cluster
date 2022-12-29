You can use [Multipass](https://multipass.run/) to create two Ubuntu VMs and then set up a Kubernetes cluster on these two VMs. It only takes less than 6 minutes.


## Installation steps

These are the links to install and create kubernetes cluster,

0. [Download multipass](https://multipass.run/) manually.
1. [Install Container runtimes](https://kubernetes.io/docs/setup/production-environment/container-runtimes/)
2. [Install kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)
3. [Create a cluster with kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/)

### Step 1. Create two Ubuntu VMs on macOS pane,

```
git clone https://github.com/brianchen003/multipass-kubernete-cluster.git
cd multipass-kubernetes/multipass
./launch-2vm.sh
```

### Step 2. On master pane,

#### 2.1 SSH to Ubuntu VM master 

```
multipass shell master
```

#### 2.2 Install master packages

when in master VM, execute the following commands

```
sudo -i
git clone https://github.com/brianchen003/multipass-kubernete-cluster.git
cd multipass-kubernetes/master
./install-all.sh
```

#### 2.3 Copy join command

copy the output like this, and prepare to run it in Step 3.3

```
kubeadm join 192.168.64.3:6443 --token al0kvi.x60mi1xj4zesqnq3     --discovery-token-ca-cert-hash sha256:f4ff0c7684bbac599a8208b94bb28e451023662ab51bc1ce16f60a855a85e2a5
```

### Step 3. On worker pane,

#### 3.1 SSH to Ubuntu VM worker
```
multipass shell worker
```

#### 3.2 Install worker packages
when in worker,execute the following commands

```
sudo -i
git clone https://github.com/brianchen003/multipass-kubernete-cluster.git
cd multipass-kubernetes/worker
./install-all.sh
```

#### 3.3 Join master as worker

then run what you copied from Step 2, something like this,

```
sudo kubeadm join 192.168.64.3:6443 --token al0kvi.x60mi1xj4zesqnq3     --discovery-token-ca-cert-hash sha256:f4ff0c7684bbac599a8208b94bb28e451023662ab51bc1ce16f60a855a85e2a5
```

### Step 4. On second window, master

```
# kubectl get nodes
NAME         STATUS   ROLES    AGE   VERSION
master   Ready    master   34h   v1.19.0
worker   Ready    <none>   34h   v1.19.0
```

### Step 5. Delete two Ubuntu VMs on macOS pane,

After you complete practice, you can delete the VMs. Assume you are still on the same directory as Step 1.

```
./destroy.sh
```
