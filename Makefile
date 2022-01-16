
.PHONY: create-cluster
create-cluster: 
	kind create cluster --name kafka

.PHONY: create-cluster
delete-cluster: 
	kind delete cluster --name kafka

.PHONY: kpt-init
kpt-init: 
	kpt pkg init deployments/kubernetes/base --tag kpt.dev/app=kafka --description "kafka playground"

.PHONY: live-init
live-init:
	kpt live init --namespace=kafka deployments/kubernetes/overlays/local

.PHONY: dif
diff:
	kustomize build deployments/kubernetes/overlays/local  | kpt live diff

.PHONY: deploy-local
deploy-local:
	kustomize build deployments/kubernetes/overlays/local | kpt live apply 
