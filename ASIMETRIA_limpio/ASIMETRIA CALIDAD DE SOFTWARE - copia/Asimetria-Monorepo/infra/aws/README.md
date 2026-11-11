# AWS (us-east-2)

Esta configuración crea una VPC pública, un grupo de seguridad, un par de claves SSH, una instancia EC2 Ubuntu 24.04 y una Elastic IP. No despliega la aplicación ni administra DuckDNS: apunta el registro A de DuckDNS a la IP que Terraform muestra.

## Requisitos

- Terraform 1.5 o posterior.
- Credenciales AWS configuradas localmente (por ejemplo, con `aws configure`).
- Una clave SSH pública y la IP pública desde la que te conectarás.

## Uso

Desde esta carpeta:

```powershell
Copy-Item terraform.tfvars.example terraform.tfvars
```

Edita `terraform.tfvars`: reemplaza `admin_cidr` por tu IP pública con sufijo `/32` y `ssh_public_key` por el contenido de tu clave pública OpenSSH. No pegues ni guardes la clave privada en Terraform.

```powershell
terraform init
terraform validate
terraform plan -out=plan.tfplan
```

Revisa el plan antes de ejecutar `terraform apply plan.tfplan`. `init`, `validate` y `plan` no crean recursos; `apply` sí puede generar cargos.

El tipo predeterminado `t3.medium` (2 vCPU y 4 GiB) sigue el mínimo indicado para la aplicación. AWS factura la instancia, el volumen EBS y la IPv4 pública; verifica los precios y tus créditos en la consola antes de aplicar. La Elastic IP mantiene estable la dirección, pero tiene costo.

Después de aplicar:

1. Apunta `asimetria.duckdns.org` (o el hostname que configuraste) a la salida `public_ip` usando DuckDNS. No se crea una zona Route 53: DuckDNS no es una zona administrada por tu cuenta de AWS.
2. Conéctate usando `ssh_command` y sigue [las instrucciones de despliegue](../../docs/DESPLIEGUE.md) para preparar el servidor, configurar los secretos y desplegar la aplicación.

El volumen raíz está cifrado y se elimina al destruir la instancia. Conserva los backups de la base de datos fuera del servidor.
