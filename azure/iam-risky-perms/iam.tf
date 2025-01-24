

# Test with non-risky permissions - Pass
resource "azurerm_role_definition" "example" {
  name        = "my-custom-role"
  scope       = data.azurerm_subscription.primary.id
  description = "This is a custom role created via Terraform"

  permissions {
    actions = [
      "Microsoft.Network/applicationGateways/read"
    ]
    not_actions = []
  }

  assignable_scopes = [
    "/"
  ]
}

# Test with risky permissions - Fail
resource "azurerm_role_definition" "example-fail" {
  name        = "my-custom-role"
  scope       = data.azurerm_subscription.primary.id
  description = "This is a custom role created via Terraform"

  permissions {
    actions = [
      "Microsoft.Authorization/elevateAccess/action",
      "Microsoft.Authorization/roleManagementPolicies/write" 
    ]
    not_actions = []
  }

  assignable_scopes = [
    "/"
  ]
}

# Test with risky permissions - Fail 2
resource "azurerm_role_definition" "example-fail2" {
  name        = "my-custom-role"
  scope       = data.azurerm_subscription.primary.id
  description = "This is a custom role created via Terraform"

  permissions {
    actions = [
      "Microsoft.Authorization/elevateAccess/action"
    ]
    not_actions = []
  }

  assignable_scopes = [
    "/"
  ]
}