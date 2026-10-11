# KernelEx 4.5.2 – French Translation Fork

This fork is a **translation project** for KernelEx 4.5.2.

It does **not** compile the original source code. Instead, 
it uses the pre-built DLL/EXE files from the official 4.5.2 release and overwrites their resources (dialogs, strings) with translated ones. 
This makes it easy for other modders to create their own translation of KernelEx in any language.

## Translating into another language
1. Copy all the `*-fr.rc` files and rename them with your language code (e.g. `-it.rc` for Italian), then translate them.
2. Update the scripts:
   - `build_res.sh`, line 3: replace `-fr.rc` with your code (e.g. `-it.rc`).
   - `inject_all.ps1`: replace every `-fr.res` with your code.
   - `inject_resources.py`, line 16: replace `-fr` with your code.

## Prerequisites
- [Resource Hacker](https://www.angusj.com/resourcehacker/)
   ([direct download](https://www.angusj.com/resourcehacker/reshacker_setup.exe))
- [Docker Desktop](https://docs.docker.com/desktop/setup/install/windows-install/)
- [NSIS 2.46](https://sourceforge.net/projects/nsis/files/NSIS%202/2.46/)

## Build steps
Run these commands in a PowerShell terminal, from the root of the project:

1. Build the Docker image:
   ```powershell
   docker build -t kernelex-rc .
   ```
2. Run the container:
   ```powershell
   docker run --rm -v "${PWD}:/work" kernelex-rc
   ```
3. Compile the `.rc` files into `.res` files:
   ```powershell
   docker run --rm -v "${PWD}:/work" -w /work kernelex-rc sh build_res.sh
   ```
4. Inject the translated resources into the binaries:
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\inject_all.ps1
   ```

## Building the installer

Open `KernelEx-4.5.2-FR-cp1252.nsi` with MakeNSIS (NSIS 2.46) to generate the translated installer.

---

# KernelEx 4.5.2 – Fork de traduction française
Ce fork est un **projet de traduction** de KernelEx 4.5.2.
Il **ne compile pas** le code source d'origine. 
Il utilise à la place les fichiers DLL/EXE déjà compilés de la version officielle 4.5.2 
et remplace leurs ressources (boîtes de dialogue, chaînes de texte) par des versions traduites. 
Cela permet à d'autres moddeurs de créer facilement leur propre traduction de KernelEx dans n'importe quelle langue.

## Traduire dans une autre langue
1. Copiez tous les fichiers `*-fr.rc` et renommez-les avec le code de votre langue (par exemple `-it.rc` pour l'italien), puis traduisez-les.
2. Mettez à jour les scripts :
   - `build_res.sh`, ligne 3 : remplacez `-fr.rc` par votre code (par exemple `-it.rc`).
   - `inject_all.ps1` : remplacez chaque `-fr.res` par votre code.
   - `inject_resources.py`, ligne 16 : remplacez `-fr` par votre code.

## Prérequis
- [Resource Hacker](https://www.angusj.com/resourcehacker/) ([téléchargement direct](https://www.angusj.com/resourcehacker/reshacker_setup.exe))
- [Docker Desktop](https://docs.docker.com/desktop/setup/install/windows-install/)
- [NSIS 2.46](https://sourceforge.net/projects/nsis/files/NSIS%202/2.46/)

## Étapes de construction
Exécutez ces commandes dans un terminal PowerShell, à la racine du projet :
1. Construire l'image Docker :
   ```powershell
   docker build -t kernelex-rc .
   ```
2. Lancer le conteneur :
   ```powershell
   docker run --rm -v "${PWD}:/work" kernelex-rc
   ```
3. Compiler les fichiers `.rc` en fichiers `.res` :
   ```powershell
   docker run --rm -v "${PWD}:/work" -w /work kernelex-rc sh build_res.sh
   ```
4. Injecter les ressources traduites dans les binaires :
   ```powershell
   powershell -ExecutionPolicy Bypass -File .\inject_all.ps1
   ```

## Création de l'installeur
Ouvrez `KernelEx-4.5.2-FR-cp1252.nsi` avec MakeNSIS (NSIS 2.46) pour générer l'installeur traduit.
