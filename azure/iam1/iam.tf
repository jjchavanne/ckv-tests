
# Test with granular permissions - Pass
resource "azurerm_role_definition" "example" {
  name        = "my-custom-role"
  scope       = data.azurerm_subscription.primary.id
  description = "This is a custom role created via Terraform"

  permissions {
    actions = [
      "Microsoft.Network/applicationGateways/read",
      "Microsoft.Network/applicationGateways/write" 
    ]
    not_actions = []
  }

  assignable_scopes = [
    "/"
  ]
}

# Test with broad wildcard permissions - Fail
resource "azurerm_role_definition" "example" {
  name        = "my-custom-role"
  scope       = data.azurerm_subscription.primary.id
  description = "This is a custom role created via Terraform"

  permissions {
    actions = [
      "*", 
      "Microsoft.Network/applicationGateways/read",
      "Microsoft.Network/applicationGateways/write" 
    ]
    not_actions = []
  }

  assignable_scopes = [
    "/"
  ]
}