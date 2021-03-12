app:
	make tuist
	make cocoapods

tuist:
	@echo "Generate project"
	@tuist generate

cocoapods:
	@echo "Install Pods"
	@pod install || pod install --repo-update
