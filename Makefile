.PHONY: gen
gen:
	dart run build_runner build --delete-conflicting-outputs

.PHONY: create-splash
create-splash:
	dart run flutter_native_splash:create --path flutter_native_splash.yaml

.PHONY: serve-functions
serve-functions:
	supabase functions serve --env-file ./supabase/.env.local --no-verify-jwt

.PHONY: deploy-functions
deploy-functions:
	supabase functions deploy --no-verify-jwt

.PHONY: deploy-secrets
deploy-functions-env:
	supabase secrets set --env-file ./supabase/.env.local
