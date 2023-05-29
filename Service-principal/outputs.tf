output "service_principal_name" {
  description = "service principal name."
  value       = azuread_service_principal.main.display_name
}


output "client_id" {
description = "The application ID of AzureAD application created"
value = azuread_application.main.application_id
}

output "client_secret" {
description = "Password for service principal"
value = azuread_service_principal_password.main.value
sensitive = true
}


output "service_principal_object_id" {
  description = "The object id of service principal. Can be used to assign roles to user."
  value       = azuread_service_principal.main.object_id
}