# Docker secrets

Docker secrets are a way to provide information in a more secure way than using environment variables. You are not supposed to version your secrets in git.

Expected secrets:
- hydroweb credentials :
  - **hydroweb_user.txt** : contains *only* the username
  - **hydroweb_password.txt** : contains *only* the password
