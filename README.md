# Desktop Switcher

**Desktop Switcher** lets you create and switch between multiple desktop environments on your Windows PC. Each desktop environment is a separate folder where you can store files and icons.  

## What it does

- Windows shows one folder as your desktop. This script lets you **switch to a different folder as your desktop**, creating a new environment without affecting your original desktop files.  
- It automatically downloads **DesktopOK**, which **backs up and restores your desktop icon layout** when you switch environments. This keeps your icons organized.  

## How to use

1. **Run the script** and enter a name for your new desktop environment.  
2. After the script finishes:  
   - Click the **`to_<YourEnvironment>`** shortcut on your desktop to switch to the new environment.  
   - Inside the new desktop folder, click **`to_home`** to restore your original desktop.  
3. Your desktop icons and layout are automatically saved and restored by DesktopOK.  
4. **Switching desktops does not delete any files**; it only changes which folder is displayed as your desktop.  

## How it works

1. The script creates a folder called `Desktop_Switcher` in your home directory.  
2. It downloads and extracts **DesktopOK.exe** into this folder.  
3. It asks you to enter a name for your new desktop environment.  
4. It creates a folder named `Desktop_<YourEnvironment>` to hold the new desktop’s files.  
5. It creates two small command files (`.bat`):  
   - `to_<YourEnvironment>.bat` – switches your desktop to the new folder.  
   - `to_home.bat` – switches back to your original desktop.  
6. It creates shortcuts for easier use:  
   - `to_<YourEnvironment>` appears on your **current desktop** to switch to the new environment.  
   - `to_home` appears **inside the new desktop folder** to switch back.
