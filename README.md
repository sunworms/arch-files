# Arch files

My Arch Linux files

## New system install:
```
sudo pacman -S ansible
ansible-playbook site.yml 
```

## Install and/or Update Packages:
```
ansible-playbook site.yml --tags packages
```

## Dotfiles:
For a new install, chezmoi will run and init automatically once. For future, just edit the required config file and run `chezmoi apply`.
