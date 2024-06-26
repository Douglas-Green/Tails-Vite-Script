#!/usr/bin/env pwsh

# Function to check if a command exists
function CommandExists {
  param (
    [string]$Command
  )
  return Get-Command $Command -ErrorAction SilentlyContinue -CommandType Application -ErrorAction SilentlyContinue -CommandType Cmdlet
}

# Function to create a directory with error handling
function CreateDirectory {
  param (
    [string]$Path
  )
  try {
    New-Item -ItemType Directory -Path $Path -ErrorAction Stop
    Write-Host "Created directory: $Path" -ForegroundColor Green
  }
  catch {
    Write-Host "Failed to create directory: $Path" -ForegroundColor Red
  }
}

# Function to remove a directory or file with error handling
function RemoveItemWithHandling {
  param (
    [string]$Path
  )
  try {
    Remove-Item -Path $Path -Recurse -Force -ErrorAction Stop
    Write-Host "Removed: $Path" -ForegroundColor Green
  }
  catch {
    Write-Host "Failed to remove: $Path" -ForegroundColor Red
  }
}

# Function to execute a command with error handling
function ExecuteCommand {
  param (
    [string]$Command,
    [string]$Arguments
  )
  try {
    $process = Start-Process -FilePath $Command -ArgumentList $Arguments -NoNewWindow -Wait -PassThru
    if ($process.ExitCode -eq 0) {
      Write-Host "Successfully executed: $Command $Arguments" -ForegroundColor Green
    }
    else {
      Write-Host "Error executing: $Command $Arguments. Exit code: $($process.ExitCode)" -ForegroundColor Red
    }
  }
  catch {
    Write-Host "Exception occurred while executing: $Command $Arguments" -ForegroundColor Red
    Write-Host $_ -ForegroundColor Red
  }
}

# Create Server directory
Write-Host "`nSetting up the Server directory..." -ForegroundColor Cyan
CreateDirectory "Server"

# Wait for 2 seconds
Start-Sleep -Seconds 2

# Setup Server
Set-Location "Server"
Write-Host "`nInitializing new Node.js project in Server directory..." -ForegroundColor Cyan
ExecuteCommand "npm" "init -y"

# Wait for 2 seconds
Start-Sleep -Seconds 2

# Install server dependencies
Write-Host "`nInstalling server dependencies..." -ForegroundColor Cyan
ExecuteCommand "npm" "install express dotenv mysql2 sequelize sequelize-cli jsonwebtoken bcryptjs cors colorette nodemon"

# Wait for 2 seconds
Start-Sleep -Seconds 2

# Create necessary directories and files
Write-Host "`nCreating necessary directories and files in Server directory..." -ForegroundColor Cyan
@(
  "src/config",
  "src/controllers",
  "src/middleware",
  "src/migrations",
  "src/models",
  "src/routes",
  "src/template"
) | ForEach-Object { CreateDirectory $_ }

# Wait for 2 seconds
Start-Sleep -Seconds 2

@(
  ".env",
  "App.js",
  "santasList.txt",
  "Server.js",
  "src/config/config.js",
  "src/controllers/index.js",
  "src/middleware/index.js",
  "src/migrations/index.js",
  "src/models/index.js",
  "src/routes/index.js",
  "src/template/index.js"
) | ForEach-Object {
  try {
    New-Item -ItemType File -Path $_ -ErrorAction Stop
    Write-Host "Created file: $_" -ForegroundColor Green
  }
  catch {
    Write-Host "Failed to create file: $_" -ForegroundColor Red
  }
}

# Wait for 2 seconds
Start-Sleep -Seconds 2

# Navigate back to the root directory
Set-Location -Path ..

# Wait for 2 seconds
Start-Sleep -Seconds 2

# Create Client directory
Write-Host "`nSetting up the Client directory..." -ForegroundColor Cyan
CreateDirectory "Client"

# Wait for 2 seconds
Start-Sleep -Seconds 2

# Setup Client
Set-Location "Client"
$APP_NAME = Split-Path -Leaf (Get-Location)
Write-Host "`nCreating a new Vite app named $APP_NAME with React and JavaScript template..." -ForegroundColor Cyan
$viteProcess = Start-Process -FilePath "npm" -ArgumentList "create vite@latest -- --template react" -NoNewWindow -PassThru

