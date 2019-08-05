# This README File lists down steps to setup Kubenertes Cluster and the configurations that need to be done.

# The Cluster configuration

The cluster for this excercise has below hardware setup:
 3x Master nodes - each node having 2 CPUs, 7.5GB RAM and 10 GB Disk space.

 3x worker nodes - Each having 1 CPU, 4GB RAM and 10GB storage.

 The 3x master has been chosen to setup cluster so that it can meet the specifications of Raft consensus protocol and it is high availability cluster. It can sustain the failure of 1 node.

 
Step 1 - Cluster setup

The cluster for this excercise will be setup on the Google Cloud Platform. We need to setup 3x Master nodes and 3x worker nodes.

Each master node will have below hardware configuration setup

Each worker node will have below hardware configuration setup

Every node of the cluster is running Ubuntu 19.04.


Step 2 -  Setup Master Kubernetes Servers

# Execute below commands on all 3 master nodes

# Update Kubernetes Master nodes:

'''console
sudo apt-get update
sudo apt-get install -y apt-transport-https curl
sudo cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
'''

###Change to root user to add keys for <>

'''console
su passwd
su root
'''

### Turn off Swap
'''console
swapoff -a
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
'''

Exit out of root user

'''console
exit
'''
#update the system

'''console
sudo apt-get update
sudo apt-get install
sudo apt-get install docker
####Or 
sudo apt install docker.io
'''

# Install niginx to act as load balancer on the nodes

# Add below configuration to the /etc/nginx/config file

'''console
/etc/nginx/nginx.conf 
user www-data;
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
        worker_connections 768;
        # multi_accept on;
}
stream {
        upstream stream_backend 
                {
                least_conn;
                server <masternode-1 IP>
                server <masternode-2 IP>
                server <masternode-3 IP>
                }
        server {
                listen 6443;
                proxy_pass      stream_backend;
                proxy_timeout   3s;
                proxy_connect_timeout   1s;
                }
        }
http {

        ##
        # Basic Settings
        ##

        sendfile on;
        tcp_nopush on;
        tcp_nodelay on;
        keepalive_timeout 65;
        types_hash_max_size 2048;
        # server_tokens off;

        # server_names_hash_bucket_size 64;
        # server_name_in_redirect off;

        include /etc/nginx/mime.types;
        default_type application/octet-stream;

        ##
        # SSL Settings
        ##

        ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3; # Dropping SSLv3, ref: POO
DLE
        ssl_prefer_server_ciphers on;

        ##
       ##
        # Logging Settings
        ##

        access_log /var/log/nginx/access.log;
        error_log /var/log/nginx/error.log;

        ##
        # Gzip Settings
        ##

        gzip on;

        # gzip_vary on;
        # gzip_proxied any;
        # gzip_comp_level 6;
        # gzip_buffers 16 8k;
        # gzip_http_version 1.1;
        # gzip_types text/plain text/css application/json application/javascrip
t text/xml application/xml application/xml+rss text/javascript;

        ##
        # Virtual Host Configs
        ##

        include /etc/nginx/conf.d/*.conf;
        include /etc/nginx/sites-enabled/*;
}


#mail {
#       # See sample authentication script at:
#       # http://wiki.nginx.org/ImapAuthenticateWithApachePhpScript
# 
#       # auth_http localhost/auth.php;
#       # pop3_capabilities "TOP" "USER";
#       # imap_capabilities "IMAP4rev1" "UIDPLUS";
# 
#       server {
#               listen     localhost:110;
#               protocol   pop3;
#               proxy      on;
#       }
# 
#       server {
#               listen     localhost:143;
#               protocol   imap;
#               proxy      on;
#       }
#}

'''


# Reload nginx configuration

# check that nginx is running correctly

'''console
yasirms_al@kubemaster1:~$ curl 10.128.0.8
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
'''


## Initialize The Kube Cluster

### run below command on the one of the Kubemaster server to initialize the Kubernetes cluster:

'''console

sudo kubeadm init \
--config=/etc/kubernetes/kubeadm/kubeadm-config.yaml --experimental-upload-certs
'''

Here is the sample output

