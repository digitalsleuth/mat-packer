# MAT Packer.io Scripts

These scripts were cloned from the SANS SIFT repo and modified for usage with MAT

## VMWare

The scripts herein have been re-designed and tested for work with VMware Workstation 15.x.

### Step 1. Create Base VM

You only need to do this step once. If you use easy install, set the username to `mat` and password to `forensics`. Once everything is installed, you'll want to login and install openssh-server, after that, you can shutdown and exit the VM, you will not need to come back to it.

```bash
sudo apt-get install -y openssh-server
```

### Step 2. Preflight VM

The reason for the preflight VM is simply to make doing builds easier and more consistent in the long run. There is less work that the step 3 has to do, and if step 3 fails for whatever reason, you do not have to start back over at square one.

This is a VM that installs all the base requirements without installing MAT.

```bash
packer build -only=vmware-vmx preflight.json
```
OR
```bash
make preflight
```

### Step 3. MAT VM

This takes the preflight VM and turns it into MAT.

```bash
packer build -only=vmware-vmx mat.json
```
OR 
```bash
make mat-focal
```

### Update MAT VM

This takes the MAT .vmx and runs the MAT scripts to build an updated VM.

```bash
packer build -only=vmware-vmx update.json
```
OR
```bash
make update
```

### Export to OVA

This assumes you are on Windows or Linux with ovftool sourced to your $PATH.
```bash
make export-focal
```

## AWS

Unlike the VMWare and desktop mode build, the AWS build is a server only. In this configuration we do not need to build any base or preflight images ahead of time.
However, this particular script has not been tested with an up-to-date AWS machine.

```bash
make aws-focal
```
