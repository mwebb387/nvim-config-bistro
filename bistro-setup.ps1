$NvimConfigPath = "$env:LOCALAPPDATA\nvim\lua"
$NvimPlugPath = "$env:LOCALAPPDATA\nvim\autoload\plug.vim"

# Check for Scoop
try {
  Get-Command scoop
  Write-Host "Scoop is installed"
}
catch {
  Write-Host "Please install and configure Scoop before running this setup"
  Exit
}

# Setup Neovim
try {
  Write-Host "Checking for Neovim..."
  Get-Command nvim
  Write-Host "Neovim is installed"
}
catch {
  Write-Host "Installing Neovim"
  scoop install neovim
}


# Setup VimPlug
if (-not (Test-Path $NvimPlugPath)) {
  Write-Host "Setting up plug for Neovim"
  Invoke-WebRequest -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
      New-Item $NvimPlugPath -Force
} else {
  Write-Host "Plug is already installed"
}

# Setup Fennel
try {
  Write-Host "Checking for Fennel..."
  Get-Command fennel
  Write-Host "Fennel is installed"
}
catch {
  Write-Host "Installing Fennel"
  scoop install lua
  scoop install luarocks
  luarocks install fennel
}

# Prep neovim config folders
Write-Host "Creating lua folder"
if (-not (Test-Path $NvimConfigPath)) {
  New-Item $NvimConfigPath -ItemType Directory -Force
} else {
  Write-Host "Lua folder already exists"
}

# Adding current directory to the path for easy building
Write-Host "Adding Bistro directory to User Path"
$path = [Environment]::GetEnvironmentVariable("Path", "User")
if (-not $path.Contains($PSScriptRoot)) {
  [Environment]::SetEnvironmentVariable("Path", $path + ";" + $PSScriptRoot, "User")
} else {
  Write-Host "Path already contains Bistro directory"
}