'''console
Flag --experimental-upload-certs has been deprecated, use --upload-certs instead
[init] Using Kubernetes version: v1.15.1
[preflight] Running pre-flight checks
        [WARNING IsDockerSystemdCheck]: detected "cgroupfs" as the Docker cgroup driver. The recommended driver is "systemd". Please follow the guide at https://kubernetes.io/docs/setup/cri/
[preflight] Pulling images required for setting up a Kubernetes cluster
[preflight] This might take a minute or two, depending on the speed of your internet connection
[preflight] You can also perform this action in beforehand using 'kubeadm config images pull'
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Activating the kubelet service
[certs] Using certificateDir folder "/etc/kubernetes/pki"
[certs] Generating "ca" certificate and key
[certs] Generating "apiserver" certificate and key
[certs] apiserver serving cert is signed for DNS names [kubemaster1 kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 10.128.0.8 10.128.0.8]
[certs] Generating "apiserver-kubelet-client" certificate and key
[certs] Generating "front-proxy-ca" certificate and key
[certs] Generating "front-proxy-client" certificate and key
[certs] Generating "etcd/ca" certificate and key
[certs] Generating "etcd/server" certificate and key
[certs] etcd/server serving cert is signed for DNS names [kubemaster1 localhost] and IPs [10.128.0.8 127.0.0.1 ::1]
[certs] Generating "etcd/healthcheck-client" certificate and key
[certs] Generating "apiserver-etcd-client" certificate and key
[certs] Generating "etcd/peer" certificate and key
[certs] etcd/peer serving cert is signed for DNS names [kubemaster1 localhost] and IPs [10.128.0.8 127.0.0.1 ::1]
[certs] Generating "sa" key and public key
[kubeconfig] Using kubeconfig folder "/etc/kubernetes"
[kubeconfig] Writing "admin.conf" kubeconfig file
[kubeconfig] Writing "kubelet.conf" kubeconfig file
[kubeconfig] Writing "controller-manager.conf" kubeconfig file
[kubeconfig] Writing "scheduler.conf" kubeconfig file
[control-plane] Using manifest folder "/etc/kubernetes/manifests"
[control-plane] Creating static Pod manifest for "kube-apiserver"
[control-plane] Creating static Pod manifest for "kube-controller-manager"
[control-plane] Creating static Pod manifest for "kube-scheduler"
[etcd] Creating static Pod manifest for local etcd in "/etc/kubernetes/manifests"
[wait-control-plane] Waiting for the kubelet to boot up the control plane as static Pods from directory "/etc/kubernetes/manifests". This can take up to 4m0s
[apiclient] All control plane components are healthy after 22.518094 seconds
[upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
[kubelet] Creating a ConfigMap "kubelet-config-1.15" in namespace kube-system with the configuration for the kubelets in the cluster
[upload-certs] Storing the certificates in Secret "kubeadm-certs" in the "kube-system" Namespace
[upload-certs] Using certificate key:
4cea22cf50d89201ae4d4e351d7bebe1d0a06ca8661182adf9782e0998ff9a84
[mark-control-plane] Marking the node kubemaster1 as control-plane by adding the label "node-role.kubernetes.io/master=''"
[mark-control-plane] Marking the node kubemaster1 as control-plane by adding the taints [node-role.kubernetes.io/master:NoSchedule]
[bootstrap-token] Using token: pgwl7n.nd15qpef7sizc9wz
[bootstrap-token] Configuring bootstrap tokens, cluster-info ConfigMap, RBAC Roles
[bootstrap-token] configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
[bootstrap-token] configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
[bootstrap-token] configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
[bootstrap-token] Creating the "cluster-info" ConfigMap in the "kube-public" namespace
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of the control-plane node running the following command on each as root:

  kubeadm join 10.128.0.8:6443 --token pgwl7n.nd15qpef7sizc9wz \
    --discovery-token-ca-cert-hash sha256:e261e907ea9d4c222cd3fb53bb95786894e9b1735cde9074d3812b04024c502d \
    --control-plane --certificate-key 4cea22cf50d89201ae4d4e351d7bebe1d0a06ca8661182adf9782e0998ff9a84

Please note that the certificate-key gives access to cluster sensitive data, keep it secret!
As a safeguard, uploaded-certs will be deleted in two hours; If necessary, you can use 
"kubeadm init phase upload-certs --upload-certs" to reload certs afterward.

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 10.128.0.8:6443 --token pgwl7n.nd15qpef7sizc9wz \
    --discovery-token-ca-cert-hash sha256:e261e907ea9d4c222cd3fb53bb95786894e9b1735cde9074d3812b04024c502d 

'''

#Note down the strings that need to be used to join Master kubernetes server as Master and as worker node. In the example above below are the two commands to join the cluster

'''console


You can now join any number of the control-plane node running the following command on each as root:

  kubeadm join 10.128.0.8:6443 --token pgwl7n.nd15qpef7sizc9wz \
    --discovery-token-ca-cert-hash sha256:e261e907ea9d4c222cd3fb53bb95786894e9b1735cde9074d3812b04024c502d \
    --control-plane --certificate-key 4cea22cf50d89201ae4d4e351d7bebe1d0a06ca8661182adf9782e0998ff9a84

'''

Run the above command both other remaining master nodes to join the cluster.

Run the below commands, as instructed in the output of the kubeadm init

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


##Below is the joining command to join cluster as worker node


'''console


Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 10.128.0.8:6443 --token pgwl7n.nd15qpef7sizc9wz \
    --discovery-token-ca-cert-hash sha256:e261e907ea9d4c222cd3fb53bb95786894e9b1735cde9074d3812b04024c502d 

'''


##Run the above command on the worker nodes to join the cluster


##Confirm that remaining master nodes have joined the cluster

'''console
yasirms_al@kubemaster1:~$ sudo kubectl get nodes
NAME          STATUS   ROLES    AGE    VERSION
kubemaster1   Ready    master   32m    v1.15.1
kubemaster2   Ready    master   28s    v1.15.1
kubemaster3   Ready    master   116s   v1.15.1
'''

###Initiate the Work nodes and join the cluster
'''console
kubeadm join 10.128.0.8:6443 --token pgwl7n.nd15qpef7sizc9wz \
    --discovery-token-ca-cert-hash sha256:e261e907ea9d4c222cd3fb53bb95786894e9b1735cde9074d3812b04024c502d
'''

###Check the workernode has joined the cluster

'''console
yasirms_al@kubemaster1:~$ sudo kubectl get nodes
NAME          STATUS   ROLES    AGE   VERSION
kubemaster1   Ready    master   53m   v1.15.1
kubemaster2   Ready    master   21m   v1.15.1
kubemaster3   Ready    master   23m   v1.15.1
workernode1   Ready    <none>   67s   v1.15.1
workernode2   Ready    <none>   37s   v1.15.1
workernode3   Ready    <none>   17s   v1.15.1
'''










