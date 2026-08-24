# Setup Cloudflare Pages

We will use Cloudflare Pages to host static pages from the Staging branch

## Create Cloudflare API token

- Login to Cloudflare > on the top right, click person icon to bring up your account name > click profile
- on the left sidebar, click API tokens > click Create Token
- Under Custom token, click Get started

- Token name: khdotca-stg-deploy
- Permissions:
	- Account
	- Cloudflare Pages
	- Edit
- Account Resources:
	- Include
	- just your specific account
- Click Continue to summary > Click Create token
- Save the token
- test the token with the sample curl command

## Create Cloudflare pages project

Create the project from your local computer. Tell CF the name of our production branch, which is actually "staging"

### Get Cloudflare Account ID

- On the Cloudflare dashboard left sidebar, click Build > Compute > Workers & Pages
- Copy the Account ID

### Create Cloudflare Project

- Set environment variables with real values. Then run npx wrangler

```bash
export CLOUDFLARE_API_TOKEN='paste-your-token-here'
export CLOUDFLARE_ACCOUNT_ID='paste-your-account-id-here'
```


```bash
npx wrangler pages project create kennethho-stg --production-branch=staging
```


```
Need to install the following packages:
wrangler@4.125.0
Ok to proceed? (y) y

 ⛅️ wrangler 4.125.0
────────────────────
✨ Successfully created the 'kennethho-stg' project. It will be available at https://kennethho-stg.pages.dev/ once you create your first deployment.
To deploy a folder of assets, run 'wrangler pages deploy [directory]'.
```

### Verify production branch is set to `staging`

```bash
curl -s "https://api.cloudflare.com/client/v4/accounts/$CLOUDFLARE_ACCOUNT_ID/pages/projects/kennethho-stg" -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" | python3 -m json.tool | grep -i -E "production_branch|success|\"code\"|message"
```

```bash
        "production_branch": "staging",
    "success": true,
    "messages": []
```


## Attach the custom domain


- Cloudflare dashboard → Workers & Pages → click kennethho-stg.
- Click on the Custom domains tab → Set up a domain.
- Enter stg.kennethho.ca → Continue → Activate domain.

Cloudflare is already the authoritative DNS for kennethho.ca so it autocreates the CNAME record and issues the TLS cert

Takes a min or two. Cert may take a little longer

## Update Repo with Cloudflare Secrets

- Go to the repo > settings > secrets and variables > actions 
- Click on the Secrets tab
- Under the Repository Secrets section, click New repository secret
	- Create the following secrets with the values from the previous steps
		- CLOUDFLARE_API_TOKEN
		- CLOUDFLARE_ACCOUNT_ID