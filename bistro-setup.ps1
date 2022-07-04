$FennelLocalPath = "~/AppData/Local/Fennel"
$FennelLocalExe = "~/AppData/Local/Fennel/fennel.exe"
$FennelWebPath = "https://fennel-lang.org/downloads/fennel-0.10.0-windows32.exe"
$FennelPgpPath = "https://fennel-lang.org/downloads/fennel-0.10.0-windows32.exe.asc"
$NvimConfigPath = "~/AppData/Local/nvim/lua"
$NvimPlugPath = "~/AppData/Local/nvim/autoload/plug.vim"

# Setup VimPlug
if (-not (Test-Path $NvimPlugPath)) {
  Invoke-WebRequest -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
      New-Item $NvimPlugPath -Force
}

# Setup Fennel
try {
  Get-Command fennel
}
catch {
  # Download Fennel
  try {
    Invoke-WebRequest $FennelWebPath | New-Item $FennelLocalExe -Force
    #TODO: Verify signature...
    Write-Host "Fennel successfully downloaded"

    [Environment]::SetEnvironmentVariable("Path", $Env:Path + $FennelLocalPath, "Process")
    Write-Host "Fennel added to the path"
  }
  catch {
    Write-Error "Fennel setup incomplete"
  }
}

# Prep neovim config folders
# Write-Host "Creating config folders"
# Get-ChildItem ./src/ -recurse -directory | ForEach-Object {
#   $Dir = "~/AppData/nvim/lua/$_"
#   if (-not (Test-Path $Dir)) {
#     New-Item $Dir -ItemType Directory -Force -WhatIf
#   }
# }

# Prep neovim config folders
Write-Host "Creating lua folder"
  $Dir = "~/AppData/nvim/lua/"
  if (-not (Test-Path $Dir)) {
    New-Item $Dir -ItemType Directory -Force
  }
}
