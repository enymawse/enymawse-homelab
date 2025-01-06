for volume in /config /certs; do
  # Generate a sanitized name for the backup file
  volume_name=$(echo "${volume}" | sed 's|/|_|g' | sed 's|^_||')

  # Define the host directory for the bind mount
  #########
  #
  # Change host_data to the directory where
  # the new whisparr data will live.
  # The database will need to be restored via the UI
  #
  #########
  host_dir="/mnt/syno_docker_nfs/whisparr${volume}"

  # Ensure the host directory exists
  mkdir -p "${host_dir}"

  # Extract the backup to the host directory
  sudo docker run --rm \
    --volume $(pwd):/backup \
    --volume "${host_dir}:/restore" \
    busybox sh -c "cd /restore && tar -xvf /backup/whisparr_backup_${volume_name}.tgz --strip 1"
done
