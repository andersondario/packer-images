locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "googlecompute" "prometheus-image" {
  source_image_family = "centos-7"
  image_name          = "packer-prometheus-${local.timestamp}"
  image_description   = "Prometheus Web Server"
  ssh_username        = "packer"
  tags                = ["packer"]
}

build {
  sources = ["sources.googlecompute.prometheus-image"]

  hcp_packer_registry {
    bucket_name = "packer-prometheus-images"
    description = "Bucket used to store Prometheus images."
  }

  provisioner "ansible" {
    playbook_file = "./playbook.yml"
    use_proxy     = false
  }
}