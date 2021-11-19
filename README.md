# aws-terraform

#### Terrafrom commands
* rm -rf .terraform*
* rem -rf terraform.tfstate*
* terraform init (initialize)
* terraform apply (deploy)
* terraform destroy
* terraform fmt
* terraform validate
* terraform show
* terraform state list
* terraform destroy
* terraform output
* terraform login

#### AWS CLI Commands
###### AWS S3 major commands
* aws s3api help
* aws s3 ls
* aws s3api create-bucket --bucket example-bucket-12345 --region us-east-1
* aws s3 cp example.txt s3://example-bucket-12345
* aws s3api delete-bucket --bucket example-bucket-12345 --region us-east-1

#### EKS
* eksctl create cluster --name ak-eks-playground --version 1.13 --nodegroup-name standard-workers --node-type t3.medium --nodes 3 --nodes-min 1 --nodes-max 4 --node-ami auto --region eu-central-1 # Create cluster
* eksctl get clusters
* eksctl delete cluster --name ak-eks-playground --region eu-west-1
* eksctl get nodegroup --cluster ak-eks-playground --region eu-central-1

#### Docker commands
* docker images
* docker build -t anuragkapur/node-docker-hello-world .
* docker rmi anuragkapur/node-web-app
* docker run 678422363581.dkr.ecr.eu-west-2.amazonaws.com/zzish-api:1.7.0
* docker run -p 8080:3000 anuragkapur/node-docker-hello-world
* docker stop [containerId]
* docker container ls
* docker system prune # Docker system cleanup
* aws ecr get-login --region eu-west-2 --no-include-email # Login and pull image from AWS ECR
* docker pull 678422363581.dkr.ecr.eu-west-2.amazonaws.com/api:v1.7.1 
* docker push anuragkapur/node-docker-hello-world # Push image to container registry
* docker cp [containerId]:/file/path/within/container /host/path/targets # Copy file from container to localhost
* docker exec -it [containerId] /bin/bash # SSH into container
* docker stats # docker container stats
* docker ps -a (docker containers)
* docker ps (docker running container)

#### Kubernates Commands
* Kubectl context and configuration
  * kubectl get pods -o wide # Get pods and node info
  * kb get nodes --show-labels --selector=kubernetes.io/lifecycle=spot # Ger pods filtered by a label
  * watch -n 1 -x kubectl get pods -n prod # Watch pod status
  * kb delete pods quizplayer-556bd5d7f8-gxczl # Delete pod
  * kubectl top pod # Get resource utilisation
  * kubectl top node # Get resource utilisation
  * kubectl describe service --all-namespaces | grep -i nodeport # View Node port
  * __View logs
    * kb logs stag-spitafields-99b8bf696-ffn76 -n stag -f
    * kb logs -l app=spitafields -n prod -f --max-log-requests=10
  * __Deployments
    * kb get deployments
    * kb get deployments -n prod
    * kb edit deployment quizalize
  * kb port-forward carmel-9d8d57f75-9qx58 -n stag 3100:3100 # Port forward into a poc
  * __Config Maps__
    * kubectl create config stag-spitafields-25apr19v1 --from-env-file=tech-stuff/workspace/zzish/kubernetes/test-environment/spitafields/spitafields.stag.env -n stag
    * kubectl get configmap stag-spitafields-24august -n stag -o yaml
    * kubectl get pods -n prod | grep Evicted | awk '{print $1}' | xargs kubectl delete pod -n prod 
  * kb exec -it stag-spitafields-6f755588dc-vrldn sh # SSH into a pod
  * kubectl get service ecsdemo-frontend -o wide # Get service info (including FQDN)
  * 
  * kubectl config view # Show Merged kubeconfig settings.
  * KUBECONFIG=~/.kube/config:~/.kube/kubconfig2 
  * __get the password for the e2e user__
  * kubectl config view -o jsonpath='{.users[?(@.name == "e2e")].user.password}'
  * kubectl config view -o jsonpath='{.users[].name}'    # display the first user
  * kubectl config view -o jsonpath='{.users[*].name}'   # get a list of users
  * kubectl config get-contexts                          # display list of contexts 
  * kubectl config current-context                       # display the current-context
  * kubectl config use-context my-cluster-name           # set the default context to my-cluster-name
* Creating objects
  * kubectl apply -f ./my-manifest.yaml            # create resource(s)
  * kubectl apply -f ./my1.yaml -f ./my2.yaml      # create from multiple files
  * kubectl apply -f ./dir                         # create resource(s) in all manifest files in dir
  * kubectl apply -f https://git.io/vPieo          # create resource(s) from url
  * kubectl create deployment nginx --image=nginx  # start a single instance of nginx
  * __create a Job which prints "Hello World__
  * kubectl create job hello --image=busybox -- echo "Hello World" 
  * __create a CronJob that prints "Hello World" every minute__
  * kubectl create cronjob hello --image=busybox   --schedule="*/1 * * * *" -- echo "Hello World"    
