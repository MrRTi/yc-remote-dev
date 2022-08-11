# Terraform config for remote dev environment at Yandex Cloud

## Before you start

- [Info](https://cloud.yandex.com/en-ru/docs/solutions/infrastructure-management/terraform-quickstart#before-you-begin)
- [OAuth Token](https://cloud.yandex.com/en-ru/docs/iam/concepts/authorization/oauth-token)
- Default remote username - `ubuntu`

***

## Prepare to setup

1. Create `secrets.env`

1. Copy `secrets.env.example` contents to `secrets.env`

1. Fill `secrets.env` with credentials

1. Update variables in locals inside `remote/main.tf` if needed. Use commands inside container to check your changes.

        $ t fmt
        $ t validate

***

## Setup

1. Build docker container

        $ make build

1. Run docker container

        $ make infra

1. Create SSH keys for root user at remote which will be created

        $ make generate_ssh

1. Create remote in Yandex cloud

        $ cd remote
        $ t init
        $ t apply

1. Confirm changes shown in plan

***

**Your ssh key will be stored in `terraform.tfstate` and `terraform.tfstate.backup` files as plain text**

***

## Usage outside container

1. To get remote info use:

        $ make dc_vm_info

1. To get remote IP address use:

        $ make dc_vm_ip

1. To start remote use:

        $ make dc_vm_start

1. To stop remote use:

        $ make dc_vm_stop

1. To connect by ssh use:

        $ eval $(make dc_ssh_vm)

## Usage inside container

1. If you don't run container with `make infra` setup `yandex CLI` with

        $ make yc_init

1. To get remote info use:

        $ make vm_info

1. To get remote IP address use:

        $ make vm_ip

1. To start remote use:

        $ make vm_start

1. To stop remote use:

        $ make vm_stop

1. To connect by ssh use:

        $ eval $(make ssh_vm)

***

## Additional info

- [Manual from Yandex in English](https://cloud.yandex.com/en-ru/docs/solutions/infrastructure-management/terraform-quickstart)
- [Manual from Yandex in Russian](https://cloud.yandex.ru/docs/solutions/infrastructure-management/terraform-quickstart)
