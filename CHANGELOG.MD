# Changelog

## v1.0.0

- Added: Disc creation, disk type could be specified
- Added: Possibility to specify the image to respore hdd from
  - Create a new image at <https://console.cloud.yandex.com/folders/YOUR_FOLDER_ID/compute/images>
  - Set ID of new image as backup_image_id. It will be used to create the disk.
  - In other case public os_image_id will be used
- Removed: hdd_image
- Removed: moved blocks (was added for compability)
  - Apply v0.1.0 to update your current state before this version

## v0.1.0

- Update: All variables for instance and hdd moved to tfvars
- Added: Add dns setup, cname and txt records
- Update: Moved hdd image and network to modules
- Update: Bump yandex provider version up to 0.77.0

## v0.0.5

- Update: Bump terraform version up to v.1.2.7
- Update: Rename workstation to remote
- Update: Add aliases for terraform

## v0.0.4

- Update: Bump terraform version up to v1.1.9

## v0.0.3

- Update: SSH key path refactoring

## v0.0.2

- Update: Change yandex cloud CLI output format and logic how to parse this output to fetch instance public IP address.
- Update: Add jq to docker file
- Update: Add output for public IP after apply
- Update: Change style of bash in docker container

## v0.0.1

- Init version
