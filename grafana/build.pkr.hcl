locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

build {
  sources = ["sources.googlecompute.grafana-image"]

  hcp_packer_registry {
    bucket_name = "packer-grafana-images"
    description = "Bucket used to store Grafana images."
  }

  provisioner "ansible" {
    playbook_file = "./playbook.yml"
    use_proxy     = false
  }
}


source "googlecompute" "grafana-image" {
  project_id          = var.project_id
  zone                = var.zone
  source_image_family = "centos-7"
  image_name          = "packer-grafana-${local.timestamp}"
  image_description   = "Grafana Web Server"
  ssh_username        = "packer"
  tags                = ["packer"]
}