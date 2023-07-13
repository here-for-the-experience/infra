output "user_db_instance_address" {
  description = "USERDB The address of the RDS instance"
  value       = try(aws_db_instance.userdb.address, null)
}

output "user_db_instance_endpoint" {
  description = "USERDB The connection endpoint"
  value       = try(aws_db_instance.userdb.endpoint, null)
}

output "user_db_listener_endpoint" {
  description = "USERDB Specifies the listener connection endpoint for SQL Server Always On"
  value       = try(aws_db_instance.userdb.listener_endpoint, null)
}

output "user_db_instance_identifier" {
  description = "USERDB The RDS instance identifier"
  value       = try(aws_db_instance.userdb.identifier, null)
}

output "user_db_instance_status" {
  description = "USERDB The RDS instance status"
  value       = try(aws_db_instance.userdb.status, null)
}


output "user_db_instance_username" {
  description = "USERDB The master username for the database"
  value       = try(aws_db_instance.userdb.username, null)
  sensitive   = true
}

output "user_db_instance_port" {
  description = "USERDB The database port"
  value       = try(aws_db_instance.userdb.port, null)
}

output "user_db_instance_domain" {
  description = "USERDB The ID of the Directory Service Active Directory domain the instance is joined to"
  value       = try(aws_db_instance.userdb.domain, null)
}


# ---------

output "vaccine_db_instance_address" {
  description = "VACCINEDB The address of the RDS instance"
  value       = try(aws_db_instance.vaccinedb.address, null)
}

output "vaccine_db_instance_endpoint" {
  description = "VACCINEDB The connection endpoint"
  value       = try(aws_db_instance.vaccinedb.endpoint, null)
}

output "vaccine_db_listener_endpoint" {
  description = "VACCINEDB Specifies the listener connection endpoint for SQL Server Always On"
  value       = try(aws_db_instance.vaccinedb.listener_endpoint, null)
}

output "vaccine_db_instance_identifier" {
  description = "VACCINEDB The RDS instance identifier"
  value       = try(aws_db_instance.vaccinedb.identifier, null)
}

output "vaccine_db_instance_status" {
  description = "VACCINEDB The RDS instance status"
  value       = try(aws_db_instance.vaccinedb.status, null)
}


output "vaccine_db_instance_username" {
  description = "VACCINEDB The master username for the database"
  value       = try(aws_db_instance.vaccinedb.username, null)
  sensitive   = true
}

output "vaccine_db_instance_port" {
  description = "VACCINEDB The database port"
  value       = try(aws_db_instance.vaccinedb.port, null)
}

output "vaccine_db_instance_domain" {
  description = "VACCINEDB The ID of the Directory Service Active Directory domain the instance is joined to"
  value       = try(aws_db_instance.vaccinedb.domain, null)
}
