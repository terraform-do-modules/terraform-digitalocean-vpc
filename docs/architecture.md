# Architecture: terraform-digitalocean-vpc

## Overview

A Virtual Private Cloud (VPC) is the network foundation for all DigitalOcean resources. It provides a logically isolated network environment in which droplets, Kubernetes clusters, databases, and load balancers communicate using private IP addresses, without traversing the public internet. This module manages a single `digitalocean_vpc` resource and applies consistent naming via the shared labels module.

## VPC as Network Foundation

Every workload in DigitalOcean that requires private networking must be placed inside a VPC. The VPC is created first and its `id` output is passed as `vpc_uuid` to downstream modules. This dependency chain ensures resources are always colocated on the same private network fabric.

Typical dependency order:

1. VPC (this module)
2. Droplet / Kubernetes / Database modules (consume `vpc.id`)
3. Load Balancer module (attached to the VPC-resident resources)

## CIDR Planning (RFC 1918)

DigitalOcean VPCs accept any CIDR block that satisfies all of the following:

- Falls within RFC 1918 private address space: `10.0.0.0/8`, `172.16.0.0/12`, or `192.168.0.0/16`
- Is no larger than `/16` (65 536 addresses)
- Is no smaller than `/24` (256 addresses)

Recommended sizing guidance:

| Use case           | CIDR example      | Usable hosts |
|--------------------|-------------------|--------------|
| Small environment  | 10.x.x.0/24       | 254          |
| Medium environment | 10.x.0.0/22       | 1 022        |
| Large environment  | 10.x.0.0/16       | 65 534       |

Choose non-overlapping ranges across all VPCs in the same account and across any remote networks that may be peered or connected via VPN in the future.

## Regional Scope

A DigitalOcean VPC is scoped to a single region (e.g., `blr1`, `nyc3`, `fra1`, `sgp1`). All resources attached to a VPC must reside in the same region. Cross-region private connectivity is not natively supported; inter-region traffic must traverse the public internet or a private VPN endpoint.

This module exposes the `region` variable (default `blr1`) so that the VPC region matches the region used by downstream modules.

## Integration with Other Modules

| Consumer module                  | Input variable  | Source output   |
|----------------------------------|-----------------|-----------------|
| terraform-digitalocean-droplet   | `vpc_uuid`      | `module.vpc.id` |
| terraform-digitalocean-kubernetes| `vpc_uuid`      | `module.vpc.id` |
| terraform-digitalocean-database  | `vpc_uuid`      | `module.vpc.id` |
| terraform-digitalocean-lb        | `vpc_uuid`      | `module.vpc.id` |

Example wiring:

```hcl
module "vpc" {
  source      = "terraform-do-modules/vpc/digitalocean"
  version     = "1.0.0"
  name        = "app"
  environment = "prod"
  region      = "blr1"
  ip_range    = "10.10.0.0/16"
}

module "cluster" {
  source   = "terraform-do-modules/kubernetes/digitalocean"
  version  = "1.0.0"
  vpc_uuid = module.vpc.id
  # ...
}
```

## Operational Checklist

- Do not use overlapping CIDR ranges across VPCs in the same account or with on-premises networks.
- DigitalOcean does not support native VPC peering; plan CIDR ranges as if each VPC is a standalone island.
- Each account has a default VPC per region; avoid using it for workloads — the `default` output identifies whether the VPC is the region default.
- Pin the module version in production to prevent unintended VPC replacement on version upgrades.
- VPC deletion is blocked if resources are still attached; decommission all droplets, clusters, and databases first.
- Set `enabled = false` to skip resource creation without removing the module call from the configuration.
- Record the VPC `id` and `urn` outputs in remote state so they are referenceable by other root modules without hard-coding.
