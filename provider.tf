terraform {
  required_providers {
    prismacloud = {
      source  = "PaloAltoNetworks/prismacloud"
      version = "1.5.5"
    }
  }
}

provider "prismacloud" {
  # Configuration options
  json_config_file = "credentials.json"
}