# Wait for the Vite app creation process to start
Start-Sleep -Seconds 3

# Simulate pressing the period key and then Enter key twice
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.SendKeys]::SendWait(".")
Start-Sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
Start-Sleep -Seconds 1
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")

# Wait for the Vite process to exit
$viteProcess.WaitForExit()

# Install client dependencies
Write-Host "`nInitializing client dependencies..." -ForegroundColor Cyan
Start-Sleep -Seconds 2
Write-Host "`nPhase 1 initiated." -ForegroundColor Yellow
ExecuteCommand "npm" "install axios react-router-dom framer-motion @headlessui/react @emotion/react @emotion/styled prop-types react-select"
Start-Sleep -Seconds 2

# Install Tailwind CSS and other necessary packages
Write-Host "`nInitializing Tailwind CSS, Autoprefixer, and PostCSS..." -ForegroundColor Cyan
Start-Sleep -Seconds 2
Write-Host "`nPhase 2 initiated." -ForegroundColor Yellow
ExecuteCommand "npm" "install -D tailwindcss@latest postcss@latest autoprefixer@latest"
Start-Sleep -Seconds 2

# Initialize Tailwind CSS
Write-Host "`nInitializing Tailwind CSS for enhanced stylization and functionality..." -ForegroundColor Cyan
Start-Sleep -Seconds 2
Write-Host "`nPhase 3 initiated." -ForegroundColor Yellow
ExecuteCommand "npx" "tailwindcss init -p"
Start-Sleep -Seconds 2

# Configure Tailwind CSS in index.css
Write-Host "`nAttempting to store Tailwind CSS directives in index.css...`n" -ForegroundColor Cyan
Start-Sleep -Seconds 2
Write-Host "`nFinalizing Phases 1-3... Please wait... Phase 4 initiated.`n" -ForegroundColor Yellow
@"
@tailwind base;
@tailwind components;
@tailwind utilities;
"@ | Out-File -FilePath .\src\index.css -Encoding utf8
Write-Host "Directives stored in index.css. That completes all Tailwind CSS configurations. Thank you for your patience. You may now move on to the important stuff." -ForegroundColor Green

# Wait for 5 seconds
Start-Sleep -Seconds 5

# Navigate into the src directory
Set-Location "src"

# Create additional directories in the src directory
Write-Host "`nCreating additional directories in the src directory..." -ForegroundColor Cyan
@(
  "authentication",
  "components",
  "pages",
  "services",
  "theme",
  "utils"
) | ForEach-Object { CreateDirectory $_ }

# Remove specified items
Write-Host "`nRemoving specified items..." -ForegroundColor Cyan
RemoveItemWithHandling "..\assets"
RemoveItemWithHandling "App.css"

# Wait for 2 seconds
Start-Sleep -Seconds 2

# Navigate back to the root directory
Set-Location -Path ..

# Wait for 2 seconds
Start-Sleep -Seconds 2

# Final message recap
$finalMessage = @"
Setup complete! The following tasks were performed:
1. Created and set up Server directory.
2. Initialized Node.js project and installed server dependencies.
3. Created necessary directories and files in Server.
4. Created and set up Client directory.
5. Created Vite app with React and JavaScript template.
6. Installed client dependencies.
7. Installed and configured Tailwind CSS.
8. Created additional directories in src.
9. Removed unnecessary items.

Thank you for using the script!
"@

Write-Host "`n$finalMessage" -ForegroundColor Cyan

# Wait for 10 seconds before exiting
Start-Sleep -Seconds 10


@"
# In code we trust. All others bring data.
#  _    _  ____  ___    .  .     _  ___    .  .   __   ___   ___  
# ( )  ( )(  __)( o )  _\`'/_   ( )/  _)  _\`'/_ (  ) (   ) /  _) 
# | |__| || |_  |   \  )_  _( _ | |\_"-.  )_  _( /  \ | O  |\_"-. 
# ( '  ` )(  _) ( O  )  /'`\ ((_( ) __) )  /'`\ ( O  )( __/  __) )
#  \_/\_/ /____\/___/         \__/ /___/         \__/ /_\   /___/ 
# Doug_Dev 2024
"@ | Write-Host -ForegroundColor Cyan
