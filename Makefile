include MakefileDocker

generate_ssh:
	ssh-keygen -t ed25519 -C ${SSH_KEY_MESSAGE} -P '' -f '/${TF_VAR_service_name}/${TF_VAR_ssh_key_path}'

yc_init:
	@yc config profile create yc-user && \
	yc config set token ${TF_VAR_token} && \
	yc config set cloud-id ${TF_VAR_cloud_id} && \
	yc config set folder-id ${TF_VAR_folder_id} && \
	yc config set format json

vm_info:
	@yc compute instance get --full $${TF_VAR_remote_name}

vm_ip:
	@yc compute instance list | jq ".[] | select(.name==\"$$TF_VAR_remote_name\") | .network_interfaces | .[0] | .primary_v4_address | .one_to_one_nat | .address"

vm_start:
	@yc compute instance start --name ${TF_VAR_remote_name}

vm_stop:
	@yc compute instance stop --name ${TF_VAR_remote_name}

ssh_vm:
	@IP_ADDRESS=$$(make --no-print-directory vm_ip) bash -c 'printf "ssh -i $${TF_VAR_ssh_key_path} $${TF_VAR_username}@$${IP_ADDRESS}"'