* Viewing, finding resources
  * kubectl explain pods                           # get the documentation for pod manifests
  * kubectl get services                          # List all services in the namespace
  * kubectl get services --sort-by=.metadata.name
  * kubectl get pods --sort-by='.status.containerStatuses[0].restartCount'
  * kubectl get pods --all-namespaces             # List all pods in all namespaces
  * kubectl get pods -o wide                      # List all pods in the current namespace, with more details
  * kubectl get deployment my-dep                 # List a particular deployment
  * kubectl get pods                              # List all pods in the namespace
  * kubectl get pod my-pod -o yaml                # Get a pod's YAML
  * kubectl describe nodes my-node
  * kubectl describe pods my-pod
  * kubectl get pv --sort-by=.spec.capacity.storage
  * kubectl get node --selector='!node-role.kubernetes.io/master'
  * kubectl get pods --field-selector=status.phase=Running # Get all running pods in the namespace
  * kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="ExternalIP")].address}'  # Get ExternalIPs of all nodes
  * kubectl get events --sort-by=.metadata.creationTimestamp # List Events sorted by timestamp
* Updating resources
  * kubectl set image deployment/frontend www=image:v2               # Rolling update "www" containers of "frontend" deployment, updating the image
  * kubectl rollout history deployment/frontend                      # Check the history of deployments including the revision 
  * kubectl rollout undo deployment/frontend                         # Rollback to the previous deployment
  * kubectl rollout undo deployment/frontend --to-revision=2         # Rollback to a specific revision
  * kubectl rollout status -w deployment/frontend                    # Watch rolling update status of "frontend" deployment until completion
  * kubectl rollout restart deployment/frontend                      # Rolling restart of the "frontend" deployment
  * cat pod.json | kubectl replace -f -                              # Replace a pod based on the JSON passed into std
  * __Force replace, delete and then re-create the resource. Will cause a service outage.
  * kubectl replace --force -f ./pod.json
  * __Create a service for a replicated nginx, which serves on port 80 and connects to the containers on port 8000
  * kubectl expose rc nginx --port=80 --target-port=8000
  * __Update a single-container pod's image version (tag) to v4
  * kubectl get pod mypod -o yaml | sed 's/\(image: myimage\):.*$/\1:v4/' | kubectl replace -f -
  * kubectl label pods my-pod new-label=awesome                      # Add a Label
  * kubectl annotate pods my-pod icon-url=http://goo.gl/XXBTWq       # Add an annotation
  * kubectl autoscale deployment foo --min=2 --max=10                # Auto scale a deployment "foo"
* Patching resources
* __Partially update a node
  * kubectl patch node k8s-node-1 -p '{"spec":{"unschedulable":true}}'
  * __Update a container's image; spec.containers[*].name is required because it's a merge key
  * kubectl patch pod valid-pod -p '{"spec":{"containers":[{"name":"kubernetes-serve-hostname","image":"new image"}]}}'
  * __Update a container's image using a json patch with positional arrays
  * kubectl patch pod valid-pod --type='json' -p='[{"op": "replace", "path": "/spec/containers/0/image", "value":"new image"}]'
  * __Disable a deployment livenessProbe using a json patch with positional arrays
  * kubectl patch deployment valid-deployment  --type json   -p='[{"op": "remove", "path": "/spec/template/spec/containers/0/livenessProbe"}]'
  * __Add a new element to a positional array
  * kubectl patch sa default --type='json' -p='[{"op": "add", "path": "/secrets/1", "value": {"name": "whatever" } }]'
* Editing resources
  * kubectl edit svc/docker-registry                      # Edit the service named docker-registry
  * KUBE_EDITOR="nano" kubectl edit svc/docker-registry   # Use an alternative editor
  * Scaling resources
  * kubectl scale --replicas=3 rs/foo                                 # Scale a replicaset named 'foo' to 3
  * kubectl scale --replicas=3 -f foo.yaml                            # Scale a resource specified in "foo.yaml" to 3
  * kubectl scale --current-replicas=2 --replicas=3 deployment/mysql  # If the deployment named mysql's current size is 2, scale mysql to 3
  * kubectl scale --replicas=5 rc/foo rc/bar rc/baz                   # Scale multiple replication controllers
