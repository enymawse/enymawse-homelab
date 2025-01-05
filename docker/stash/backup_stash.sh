###############
#
# The DB will still need to be backed up via the UI
#
###############


for volume in /root/.stash /cache /metadata /blobs /generated; do
  volume_name=$(echo "${volume}" | sed 's|/|_|g' | sed 's|^_||')
  sudo docker run --rm \
  --volumes-from stash \
  --volume $(pwd):/backup \
  busybox tar -cvzf /backup/stash_backup_${volume_name}.tgz ${volume}
done
