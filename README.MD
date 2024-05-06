
### Implementation of the task:
https://sales.fivexl.io/terraform

### Requirements to reproduce:

- Github account.
- Three AWS accounts configured with AWS organisations hierarchy.

Steps to reproduce:

1. Sign in to your GitHub account
2. Fork this repo
3. Create terraform.tfvars with mandatory variables values.
4. Push terraform.tfvars to repo
5. Put mandatory secrets to Github
6. Change one of the *.html files in repo and push changes
7. Deploy will trigger
8. Subsequent change of *.html files will trigger redeploy