* Deleting resources
  * kubectl delete -f ./pod.json                                              # Delete a pod using the type and name specified in pod.json
  * kubectl delete pod,service baz foo                                        # Delete pods and services with same names "baz" and "foo"
  * kubectl delete pods,services -l name=myLabel                              # Delete pods and services with label name=myLabel
  * kubectl -n my-ns delete pod,svc --all                                      # Delete all pods and services in namespace my-ns,
  * __Delete all pods matching the awk pattern1 or pattern2
  * kubectl get pods  -n mynamespace --no-headers=true | awk '/pattern1|pattern2/{print $1}' | xargs  kubectl delete -n mynamespace pod
* Interacting with running Pods
  * kubectl logs my-pod                                 # dump pod logs (stdout)
  * kubectl logs -l name=myLabel                        # dump pod logs, with label name=myLabel (stdout)
  * kubectl logs my-pod --previous                      # dump pod logs (stdout) for a previous instantiation of a container
  * kubectl logs my-pod -c my-container                 # dump pod container logs (stdout, multi-container case)
  * kubectl logs -l name=myLabel -c my-container        # dump pod logs, with label name=myLabel (stdout)
  * kubectl logs my-pod -c my-container --previous      # dump pod container logs (stdout, multi-container case) for a previous instantiation of a container
  * kubectl logs -f my-pod                              # stream pod logs (stdout)
  * kubectl logs -f my-pod -c my-container              # stream pod container logs (stdout, multi-container case)
  * kubectl logs -f -l name=myLabel --all-containers    # stream all pods logs with label name=myLabel (stdout)
  * kubectl run -i --tty busybox --image=busybox -- sh  # Run pod as interactive shell
  * kubectl run nginx --image=nginx -n 
  * mynamespace                                         # Run pod nginx in a specific namespace
  * kubectl run nginx --image=nginx                     # Run pod nginx and write its spec into a file called pod.yaml
  * --dry-run=client -o yaml > pod.yaml
  * kubectl attach my-pod -i                            # Attach to Running Container
  * kubectl port-forward my-pod 5000:6000               # Listen on port 5000 on the local machine and forward to port 6000 on my-pod
  * kubectl exec my-pod -- ls /                         # Run command in existing pod (1 container case)
  * kubectl exec --stdin --tty my-pod -- /bin/sh        # Interactive shell access to a running pod (1 container case) 
  * kubectl exec my-pod -c my-container -- ls /         # Run command in existing pod (multi-container case)
  * kubectl top pod POD_NAME --containers               # Show metrics for a given pod and its containers
  * kub* * ectl top pod POD_NAME --sort-by=cpu              # Show metrics for a given pod and sort it by 'cpu' or 'memory'
* Interacting with Deployments and Services
  * kubectl logs deploy/my-deployment                         # dump Pod logs for a Deployment (single-container case)
  * kubectl logs deploy/my-deployment -c my-container         # dump Pod logs for a Deployment (multi-container case)
  * kubectl port-forward svc/my-service 5000                  # listen on local port 5000 and forward to port 5000 on Service backend
  * kubectl port-forward svc/my-service 5000:my-service-port  # listen on local port 5000 and forward to Service target port with name <my-service-port*
  * kubectl port-forward deploy/my-deployment 5000:6000       # listen on local port 5000 and forward to port 6000 on a Pod created by <my-deployment>
  * kubectl exec deploy/my-deployment -- ls                   # run command in first Pod and first container in Deployment (single- or multi-container cases)
* Interacting with Nodes and cluster
  * kubectl cordon my-node                                                # Mark my-node as unschedulable
  * kubectl drain my-node                                                 # Drain my-node in preparation for maintenance
  * kubectl uncordon my-node                                              # Mark my-node as schedulable
  * kubectl top node my-node                                              # Show metrics for a given node
  * kubectl cluster-info                                                  # Display addresses of the master and services
  * ubectl cluster-info dump                                             # Dump current cluster state to stdout
  * kubectl cluster-info dump --output-directory=/path/to/cluster-state   # Dump current cluster state to /path/to/cluster-state
  * __ If a taint with that key and effect already exists, its value is replaced as specified.
  * kubectl taint nodes foo dedicated=special-user:NoSchedule
* Resource types
  * kubectl api-resources --namespaced=true      # All namespaced resources
  * kubectl api-resources --namespaced=false     # All non-namespaced resources
  * kubectl api-resources -o name                # All resources with simple output (only the resource name)
  * kubectl api-resources -o wide                # All resources with expanded (aka "wide") output
  * kubectl api-resources --verbs=list,get       # All resources that support the "list" and "get" request verbs
  * kubectl api-resources --api-group=extensions # All resources in the "extensions" API group

