# oct-server-gcloud

Deploy oct server to cloud run with gcloud

## Cloud Build

The easiest way to ensure a stable environment is a container. Please build and start it by utilizing docker compose:

```shell
docker compose -f dev.docker-compose.yaml build
docker compose -f dev.docker-compose.yaml up -d
```

Bash into the container to perform all required setup steps:

```shell
docker exec -it gcloud-run bash
```

Whenever possible steps are stored in bash scripts which utilize gcloud commands to perform the required tasks.

## Semi-automatic Preparation

A couple of manual steps are required before the automated part.

1. *You only have to do this once*: [Perform auth login](./scripts/prepare/authLogin.sh). It will provide a URL you need to paste to browser manually. Once you enter the generated confomation token back in the terminal the process is completed. All info is stored in a named container volume, so the info is persisted and data will be back after container restarts. You can [print auth info with a script](./scripts/prepare/printAuth.sh).
2. You need to install [Google Cloud Build
 GitHub App](https://github.com/marketplace/google-cloud-build) in GitHub. Configure the repository the repository that should be used bind to it. Once you did, you need to retrieve the installation id Google Cloud Build app here: <https://github.com/settings/installations>. The id needs to be used in step 3.5. below.
3. *You only have to do this once*: [Create an env file](./scripts/prepare/createEnvFile.sh) from template in the project's root. Adjust the values accordingly and in the order descibed below:
    1. First set the `PROJECT_ID` in the env file and save it. Directly [use a script to create the project](./scripts/prepare/createProject.sh) to create a project. It also sets the default project in the local settings.
    2. Use [printBillingAccounts.sh](./scripts/prepare/printBillingAccounts.sh) to retrieve the billing account number and set `BILLING_ACCOUNT_ID` in the env file.
    3. [Enable all required APIs](./scripts/prepare/enableRequiredApis.sh). It requires the billing account previously set.
    4. Use [printRegions.sh](./scripts/prepare/printRegions.sh) to print all regions and set `DEFAULT_REGION` in the env file. Save the env file. [Use another script set the default region](./scripts/prepare/setDefaultRegion.sh) in the local glcoud config.
    5. Set the `GITHUB_APP_ID` in the env file retrieved in step 2 which will bind the project to the specified repository.
    6. Update the *GitHub repository* related variables
    7. Adjust OCT environment properties if values are already known. Otherwise, leave as is, because they can be altered and updated later.
4. [Verify the env file](./scripts/prepare/verifyEnvFile.sh)
5. GitHub:
  4.a. Create a classic access token with all `repo` and `read:user` permissions. If your app is installed in an organization, make sure to also select the `read:org` permission. ([see](https://cloud.google.com/build/docs/automating-builds/github/connect-repo-github?generation=2nd-gen#connecting_a_github_host_programmatically))
  4.b. Store this token in `<repo-root>/.local/gh.token`. The folder is in contained `.gitignore` and the token can be deleted once it was successfully processed with the next step:
  4.c. [Store the GitHub token as secret](./scripts/prepare/storeGitHubToken.sh)

## Setup

**Either**: Execute all setup steps one after the other:

1. [Create new service account and update required permissions](./scripts/setup/updateServiceAccounts.sh)
2. [Create a builds to repo connection](./scripts/setup/createBuildsConnection.sh)
3. [Create a builds repository](./scripts/setup/createBuildsRepository.sh)
4. [Create a docker artifacts repository](./scripts/setup/createArtifactsRepository.sh)
5. [Create a builds trigger](./scripts/setup/createBuildsTrigger.sh)

**Or**: Perform them all sequentially with one script:

- [Perform all steps](./scripts/performAllSteps.sh)

## Post setup steps

### Required post step

You have to [enable public access](./scripts/post/enablePublicAccess.sh) to the deployed app. Usage is only possible after first deployment of the app to cloud run.

### Project specific post steps

#### Secrets

Secret can be manually updated here: <https://console.cloud.google.com/security/secret-manager>
It is higly recommende to update at least the `OCT_JWT_PRIVATE_KEY`. It is the seed for the JWT generator. If not set a default value is created.
Secrets `OCT_OAUTH_GITHUB_CLIENTID` and `OCT_OAUTH_GITHUB_CLIENTSECRET` are required for GitHub OAtuh support.
Secrets `OCT_OAUTH_GOOGLE_CLIENTID` and `OCT_OAUTH_GOOGLE_CLIENTSECRET` are required for Google OAuth support.

#### Environment variables

Proper values should be set in the `.env` file in the root of the project. All environment variables are described [here](https://github.com/eclipse-oct/open-collaboration-tools/tree/main/packages/open-collaboration-server#configuration)

#### Update deployed service

Once you updated all secrets and environemnt variables [use this script](./scripts/post/updateServicesVariables.sh) to update the secret to the latest versions and the environment variables for the deployed service.

## Project deletion

If you want to delete the project use the following script:

- [Delete the project](./scripts/remove/removeProject.sh). It can be recovered within the next 30 days.
