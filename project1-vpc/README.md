# Project 1: Automated Multi-Region VPC & Network Hardening

## 🎯 Objective
To design and deploy a secure, production-ready multi-region Google Cloud network architecture using Infrastructure as Code (IaC), eliminating public exposure of compute assets while maintaining controlled internet egress and secure remote management.
I decided on a hybridized approach to each of my projects. To reinforce learning, I utilized a "ClicOps" initial
configuration of all of the resources to pict
## 📐 Architecture & Infrastructure
* **Cloud Platform:** Google Cloud Platform (GCP)
* **Automation Tool:** Terraform (HashiCorp)
* **Network Components:** Custom VPC, Subnets across `us-central1` and `us-east4`, Cloud Router, and Cloud NAT.
* **Compute:** Private Compute Engine instance (no external IP address assigned).

## 🔒 Security Hardening Decisions & Implementation
1. **Zero Public Exposure (No External IPs):** 
   * *Why:* Public IP addresses on cloud instances are a primary target for external scanning, enumeration, and brute-force attacks.
   * *How:* Configured the Terraform resource without public access blocks, ensuring the compute instance lives entirely behind private RFC 1918 IP space.
2. **Secure Management via Identity-Aware Proxy (IAP):** 
   * *Why:* Traditional remote access requires opening port 22 to the world or maintaining a complex, vulnerable bastion host. 
   * *How:* Leveraged GCP's IAP tunneling, restricting SSH access so that connections must originate through Google's authenticated proxy rather than an open firewall rule.
3. **Controlled Outbound Traffic (Cloud NAT):** 
   * *Why:* Private virtual machines still need to pull OS updates, patches, and packages from the internet without exposing themselves to *inbound* malicious traffic.
   * *How:* Deployed a Cloud NAT gateway attached to a Cloud Router, giving the private subnets controlled, masked egress to the internet.


**Building Your Secure Cloud House: A Step-by-Step Guide**

Imagine you are building a secure house on a massive digital plot of land (Google Cloud Platform). Instead of building it manually with your bare hands, you write a blueprint using a smart robot helper called **Terraform**. This robot reads your instructions and automatically sets up the walls, rooms, and security gates for you.

---

**1. The Digital Neighborhood (Custom VPC & Subnets)**

* **What it is:** A Virtual Private Cloud (VPC) is your own private neighborhood in the cloud. Inside this neighborhood, you carve out specific sections called subnets located in different regions (`us-central1` and `us-east4`).
* **Why we do it:** Think of a VPC like a gated community. It keeps your digital resources completely isolated from everyone else on the internet. Creating subnets in different regions ensures your project is spread out safely and can handle heavy traffic.

**2. The Invisible Computer (Private Compute Engine Instance)**

* **What it is:** A virtual server (computer) that handles your code or apps, but with a major catch: it does not have a public internet address.
* **Why we do it (Zero Public Exposure):** Computers directly exposed to the public internet are like a house with the front door left wide open. Hackers constantly scan the internet looking for these open doors to break in. By keeping this computer entirely private (using hidden IP addresses), hackers cannot see it or reach it from the outside world.

**3. The Guarded Front Gate (Secure Management via Identity-Aware Proxy)**

* **What it is:** A secure tunnel that lets you safely log into your private computer to fix things or check its status.
* **Why we do it:** Normally, to talk to a remote computer, you have to leave a door open (Port 22) or build a complicated guard tower (a bastion host). Instead, we use Google’s Identity-Aware Proxy (IAP). This acts like a strict security guard at a gated entrance who checks your ID, verifies who you are, and only lets you through a secure, encrypted tunnel. No open internet doors required.

**4. The One-Way Street for Updates (Cloud Router & Cloud NAT)**

* **What it is:** A system that lets your private computer safely reach out to the internet to download software updates, patches, and tools without letting anything back in.
* **Why we do it:** Even though our computer is hiding for safety, it still needs to check for important updates from the outside world. A Cloud NAT acts like a one-way mirror. Your computer can peek outside and grab what it needs, but anyone standing outside cannot see or reach inside.
## 🚀 How to Deploy
1. Clone this repository.
2. Initialize Terraform in the project directory:
   ```bash
   terraform init

   Review the execution:
   terraform plan

   Apply the configuration:
   terraform apply

<img width="1440" height="900" alt="Automated VPC Subnet" src="https://github.com/user-attachments/assets/46bc954e-eeed-4162-ae23-f6022070be3d" />
<img width="1440" height="900" alt="VPC fw rule" src="https://github.com/user-attachments/assets/ee79d36c-4253-4b1c-b808-e2094a368d30" />
<img width="1440" height="900" alt="VPC VM instance" src="https://github.com/user-attachments/assets/34b33a5d-16eb-49e5-aca1-6aaf967f9cbf" />
<img width="1440" height="900" alt="VPC SSH Browser" src="https://github.com/user-attachments/assets/e7f5dc7d-8bb2-4dd2-a11b-86b993d525b7" />
