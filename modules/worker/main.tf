# Crea el Worker con un código inicial. El código real de la API lo despliega
# el pipeline de GitHub Actions (wrangler deploy), por eso Terraform ignora
# los cambios de código y configuración que hace wrangler.
resource "cloudflare_workers_script" "this" {
  account_id          = var.account_id
  script_name         = var.worker_name
  main_module         = "index.js"
  content             = file("${path.module}/placeholder.js")
  compatibility_date  = "2024-09-23"
  compatibility_flags = ["nodejs_compat"]

  lifecycle {
    ignore_changes = [
      content,
      main_module,
      compatibility_date,
      compatibility_flags,
      bindings,
      observability,
    ]
  }
}

# Publica el Worker en <worker>.<subdominio>.workers.dev
resource "cloudflare_workers_script_subdomain" "this" {
  account_id  = var.account_id
  script_name = cloudflare_workers_script.this.script_name
  enabled     = true
}
