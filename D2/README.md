# Reproducing the power-flow results (Assignment D2, Question 1)

## Prerequisites
- Python 3.11.x

## Environment setup

Create and activate the Python virtual environment using the provided setup script.

### Windows (PowerShell)
```ps
.\setup_venv.bat
.\pp-venv\Scripts\Activate.ps1
```
The script creates a virtual environment and installs all required dependencies listed in `requirements.txt`.

## Running power-flow calculation
Activate the virtual environment (if you haven't already), then run: 
```ps
python -B powerflow.py
```
The power-flow results are printed to stdout, and the test network is plotted. 