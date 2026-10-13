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

## Version 4.5.2019.24 (jumper's update) – single installer

`KernelEx-4.5.2019.24-FR-cp1252.nsi` builds **`KernelEx-4.5.2019.24-FR.exe`**: KernelEx
4.5.2 FR with jumper's KernelEx 2016/2019 update (MSFN topic 173233) merged in, so only
one installer has to be run. `KernelEx-4.5.2-FR-cp1252.nsi` is unchanged and still builds
the plain 4.5.2 installer.

What the update brings: kernel DLLs 4.5.2016.18–.24 (many more APIs), new modes
**WINXP3** (XP SP3), WIN7A, WIN8/8.1, WIN10, per-application settings for recent
programs (Firefox, VLC, 7-Zip, Opera, Office…) and the `api-ms-win` DLLs of
Windows 7 programs.

The `maj2019/` folder:
- `jumper/` – jumper's original files, untouched (`KERNELEX.DLL` is v17: jumper
  reports v18 as broken, see `NOTE.TXT`).
- `src_fr/` – French resources (UTF-8, Resource Hacker syntax): `sheet_fr.rc`
  (Compatibility tab, rebuilt on jumper's layout since the control IDs changed),
  `verify_fr.rc`, `kernelex_fr.rc` (core error messages).
- `build_maj2019.py` – generates the translated `KernelEx-fr.dll`, `sheet-fr.dll`,
  `verify-fr.exe`, a `core.ini` with French mode descriptions plus the missing
  **NT2K** alias (used by `settings.reg`), `kexmaj.reg` (jumper's per-application
  settings, without the shortcut-handler redirection and the hard-coded InstallDir)
  and `api-ms-w.reg` (5 malformed quote lines fixed). Run it after editing a file of
  `src_fr/`:
  ```powershell
  python maj2019\build_maj2019.py
  ```
  (no Docker needed; Resource Hacker path can be given with `--rh`).

Left out on purpose: `LZDLL.REG` (redirects `Dbghelp`, `Winhttp`… to `LZ32.dll`)
and the development files (`.C`, `.PDB`, `.MAP`, `APILOG`, `APIHOOK`).
`PDH`, `PSAPI`, `UXTHEME`, `WTSAPI32`, `USERENV` are identical to 4.5.2.

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

## Version 4.5.2019.24 (mise à jour de jumper) – installeur unique

`KernelEx-4.5.2019.24-FR-cp1252.nsi` génère **`KernelEx-4.5.2019.24-FR.exe`** : KernelEx
4.5.2 FR avec la mise à jour KernelEx 2016/2019 de jumper (sujet MSFN 173233) intégrée, un
seul installeur à lancer. `KernelEx-4.5.2-FR-cp1252.nsi` est inchangé et génère toujours
l'installeur 4.5.2 seul.

Apports : DLL du noyau 4.5.2016.18 à .24 (beaucoup plus d'API), nouveaux modes
**WINXP3** (XP SP3), WIN7A, WIN8/8.1, WIN10, réglages par programme pour les logiciels
récents (Firefox, VLC, 7-Zip, Opera, Office…) et DLL `api-ms-win` des programmes Windows 7.

Le dossier `maj2019/` :
- `jumper/` – fichiers originaux de jumper, non modifiés (`KERNELEX.DLL` en v17 : jumper
  signale la v18 comme cassée, voir `NOTE.TXT`).
- `src_fr/` – ressources françaises (UTF-8, syntaxe Resource Hacker) : `sheet_fr.rc`
  (onglet Compatibilité, refait sur la mise en page de jumper car les identifiants de
  contrôles ont changé), `verify_fr.rc`, `kernelex_fr.rc` (messages d'erreur du noyau).
- `build_maj2019.py` – génère `KernelEx-fr.dll`, `sheet-fr.dll`, `verify-fr.exe` traduits,
  un `core.ini` aux libellés de modes en français avec l'alias **NT2K** manquant (utilisé
  par `settings.reg`), `kexmaj.reg` (réglages par programme de jumper, sans la redirection
  du gestionnaire de raccourcis ni l'InstallDir codé en dur) et `api-ms-w.reg` (5 lignes
  aux guillemets mal formés corrigées). À relancer après modification de `src_fr/` :
  ```powershell
  python maj2019\build_maj2019.py
  ```
  (pas besoin de Docker ; chemin de Resource Hacker modifiable avec `--rh`).

Écartés volontairement : `LZDLL.REG` (redirige `Dbghelp`, `Winhttp`… vers `LZ32.dll`)
et les fichiers de développement (`.C`, `.PDB`, `.MAP`, `APILOG`, `APIHOOK`).
`PDH`, `PSAPI`, `UXTHEME`, `WTSAPI32`, `USERENV` sont identiques à la 4.5.2.
