output "workers" {
  description = "Nombre de cada Worker del backend"
  value       = { for env, w in module.worker : env => w.worker_name }
}

output "d1_databases" {
  description = "ID de cada base de datos D1"
  value       = { for env, d in module.d1 : env => d.database_id }
}

output "pages_urls" {
  description = "URL de cada proyecto de Cloudflare Pages (variable FRONTEND_URL)"
  value       = { for env, p in module.pages : env => p.url }
}
