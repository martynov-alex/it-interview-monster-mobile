# Define phony targets to avoid conflicts with files
.PHONY: flutter-get dart-gen dart-gen-watch gen-api template-dev-init tmpl-git-config

# Default help command
help:
	@echo "Available commands:"
	@{ \
	  printf "%-25s %s\n" "make get" "Get Flutter dependencies"; \
	  printf "%-25s %s\n" "make bootstrap" "Bootstrap Project"; \
	  printf "%-25s %s\n" "make gen" "Generate Dart files"; \
	  printf "%-25s %s\n" "make gen-watch" "Watch and generate Dart files"; \
	  printf "%-25s %s\n" "make gen-api" "Generate API client from OpenAPI"; \
	}

# Task: Get flutter dependencies
get:
	@echo "Getting Flutter dependencies..."
	flutter pub get

# Task: Bootstrap Project
bootstrap:
	bash scripts/bootstrap.bash

# Task: Generate Dart files
gen:
	@echo "Running Dart codegen..."
	dart run build_runner build -d

# Task: Watch Dart codegen
gen-watch:
	@echo "Watching Dart codegen..."
	dart run build_runner watch -d

# Task: Generate API client from OpenAPI specification
gen-api:
	@echo "Generating API client from OpenAPI..."
	bash scripts/generate_api.bash

init-platform:
	@echo "Initializing platform..."
	@cd app && flutter create --org ru.martynovalex.it_interview_monster --platforms=web . && rm -f test/widget_test.dart