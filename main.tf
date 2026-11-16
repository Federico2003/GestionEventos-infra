# Planora — Infraestructura en Cloudflare para los ambientes Dev y Prod.
# Los nombres coinciden con lo que usan los pipelines de GitHub Actions:
#   Worker  planora-api-dev / planora-api-prod   (packages/api/wrangler.toml)
#   Pages   planora-web-dev / planora-web        (variable CF_PAGES_PROJECT)

locals {
  pages_names = {
    dev  = "${var.project_name}-web-dev"
    prod = "${var.project_name}-web"
  }
}

module "d1" {
  source   = "./modules/d1"
  for_each = var.environments

  account_id    = var.account_id
  database_name = "${var.project_name}-d1-${each.key}"
}

module "worker" {
  source   = "./modules/worker"
  for_each = var.environments

  account_id  = var.account_id
  worker_name = "${var.project_name}-api-${each.key}"
}

module "pages" {
  source   = "./modules/pages"
  for_each = var.environments

  account_id   = var.account_id
  project_name = local.pages_names[each.key]
}
