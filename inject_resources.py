#!/usr/bin/env python3
"""Injection de ressources KernelEx avec Resource Hacker (Windows/Wine).
Compilez le .rc avec windres/rc.exe puis utilisez ce script.
"""
import argparse, shutil, subprocess, sys
from pathlib import Path

def main():
 p=argparse.ArgumentParser()
 p.add_argument('binary', type=Path); p.add_argument('resource', type=Path, help='.res compilé')
 p.add_argument('-o','--output', type=Path)
 p.add_argument('--rh', default=None, help='chemin vers ResourceHacker.exe')
 a=p.parse_args(); rh=a.rh or shutil.which('ResourceHacker.exe') or shutil.which('ResourceHacker')
 if not rh: raise SystemExit('ResourceHacker.exe introuvable; installez-le sous Windows ou Wine.')
 if not a.binary.is_file() or not a.resource.is_file(): raise SystemExit('Binaire ou .res introuvable.')
 out=a.output or a.binary.with_name(a.binary.stem+'-fr'+a.binary.suffix)
 if out.resolve()!=a.binary.resolve(): shutil.copy2(a.binary,out)
 # Resource Hacker accepte un fichier .res et ajoute/remplace les ressources qu’il contient.
 cmd=[rh,'-open',str(out),'-save',str(out),'-action','addoverwrite','-res',str(a.resource)]
 print('>', ' '.join(map(str,cmd))); subprocess.run(cmd,check=True)
 print(f'OK: {out}')
if __name__=='__main__': main()
