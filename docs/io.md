# Inputs and Outputs: terraform-digitalocean-vpc

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| `name` | Name (e.g. `app` or `cluster`). | `string` | `""` | no |
| `environment` | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| `label_order` | Label order, e.g. `name`. | `list(any)` | `["name", "environment"]` | no |
| `managedby` | ManagedBy, eg `terraform-do-modules` or `hello@clouddrove.com`. | `string` | `"terraform-do-modules"` | no |
| `enabled` | A boolean flag to enable/disable vpc. | `bool` | `true` | no |
| `region` | The region to create VPC, like `blr1`. | `string` | `"blr1"` | no |
| `description` | A free-form text field up to a limit of 255 characters to describe the VPC. | `string` | `"VPC"` | no |
| `ip_range` | The range of IP addresses for the VPC in CIDR notation. Network ranges cannot overlap with other networks in the same account and must be in range of private addresses as defined in RFC1918. It may not be larger than /16 or smaller than /24. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| `id` | The unique identifier for the VPC. |
| `urn` | The uniform resource name (URN) for the VPC. |
| `default` | A boolean indicating whether or not the VPC is the default one for the region. |
| `created_at` | The date and time of when the VPC was created. |
