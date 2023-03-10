# cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet=1.25.0-00 kubeadm=1.25.0-00 kubectl=1.25.0-00
sudo apt-mark hold kubelet kubeadm kubectl

# kubelet=1.26.0-00 you get error when using 1.26 kubelet
# to update kubelet version: (if you need)
# apt remove --purge kubelet
# apt install -y kubeadm kubelet=1.25.5-00

sudo systemctl daemon-reload
sudo systemctl restart kubelet

sudo kubeadm init

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=/etc/kubernetes/admin.conf

# Deploy Flannel as a network plugin
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml
