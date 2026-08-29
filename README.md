Project 2: Highly Available Web Application on GKE
Beginner's Perspective & The Hybrid Approach
Coming into cloud engineering with a foundational background in rigorous scientific analysis (Biology and Chemistry) and high-performance execution (Classical Music), combined with my newly earned Google Cloud Cybersecurity Professional Certificate, my approach to infrastructure is heavily rooted in structure and risk management.

Instead of jumping straight into black-box automation, I adopted a hybrid learning model: I manually built and deployed this architecture line-by-line in the Google Cloud Console first. By provisioning the APIs, spinning up clusters, and writing deployment manifests by hand, I built a concrete mental model of how control planes and node planes interact. Now, when I dive into deeper container and Kubernetes labs, I am not memorizing abstract theory—I am hunting for the exact mechanics behind the operational behavior I experienced live.

Architectural Blueprint & Core Components
Artifact Registry: Established a private Docker repository (app-repo) in us-central1 to store container images securely.


Google Kubernetes Engine (GKE Autopilot): Deployed a fully managed, auto-scaling Kubernetes cluster (demo-cluster) that abstracts away underlying node patch management while maintaining high availability.


Declarative Workload Layer: Authored a custom deployment.yaml manifest enforcing multi-replica redundancy (replicas: 2) running standard Nginx containers.


Network Ingress: Provisioned a Kubernetes LoadBalancer service to securely bridge public internet traffic to internal cluster pods.


Security Considerations for a New Engineer
Supply Chain Integrity: Storing and pulling images from a private Artifact Registry rather than public registries mitigates supply chain risks. In production, this acts as a vital choke point for vulnerability scanning (CVEs) before workloads reach live clusters.


Minimizing Infrastructure Liability: Utilizing GKE Autopilot offloads low-level OS patching and server-hardening burdens from a junior engineer, allowing focus to remain strictly on secure workload configuration and resource limit boundaries.


Eliminating Configuration Drift: Managing infrastructure through immutable declarative YAML files ensures consistent, auditable deployments across environments, preventing manual "hotfixes" that leave dangerous unrecorded modifications.


Steps to Reproduce
Enable container and registry APIs via Cloud Shell:

Bash
gcloud services enable container.googleapis.com artifactregistry.googleapis.com




Create the private Docker repository in Artifact Registry.

Spin up the GKE Autopilot cluster:

Bash
gcloud container clusters create-auto demo-cluster --region=us-central1




Apply the application manifest:

Bash
kubectl apply -f deployment.yaml




Retrieve the external load balancer IP and verify access:

Bash
kubectl get service web-service
