provider "google" {
 credentials = "${file("/c:/profili/U386586/Documents/Corsi/terraform/SNY.OSS.TRF.01.01.00/SNY-OSS-TRF-01-01-00-870577b1e676.json")}"
 project     = "sny-oss-trf-01-01-00"
 region      = "us-west1-a"
}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 8
}

// A single Google Cloud Engine instance
resource "google_compute_instance" "default" {
 name         = "fabio-vm-${random_id.instance_id.hex}"
 machine_type = "f1-micro"
 zone         = "us-west1-a"

 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-9"
   }
 }

 network_interface {
   network = "default"

   access_config {
     // Include this section to give the VM an external ip address
   }
 }
 metadata = {
   ssh-keys = "paper:${file("~/.ssh/id_rsa.pub")}"
 }
}

