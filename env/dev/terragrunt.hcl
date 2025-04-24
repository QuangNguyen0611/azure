include {
  path = find_in_parent_folders()
}

remote_state {
  backend = "azurerm"
  config = {
    use_msi              = true
    use_azuread_auth     = true
    tenant_id            = "609cadc8-fcdd-4a29-916e-d6a79ef5b6a2"
    client_id            = "435e49e5-bc3d-4998-86d8-d12584eec87b"
    storage_account_name = "satfstatedev01"
    container_name       = "tfstate"
    key                  = "dev.terraform.tfstate"
  }
}

inputs = {
  subscription_id = "1aa30304-f3cf-446b-848a-f0c77bf1d964"
  resource_group_name = "app-grp-dev"
  location = "Southeast Asia"
  tags = {
    Environment = "Development"
  }
}