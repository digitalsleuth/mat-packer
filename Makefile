preflight-%:
	packer build -only=vmware-vmx -var="distro=$*" preflight.json

mat-%:
	packer build -only=vmware-vmx -var="distro=$*" mat.json
	sed -e 's/displayname.*/displayname = "MAT"/' ./_virtuals/mat-$*.vmwarevm/mat-vm.vmx > ./_virtuals/mat-$*.vmwarevm/mat-vm.vmx.1
	rm ./_virtuals/mat-$*.vmwarevm/mat-vm.vmx
	mv ./_virtuals/mat-$*.vmwarevm/mat-vm.vmx.1 ./_virtuals/mat-$*.vmwarevm/mat-vm.vmx

update-%:
	packer build -only=vmware-vmx -var="distro=$*" update.json
	sed -e 's/displayname.*/displayname = "MAT"/' ./_virtuals/mat-update-$*.vmwarevm/mat-vm.vmx > ./_virtuals/mat-update-$*.vmwarevm/mat-vm.vmx.1
	rm ./_virtuals/mat-update-$*.vmwarevm/mat-vm.vmx
	mv ./_virtuals/mat-update-$*.vmwarevm/mat-vm.vmx.1 ./_virtuals/mat-update-$*.vmwarevm/mat-vm.vmx

export-mat-%:
	/Applications/VMware\ Fusion.app/Contents/Library/VMware\ OVF\ Tool/ovftool --acceptAllEulas ./_virtuals/mat-$*.vmwarevm/mat-vm.vmx ./mat-$*.ova

export-update-%:
	/Applications/VMware\ Fusion.app/Contents/Library/VMware\ OVF\ Tool/ovftool --acceptAllEulas ./_virtuals/mat-update-$*.vmwarevm/mat-vm.vmx ./mat-update-$*.ova

aws-focal:
	packer build -only=amazon-ebs mat-aws.json
