$FennelLocalPath = "~/AppData/Local/Fennel"
$FennelLocalExe = "~/AppData/Local/Fennel/fennel.exe"
$FennelWebPath = "https://fennel-lang.org/downloads/fennel-0.10.0-windows32.exe"
$FennelPgpPath = "https://fennel-lang.org/downloads/fennel-0.10.0-windows32.exe.asc"
$NvimConfigPath = "~/AppData/Local/nvim/lua"

# Setup VimPlug
# TODO: Check the dest path...
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force


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
Write-Host "Creating config folders"
Get-ChildItem ./src/ -recurse -directory | ForEach-Object { New-Item "~/AppData/nvim/lua/$_" -ItemType Directory -Force -WhatIf }