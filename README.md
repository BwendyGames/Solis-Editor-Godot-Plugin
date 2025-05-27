# Solis Text Editor Godot Plugin

Requires the [**Solis Text Editor**](https://github.com/BwendyGames/Solis-Text-Editor/releases)

---

## Installation

1. **Download** or clone this repository.

2. **Copy** the entire plugin folder into your Godot project's `addons/` directory.

3. **Enable** the plugin in Godot:  
   - Go to `Project > Project Settings > Plugins`
   - Set **Solis Editor Plugin** to "Active".

---

## Setup

### 1. Set the File Path to Solis Editor

Open the **Tools** menu in Godot and select **Set Solis Editor Path...**  
Choose the Solis Text Editor executable you downloaded.

![Set Solis Editor Path](https://github.com/user-attachments/assets/b4113cd9-fbec-4041-bdb7-874808d51f5a)

---

## Usage

### Open Individual Scripts in Solis

When you select a script resource in the Inspector, you’ll see an **Open with Solis Text Editor** button.  
Click it to instantly open the script in Solis.

![Inspector Button](https://github.com/user-attachments/assets/8817c29b-8d72-401c-8555-10c41599d0b3)

---

### Open Your Whole Project Folder

You can also open the entire Godot project folder with Solis from the Tools menu.

![Open Project Folder](https://github.com/user-attachments/assets/76db2cba-3ce6-4505-a2a4-43572acf25c9)

---

## **Full Integration: Open Scripts in Solis from Script Icons**

![Solis Editor UI](https://github.com/user-attachments/assets/a5348123-1c93-4ddf-9cd8-8f492d109cf0)

To make scripts open in Solis when you click the script icon or double-click a script:

1. Go to `Editor > Editor Settings > Text Editor > External`
2. **Enable:** `Use External Editor`
3. **Exec Path:** Point to your Solis executable (e.g. `C:/Path/To/Solis.exe`)
4. **Exec Flags:** `{file}`

Now, clicking the script icon in the scene tree or script list will open it directly in Solis.

---

## Other Tips

- You can set Solis as the **default editor for `.gd`, `.py`, or other file types** on your operating system if you want scripts to open in Solis by default from the file browser.

- Solis Editor is still evolving—check for updates on the [GitHub Releases page](https://github.com/BwendyGames/Solis-Text-Editor/releases).

---
