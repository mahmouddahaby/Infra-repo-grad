####################### VM instance ##########################

resource "google_compute_instance" "instance" {
  name = "private-vm"
  machine_type = "f1-micro"
  zone         = "asia-east1-a"


  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts"
    }
  }
  tags = ["ssh"]
  service_account {
    email = var.email
    scopes = [ var.url ]
  }
    network_interface {
      subnetwork = var.manged-subnet
    }

  metadata_startup_script = var.script 

}


########################## VM firewall ##############################


resource "google_compute_firewall" "allow-all" {
  project = var.project
  name    = "allow-all"
  network = var.vpc
  direction = "INGRESS"
  priority = 100
  
  allow {
    protocol = "all"
  }
  target_tags = ["ssh"]
  source_ranges = ["0.0.0.0/0"]
}