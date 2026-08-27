terraform {
  required_version = ">= 1.5.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region_primary
}

# 1. Custom VPC Network
resource "google_compute_network" "custom_vpc" {
  name                    = "prod-network-vpc"
  auto_create_subnetworks = false
}

# 2. Subnet 1: Primary Region
resource "google_compute_subnetwork" "subnet_primary" {
  name                     = "prod-sub-us-central1"
  ip_cidr_range            = "10.10.10.0/24"
  region                   = var.region_primary
  network                  = google_compute_network.custom_vpc.id
  private_ip_google_access = true
}

# 3. Subnet 2: Secondary Region
resource "google_compute_subnetwork" "subnet_secondary" {
  name                     = "prod-sub-us-east4"
  ip_cidr_range            = "10.20.10.0/24"
  region                   = var.region_secondary
  network                  = google_compute_network.custom_vpc.id
  private_ip_google_access = true
}

# 4. Cloud Router & NAT Gateway
resource "google_compute_router" "nat_router" {
  name    = "prod-nat-router"
  region  = var.region_primary
  network = google_compute_network.custom_vpc.id
}

resource "google_compute_router_nat" "nat_gateway" {
  name                               = "prod-nat-gateway"
  router                             = google_compute_router.nat_router.name
  region                             = var.region_primary
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

# 5. Firewall: Allow SSH through Identity-Aware Proxy (IAP)
resource "google_compute_firewall" "allow_iap_ssh" {
  name    = "fw-allow-iap-ssh"
  network = google_compute_network.custom_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["35.235.240.0/20"]
}

# 6. Compute Instance without Public IP
resource "google_compute_instance" "private_vm" {
  name         = "prod-private-vm-01"
  machine_type = "e2-micro"
  zone         = "${var.region_primary}-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    network    = google_compute_network.custom_vpc.id
    subnetwork = google_compute_subnetwork.subnet_primary.id
  }
}
