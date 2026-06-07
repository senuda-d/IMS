
# Inventory Management System (C# WinForms)

A simple desktop inventory & order management application built using  
**C#, WinForms, SQL Server, ADO.NET**.

---

## 🚀 Features
- Add / update / delete products  
- Manage customers  
- Create orders  
- Track stock reduction automatically  
- Category-based product search  
- SQL Server LocalDB integration  

---

## 🛠️ Tech Stack
- **Language:** C#
- **Framework:** .NET 8.0 (Windows Forms)
- **Database:** SQL Server Express (.\SQLEXPRESS)
- **IDE/Editor:** VS Code

---

## 🚀 How to Run in VS Code
We have migrated the project to modern **.NET 8.0** and configured VS Code for compiling, running, and launching the application.

### Prerequisites
1. **VS Code Extension**: Install the official **C#** (Microsoft) extension.
2. **SQL Server Express**: The application connects automatically to your local `.\SQLEXPRESS` SQL Server instance.

### Setup Instructions
1. **Initialize the Database**:
   Open a terminal in the project root directory and execute the database setup script to create and seed all the tables in your local SQL Server Express:
   ```powershell
   ./setup_database.ps1
   ```
2. **Build and Run**:
   - **Terminal (Easiest)**: Run this simple command in your terminal to build and launch the app:
     ```powershell
     dotnet run --project InventoryMnagement
     ```
   - **Build**: Press `Ctrl+Shift+B` to compile the application.
   - **Run via VS Code Tasks**: Go to the VS Code Command Palette (`Ctrl+Shift+P`), select **Tasks: Run Task**, and choose **run**.
   - **Debug**: Press `F5` or go to the **Run and Debug** view (Ctrl+Shift+D) and select `.NET Core Launch (Debug)`.

### 🔑 Default Credentials
- **Username:** `admin`
- **Password:** `admin`

---

## 📂 Project Structure

```
InventoryManagement/
|-- Assets/
|-- InventoryManagement.sln
|-- InventoryManagement/
    |-- *.cs files
    |-- inventorydb.mdf
```

---

## ✨ Author
Developed by **Senuda Dil**  
GitHub: *https://github.com/SDil1/IMS.git*

