#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to create a directory with error handling
create_directory() {
    local dir_path="$1"
    if mkdir -p "$dir_path"; then
        echo -e "\e[32mCreated directory: $dir_path\e[0m"
    else
        echo -e "\e[31mFailed to create directory: $dir_path\e[0m"
    fi
}

# Function to remove a directory or file with error handling
remove_item_with_handling() {
    local path="$1"
    if rm -rf "$path"; then
        echo -e "\e[32mRemoved: $path\e[0m"
    else
        echo -e "\e[31mFailed to remove: $path\e[0m"
    fi
}

# Function to execute a command with error handling
execute_command() {
    local cmd="$1"
    local args="$2"
    if $cmd $args; then
        echo -e "\e[32mSuccessfully executed: $cmd $args\e[0m"
    else
        echo -e "\e[31mError executing: $cmd $args\e[0m"
    fi
}

# Create Server directory
echo -e "\e[36m\nSetting up the Server directory...\e[0m"
create_directory "Server"

# Setup Server
cd "Server" || exit
echo -e "\e[36m\nInitializing new Node.js project in Server directory...\e[0m"
execute_command "npm" "init -y"

# Install server dependencies
echo -e "\e[36m\nInstalling server dependencies...\e[0m"
execute_command "npm" "install express dotenv mysql2 sequelize sequelize-cli jsonwebtoken bcryptjs cors colorette nodemon"

# Create necessary directories and files
echo -e "\e[36m\nCreating necessary directories and files in Server directory...\e[0m"
for dir in src/config src/controllers src/middleware src/migrations src/models src/routes src/template; do
    create_directory "$dir"
done

for file in .env App.js santasList.txt Server.js src/config/config.js src/controllers/index.js src/middleware/index.js src/migrations/index.js src/models/index.js src/routes/index.js src/template/index.js; do
    if touch "$file"; then
        echo -e "\e[32mCreated file: $file\e[0m"
    else
        echo -e "\e[31mFailed to create file: $file\e[0m"
    fi
done

cd ..

# Create Client directory
echo -e "\e[36m\nSetting up the Client directory...\e[0m"
create_directory "Client"

# Setup Client
cd "Client" || exit
APP_NAME=${PWD##*/}
echo -e "\e[36m\nCreating a new Vite app named $APP_NAME with React and JavaScript template...\e[0m"
execute_command "npm" "create vite@latest -- --template react"

# Install client dependencies
echo -e "\e[36m\nInstalling client dependencies...\e[0m"
execute_command "npm" "install axios react-router-dom framer-motion @headlessui/react @emotion/react @emotion/styled prop-types react-select"

# Install Tailwind CSS and other necessary packages
echo -e "\e[36m\nInstalling Tailwind CSS, Autoprefixer, and PostCSS...\e[0m"
execute_command "npm" "install -D tailwindcss@latest postcss@latest autoprefixer@latest"

# Initialize Tailwind CSS
echo -e "\e[36m\nInitializing Tailwind CSS...\e[0m"
execute_command "npx" "tailwindcss init -p"

# Configure Tailwind CSS in index.css
echo -e "\e[36m\nConfiguring Tailwind CSS in index.css...\e[0m"
echo "@tailwind base;
@tailwind components;
@tailwind utilities;" > ./src/index.css
echo -e "\e[32mTailwind CSS directives added to index.css.\e[0m"

# Create additional directories in the src directory
echo -e "\e[36m\nCreating additional directories in the src directory...\e[0m"
cd src || exit
for dir in authentication components pages services theme utils; do
    create_directory "$dir"
done

# Remove specified items
echo -e "\e[36m\nRemoving specified items...\e[0m"
remove_item_with_handling "../assets"
remove_item_with_handling "App.css"

cd ..

# Final message recap
echo -e "\e[36m\nSetup complete! The following tasks were performed:
1. Created and set up Server directory.
2. Initialized Node.js project and installed server dependencies.
3. Created necessary directories and files in Server.
4. Created and set up Client directory.
5. Created Vite app with React and JavaScript template.
6. Installed client dependencies.
7. Installed and configured Tailwind CSS.
8. Created additional directories in src.
9. Removed unnecessary items.

Thank you for using the script!\e[0m"

echo -e "\e[36m
# In code we trust. All others bring data.
#  _    _  ____  ___    .  .     _  ___    .  .   __   ___   ___
# ( )  ( )(  __)( o )  _\`'/_   ( )/  _)  _\`'/_ (  ) (   ) /  _)
# | |__| || |_  |   \  )_  _( _ | |\_"-.  )_  _( /  \ | O  |\_"-.
# ( '  ` )(  _) ( O  )  /'`\ ((_( ) __) )  /'`\ ( O  )( __/  __) )
#  \_/\_/ /____\/___/         \__/ /___/         \__/ /_\   /___/
# Doug_Dev 2024
\e[0m"

# Wait for 10 seconds before exiting
sleep 10
