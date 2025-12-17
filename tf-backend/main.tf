terraform {
  backend "pg" {}

  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.53.0"
    }
  }
}
provider "openstack" {
  auth_url  = var.os_auth_url
  token     = var.os_token
  tenant_id = var.os_tenant_id
  region    = "RegionOne"

  endpoint_overrides = {
    network  = "https://neutron.recas.ba.infn.it/v2.0/"
    volumev3 = "https://cinder.recas.ba.infn.it/v3/"
    image    = "https://glance.recas.ba.infn.it/v2/"
  }
}

### Comment this is a test ###
resource "openstack_compute_keypair_v2" "state_test" {
  name       = "tf-backend-state-test"
  public_key = "test key"
}
##############################
