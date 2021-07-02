include MakefileDocker

generate_ssh:
	ssh-keygen -t ed25519 -C ${SSH_KEY_MESSAGE} -P '' -f '/${TF_VAR_service_name}/${TF_VAR_ssh_key_path}'

yc_init:
	@yc config profile create yc-user-profile && \
	yc config set token ${TF_VAR_token} && \
	yc config set cloud-id ${TF_VAR_cloud_id} && \
	yc config set folder-id ${TF_VAR_folder_id}

vm_info:
	@yc compute instance list | grep ${TF_VAR_workstation_name} | awk "{print \$$2}" | xargs yc compute instance get --full

vm_ip:
	@yc compute instance list | grep ${TF_VAR_workstation_name} | awk "{print \$$10}"

vm_start:
	@yc compute instance start --name ${TF_VAR_workstation_name}

vm_stop:
	@yc compute instance stop --name ${TF_VAR_workstation_name}

ssh_vm:
	@IP_ADDRESS=$$(make --no-print-directory vm_ip) bash -c 'printf "ssh -i $${TF_VAR_ssh_key_path} $${TF_VAR_username}@$${IP_ADDRESS}"'
