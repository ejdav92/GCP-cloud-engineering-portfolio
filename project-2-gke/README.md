# Project 2: Highly Available Web Application on [GKE](https://cloud.google.com/kubernetes-engine)

## Beginner's Perspective & The Hybrid Approach

Coming into cloud engineering with a foundational background in rigorous scientific analysis (Biology and Chemistry) and high-performance execution (Classical Music), combined with my newly earned Google Cloud Cybersecurity Professional Certificate, my approach to infrastructure is heavily rooted in structure and risk management.

Instead of jumping straight into black-box automation, I adopted a **hybrid learning model**: I manually built and deployed this architecture line-by-line in the Google Cloud Console first. By provisioning the APIs, spinning up clusters, and writing deployment manifests by hand, I built a concrete mental model of how control planes and node planes interact. Now, when I dive into deeper container and Kubernetes labs, I am not memorizing abstract theory—I am hunting for the exact mechanics behind the operational behavior I experienced live.

## Architectural Blueprint & Core Components

* **[Artifact Registry](https://console.cloud.google.com/artifacts):** Established a private Docker repository (`app-repo`) in `us-central1` to store container images securely.
* **[Google Kubernetes Engine (GKE Autopilot)](https://cloud.google.com/kubernetes-engine):** Deployed a fully managed, auto-scaling Kubernetes cluster (`demo-cluster`) that abstracts away underlying node patch management while maintaining high availability.
* **Declarative Workload Layer:** Authored a custom `deployment.yaml` manifest enforcing multi-replica redundancy (`replicas: 2`) running standard Nginx containers.
* **Network Ingress:** Provisioned a Kubernetes `LoadBalancer` service to securely bridge public internet traffic to internal cluster pods.

## Security Considerations for a New Engineer

* **Supply Chain Integrity:** Storing and pulling images from a private [Artifact Registry](https://console.cloud.google.com/artifacts) rather than public registries mitigates supply chain risks. In production, this acts as a vital choke point for vulnerability scanning (CVEs) before workloads reach live clusters.
* **Minimizing Infrastructure Liability:** Utilizing GKE Autopilot offloads low-level OS patching and server-hardening burdens from a junior engineer, allowing focus to remain strictly on secure workload configuration and resource limit boundaries.
* **Eliminating Configuration Drift:** Managing infrastructure through immutable declarative YAML files ensures consistent, auditable deployments across environments, preventing manual "hotfixes" that leave dangerous unrecorded modifications.

## Steps to Reproduce

1. Enable container and registry APIs via Cloud Shell:
```bash
gcloud services enable container.googleapis.com artifactregistry.googleapis.com

```


2. Create the private Docker repository in [Artifact Registry](https://console.cloud.google.com/artifacts).
3. Spin up the GKE Autopilot cluster:
```bash
gcloud container clusters create-auto demo-cluster --region=us-central1

```<img width="985" height="777" alt="project 2 kubernetes cluster spinning" src="https://github.com/user-attachments/assets/ad2405ae-67e9-42bf-947b-51ca6f23fa84" />
<img width="1322" height="777" alt="nginx project 2" src="https://github.com/user-attachments/assets/312aad13-2b48-4546-b344-8362213e5c0b" />
<img width="981" height="655" alt="project 2 artifact registry" src="https://github.com/user-attachments/assets/8aca657c-860f-4552-9be1-424349622400" />
<img width="981" height="655" alt="project 2 ip addresses" src="https://github.com/user-attachments/assets/374eb8a9-fc1a-4fbb-a12d-2e2cf0b38846" />



4. Apply the application manifest:
```bash
kubectl apply -f deployment.yaml

```


5. Retrieve the external load balancer IP and verify access:
```bash
kubectl get service web-service

```
<img width="1408" height="768" alt="watermarked_img_9972470842278155191" src="https://github.com/user-attachments/assets/d1780879-929b-4c6e-85b0-325e0f198604" />
<img width="985" height="777" alt="project 2 kubernetes cluster spinning" src="https://github.com/user-attachments/assets/6bb4d106-d3eb-49c0-84d4-641115060835" />
<img width="1322" height="777" alt="nginx project 2" src="https://github.com/user-attachments/assets/32a7747c-a189-40c4-897b-f1b7482994af" />
<img width="981" height="655" alt="project 2 artifact registry" src="https://github.com/user-attachments/assets/e84a10b6-b3be-4e25-bb32-650889758fec" />
<img width="981" height="655" alt="project 2 ip addresses" src="https://github.com/user-attachments/assets/25200b1a-5a39-44e3-bf5c-133b4dd4334d" />
