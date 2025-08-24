# delete_containers.ps1

# Get all container names matching the pattern
$containers = docker ps -a --format "{{.Names}}" | Where-Object { $_ -like "level*-container" }

# Loop over each container and delete it
foreach ($c in $containers) {
    Write-Host "Deleting container: $c"
    docker rm -f $c
}
