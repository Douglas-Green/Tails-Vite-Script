#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Function to create a directory with error handling
create_directory() {
    local dir=$1
    if mkdir -p "$dir"; then
        echo -e "\e[32mCreated directory: $dir\e[0m"
    else
        echo -e "\e[31mFailed to create directory: $dir\e[0m"
    fi
}

# Function to remove a directory or file with error handling
remove_item_with_handling() {
    local item=$1
    if rm -rf "$item"; then
        echo -e "\e[32mRemoved: $item\e[0m"
    else
        echo -e "\e[31mFailed to remove: $item\e[0m"
    fi
}

# Function to execute a command with error handling
execute_command() {
    local cmd=$1
    if eval "$cmd"; then
        echo -e "\e[32mSuccessfully executed: $cmd\e[0m"
    else
        echo -e "\e[31mError executing: $cmd\e[0m"
    fi
}

# Create Server directory
echo -e "\n\e[36mSetting up the Server directory...\e[0m"
create_directory "Server"

# Wait for 2 seconds
sleep 2

# Setup Server
cd "Server" || exit
echo -e "\n\e[36mInitializing new Node.js project in Server directory...\e[0m"
execute_command "npm init -y"

# Wait for 2 seconds
sleep 2

# Install server dependencies
echo -e "\n\e[36mInstalling server dependencies...\e[0m"
execute_command "npm install express dotenv mysql2 sequelize sequelize-cli jsonwebtoken bcryptjs cors colorette"

# Wait for 2 seconds
sleep 2

# Create necessary directories and files
echo -e "\n\e[36mCreating necessary directories and files in Server directory...\e[0m"
for dir in src/config src/controllers src/middleware src/migrations src/models src/routes src/template; do
    create_directory "$dir"
done

# Wait for 2 seconds
sleep 2

for file in ".env" "App.js" "santasList.txt" "server.js" "src/config/config.js" "src/controllers/controller.js" "src/middleware/middleware.js" "src/migrations/migration.js" "src/models/model.js" "src/routes/route.js" "src/template/template.js"; do
    if touch "$file"; then
        echo -e "\e[32mCreated file: $file\e[0m"
    else
        echo -e "\e[31mFailed to create file: $file\e[0m"
    fi
done

# Wait for 2 seconds
sleep 2

# Navigate back to the root directory
cd ..

# Wait for 2 seconds
sleep 2

# Create Client directory
echo -e "\n\e[36mSetting up the Client directory...\e[0m"
create_directory "Client"

# Wait for 2 seconds
sleep 2

# Setup Client
cd "Client" || exit
APP_NAME=$(basename "$(pwd)")
echo -e "\n\e[36mCreating a new Vite app named $APP_NAME with React and JavaScript template...\e[0m"
execute_command "npm create vite@latest -- --template react"

# Wait for the Vite app creation process to start
sleep 3

# Simulate pressing the period key and then Enter key twice
xdotool type "."
sleep 1
xdotool key Return
sleep 1
xdotool key Return

# Install client dependencies
echo -e "\n\e[36mInitializing client dependencies...\e[0m"
sleep 2
echo -e "\n\e[33mPhase 1 initiated.\e[0m"
execute_command "npm install axios react-router-dom framer-motion @headlessui/react @emotion/react @emotion/styled"
sleep 2

# Install Tailwind CSS and other necessary packages
echo -e "\n\e[36mInitializing Tailwind CSS, Autoprefixer, and PostCSS...\e[0m"
sleep 2
echo -e "\n\e[33mPhase 2 initiated.\e[0m"
execute_command "npm install -D tailwindcss@latest postcss@latest autoprefixer@latest"
sleep 2

# Initialize Tailwind CSS
echo -e "\n\e[36mInitializing Tailwind CSS for enhanced stylization and functionality...\e[0m"
sleep 2
echo -e "\n\e[33mPhase 3 initiated.\e[0m"
execute_command "npx tailwindcss init -p"
sleep 2

# Configure Tailwind CSS in index.css
echo -e "\n\e[36mAttempting to store Tailwind CSS directives in index.css...\n\e[0m"
sleep 2
echo -e "\n\e[33mFinalizing Phases 1-3... Please wait... Phase 4 initiated.\n\e[0m"
cat <<EOT > ./src/index.css
@tailwind base;
@tailwind components;
@tailwind utilities;
EOT
echo -e "\e[32mDirectives stored in index.css. That completes all Tailwind CSS configurations. Thank you for your patience. You may now move on to the important stuff.\e[0m"

# Wait for 5 seconds
sleep 5

# Navigate into the src directory
cd "src" || exit

# Create additional directories in the src directory
echo -e "\n\e[36mCreating additional directories in the src directory...\e[0m"
for dir in authentication components pages services theme utils; do
    create_directory "$dir"
done

# Remove specified items
echo -e "\n\e[36mRemoving specified items...\e[0m"
remove_item_with_handling "../assets"
remove_item_with_handling "App.css"

# Wait for 2 seconds
sleep 2

# Final message recap
final_message="
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
"
echo -e "\n\e[36m$final_message\e[0m"

# Wait for 10 seconds before exiting
sleep 10

cat << "EOF"
# In code we trust. All others bring data.
#  _    _  ____  ___    .  .     _  ___    .  .   __   ___   ___
# ( )  ( )(  __)( o )  _\`'/_   ( )/  _)  _\`'/_ (  ) (   ) /  _)
# | |__| || |_  |   \  )_  _( _ | |\_"-.  )_  _( /  \ | O  |\_"-.
# ( '  ` )(  _) ( O  )  /'`\ ((_( ) __) )  /'`\ ( O  )( __/  __) )
#  \_/\_/ /____\/___/         \__/ /___/         \__/ /_\   /___/
# Doug_Dev 2024
EOF
