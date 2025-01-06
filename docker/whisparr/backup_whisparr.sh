###############
#
# The DB will still need to be backed up via the UI
#
###############


for volume in /config /certs; do
  volume_name=$(echo "${volume}" | sed 's|/|_|g' | sed 's|^_||')
  sudo docker run --rm \
  --volumes-from whisparr \
  --volume $(pwd):/backup \
  busybox tar -cvzf /backup/whisparr_backup_${volume_name}.tgz ${volume}
done
