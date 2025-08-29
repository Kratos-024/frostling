# build_levels.ps1
# Build Docker images from level directories (level0, level1, ...)

# Get all directories starting with 'level'
$dirs = Get-ChildItem -Directory | Where-Object { $_.Name -like "level*" }

foreach ($dir in $dirs) {
    $dockerfilePath = Join-Path $dir.FullName "Dockerfile"
    
    if (Test-Path $dockerfilePath) {
        $imageName = "child-$($dir.Name)-image"
        Write-Host "Building Docker image: $imageName from $dockerfilePath"
        docker build -t $imageName $dir.FullName
    } else {
        Write-Host "No Dockerfile found in $($dir.Name), skipping..."
    }
}
