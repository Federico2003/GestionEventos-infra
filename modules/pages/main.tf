# Proyecto de Pages para despliegue directo (wrangler pages deploy desde GitHub Actions)
resource "cloudflare_pages_project" "this" {
  account_id        = var.account_id
  name              = var.project_name
  production_branch = "main"
}
