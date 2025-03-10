#!/bin/bash

echo "Setting up Property Prediction App..."

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check prerequisites
echo "Checking prerequisites..."

if ! command_exists python3; then
    echo "Error: Python 3 is not installed"
    exit 1
fi

if ! command_exists node; then
    echo "Error: Node.js is not installed"
    exit 1
fi

if ! command_exists npm; then
    echo "Error: npm is not installed"
    exit 1
fi

# Setup backend
echo "Setting up backend..."
cd server

# Create Python virtual environment
echo "Creating virtual environment..."
python3 -m venv venv

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate || source venv/Scripts/activate

# Install Python dependencies
echo "Installing Python dependencies..."
pip install -r requirements.txt

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "Creating .env file..."
    cp .env.example .env || echo "Warning: .env.example not found"
fi

# Initialize database
echo "Initializing database..."
python init_db.py

# Setup frontend
echo "Setting up frontend..."
cd ../client

# Install Node.js dependencies
echo "Installing Node.js dependencies..."
npm install

echo "Setup complete!"
echo ""
echo "To start the application:"
echo "1. Start the backend server:"
echo "   cd server"
echo "   source venv/bin/activate  # or 'venv\Scripts\activate' on Windows"
echo "   python main.py"
echo ""
echo "2. In a new terminal, start the frontend:"
echo "   cd client"
echo "   npm start"
echo ""
echo "Don't forget to:"
echo "1. Update the .env file with your configuration"
echo "2. Add your Google Maps API key in client/public/index.html"
echo ""
echo "The application will be available at:"
echo "- Frontend: http://localhost:3000"
echo "- Backend API: http://localhost:5000"
