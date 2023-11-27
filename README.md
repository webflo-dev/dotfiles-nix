# Fresh installation

https://nixos.org/manual/nixos/stable/#sec-installation

or 

From live installation

## Step 1: partition drives

2 Partitions:
* boot: 200M FAT32
* NixOS: <rest of the SSD>M EXT4

## Step 2: formatting partitions

`/dev/sda1` => boot partition
`/dev/sda2` => NixOS partition

```
sudo mkfs.fat -F 32 /dev/sda1
sudo fatlabel /dev/sda1 BOOT
sudo mkfs.ext4 /dev/sda2 -L NIXOS
```

## Step 3: mounting partitions

```
sudo mount /dev/disk/by-label/NIXOS /mnt
sudo mkdir /mnt/boot
sudo mount /dev/disk/by-label/BOOT /mnt/boot
```

## Step 4: generate actual configuration

```
sudo nixos-generate-config --root /mnt
```

then, install NixOS
```
sudo nixos-install
```

# Flake installation


### remote flake installation

```
sudo nixos-rebuild switch --flake "github:webflo-dev/dotfiles-nix"#<hostname>
```

### local flake installation
```
sudo nixos-rebuild switch --flake .
```

# Home manager

```
home-manager switch --flake "github:webflo-dev/dotfiles-nix"
```

If repo is cloned, used this instead:
```
home-manager switch --flake .
```