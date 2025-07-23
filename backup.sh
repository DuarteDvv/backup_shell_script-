#!/bin/bash

### verifica se recebeu exatamente 2 argumentos
if [[ $# -ne 2 ]]; then
  echo "Uso: backup.sh target_directory destination_directory"
  exit 1
fi

### verifica se ambos são diretórios válidos
if [[ ! -d $1 ]] || [[ ! -d $2 ]]; then
  echo "Invalid directory path provided"
  exit 1
fi

targetDirectory=$1
destinationDirectory=$2

echo "Origem:  $targetDirectory"
echo "Destino: $destinationDirectory"

### timestamp atual e de 24h atrás
currentTS=$(date +%s)
yesterdayTS=$((currentTS - 24*60*60))

backupFileName="backup-$currentTS.tar.gz"

### caminhos absolutos
origAbsPath=$(pwd)
cd "$destinationDirectory"
destDirAbsPath=$(pwd)

### volta e entra na pasta de origem
cd "$origAbsPath"
cd "$targetDirectory"

declare -a toBackup
for file in *; do
  ### obtém mtime em segundos
  file_mtime=$(date -r "$file" +%s)
  if (( file_mtime > yesterdayTS )); then
    toBackup+=("$file")
  fi
done

### compacta e move
tar -czvf "$backupFileName" "${toBackup[@]}"
mv "$backupFileName" "$destDirAbsPath"

echo "Backup concluído: $destinationDirectory/$backupFileName"
