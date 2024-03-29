resource "google_compute_instance" "app-server" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone = var.zone

  tags = ["app-server","http-server"]

  metadata = {
   #ssh-keys = "${var.user_name}:${file(var.public_key_path["${var.user_name}"])}"
   ssh-keys = "${var.user_name}:${file(var.public_key_path)}"
  }

  metadata_startup_script = ""

  boot_disk {
    initialize_params {
      image = var.disk_image
    }
  }

  network_interface {
    network = var.network
    network_ip = var.network_ip
    access_config {
    }
  }
  
}

resource "null_resource" "app-server-prov" {
 
connection {
    type = "ssh"
    user = "jenkins"
    host = "${google_compute_instance.app-server.network_interface.0.access_config.0.nat_ip}"
    private_key = "${file(var.private_key_path)}"
    agent = false   
  }

  provisioner "file" {
    source      = "./modules/app-server/scenario_app.sh"
    destination = "~/scenario_app.sh"

  }
  
  provisioner "file" {
    source      = "/var/lib/jenkins/.ssh/id_rsa"
    destination = "/tmp/id_rsa"

  }

  provisioner "file" {
    source      = "/var/lib/jenkins/.ssh/id_rsa.pub"
    destination = "/tmp/id_rsa.pub"

  }
  
  provisioner "remote-exec" {
    inline = [
      "chmod +x ~/scenario_app.sh",
      "sudo ~/scenario_app.sh "
    ]
  
  }

}




