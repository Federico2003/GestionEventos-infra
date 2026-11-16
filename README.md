# GestionEventos-infra — Infraestructura de Planora con Terraform

Repositorio de infraestructura como código (IaC) del proyecto **Planora**. Crea en Cloudflare los recursos de los ambientes **Dev** y **Prod** que después usan los pipelines de GitHub Actions del repo `GestionEventos`.

## Recursos (8)

| Módulo | Recurso | Dev | Prod |
|---|---|---|---|
| `modules/d1` | Base de datos D1 | `planora-d1-dev` | `planora-d1-prod` |
| `modules/worker` | Worker del backend + subdominio workers.dev | `planora-api-dev` | `planora-api-prod` |
| `modules/pages` | Proyecto de Cloudflare Pages del frontend | `planora-web-dev` | `planora-web` |

El código real de la API y del frontend lo despliega GitHub Actions con `wrangler`. Terraform solo crea los recursos, por eso el módulo `worker` ignora los cambios de código que hace el pipeline.

## Estructura

```
versions.tf      provider cloudflare ~> 5.0
variables.tf     account_id, api_token, project_name, environments
main.tf          llama a los módulos d1, worker y pages para cada ambiente
output.tf        nombres de Workers, IDs de D1 y URLs de Pages
modules/
  d1/      main.tf  output.tf  variables.tf  versions.tf
  worker/  main.tf  output.tf  variables.tf  versions.tf  placeholder.js
  pages/   main.tf  output.tf  variables.tf  versions.tf
```

## Uso

1. Crea un API token en Cloudflare con permisos de cuenta **Workers Scripts: Edit**, **D1: Edit** y **Cloudflare Pages: Edit**.
2. Copia `terraform.tfvars.example` como `terraform.tfvars` y llena `account_id` y `api_token` (este archivo está en `.gitignore`).
3. Ejecuta:

```powershell
terraform init
terraform plan -out=tfplan     # Plan: 8 to add
terraform apply tfplan
```

4. Con los valores de `output` llena en GitHub las variables `FRONTEND_URL` (Pages) y `CF_PAGES_PROJECT` de los Environments `dev` y `production`.

Para eliminar todo: `terraform destroy`.
