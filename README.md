# Scripts PowerShell pour le sandbox de développement chez Done Technologies

## 1. Définir la stratégie d’exécution PowerShell
Vous devez d'abord exécuter la command suivante en **PowerShell** en tant qu'**administrateur**:
```powershell
Set-ExecutionPolicy Unrestricted -force
```

## 2. Choisir une version du script
Vous pouvez choisir **une** des deux versions du script suivantes et l'exécuter en tant qu'**administrateur**:

### Chocolatey
```powershell
sandbox_chocolatey.ps1
```

### Windows Package Manager
```powershell
sandbox_winget.ps1
```

## 3. Exécuter le script nécessitant une actualisation des variables d'environnement
Ce script nécessite un **redémarrage** de PowerShell suite aux modifications des variables d'environnement. Il doit donc être exécuté dans un second temps.
```powershell
post_sandbox.ps1
```

## 4. Modifier la page d'acceuil de Chrome
Modifier la page d'acceuil et la page de démarrage de Chrome pour la page suivante:
```html
C:\Users\%USER%\Documents\homepage.html
```

### Autres suggestion de package non inclu dans le script:
- Angular CLI
- ReSharper
- Azure CLI
- Azure Cosmos DB Emulator
- ScreenToGif
- A VPN client
- Greenshot
- Microsoft .NET CLI (dotnet-*)