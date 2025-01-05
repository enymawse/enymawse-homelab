for volume in /root/.stash /cache /metadata /blobs /generated; do
  # Generate a sanitized name for the backup file
  volume_name=$(echo "${volume}" | sed 's|/|_|g' | sed 's|^_||')

  # Define the host directory for the bind mount
  #########
  #
  # Change host_data to the directory where
  # the new stash data will live.
  # The database will need to be restored via the UI
  #
  #########
  host_dir="/host_data${volume}"

  # Ensure the host directory exists
  mkdir -p "${host_dir}"

  # Extract the backup to the host directory
  sudo docker run --rm \
    --volume $(pwd):/backup \
    --volume "${host_dir}:/restore" \
    busybox sh -c "cd /restore && tar -xvf /backup/stash_backup_${volume_name}.tgz --strip 1"
done
