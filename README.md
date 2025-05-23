# Node.js CI/CD Deployment Pipeline using Terraform + Ansible + GitHub Actions

🚀 A fully automated deployment pipeline that provisions an AWS EC2 instance, configures it, and deploys a Node.js app using:

- **Terraform**: For infrastructure provisioning on AWS
- **Ansible**: For configuration management and app deploy
- **GitHub Actions**: To automate the full process on every push

---

## 🧩 What This Does

This project automates the following:

1. **Provisions** an AWS EC2 instance via **Terraform**
2. **Configures** the server and installs dependencies via **Ansible**
3. **Deploys** your Node.js application automatically
4. **Prints** the public URL in GitHub Actions logs after successful deployment

All without ever touching the AWS Console manually.

---

## 📁 Project Structure

```
nodejs-deploy/
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions workflow
├── ansible/
│   ├── inventory.ini.template  # Template for dynamic Ansible inventory
│   ├── node_service.yml        # Main Ansible playbook
│   └── roles/
│       └── app/
│           └── tasks/
│               └── main.yml    # Tasks: install Node.js, clone repo, start app
├── terraform/
│   └── main.tf                 # Terraform AWS setup
├── app/
│   ├── index.js                # Simple "Hello World" Node.js app
│   └── package.json            # App metadata and dependencies
└── README.md                   # You are here!
```

---

## 🔐 Required GitHub Secrets

You must set these secrets in your GitHub repository settings under **Settings > Secrets and variables > Actions**

| Secret Name | Description |
|-------------|-------------|
| `AWS_ACCESS_KEY_ID` | Your AWS IAM user access key ID |
| `AWS_SECRET_ACCESS_KEY` | Your AWS IAM secret access key |
| `SSH_PRIVATE_KEY` | Private SSH key used to connect to EC2 |
| `KEY_NAME` | The name of the SSH key pair uploaded to AWS |
| `AWS_DEFAULT_REGION` | Region where resources will be created (e.g., `us-east-1`)

> ⚠️ Never hardcode these values in your code — always use GitHub Secrets.

---

## 🚀 How It Works

### Step 1: Push Code to GitHub
When you push to the `main` branch, GitHub Actions is triggered.

### Step 2: Terraform Creates Infrastructure
- Spins up a new EC2 instance in AWS
- Opens ports 22 (SSH) and 80 (HTTP)
- Outputs public IP address

### Step 3: Ansible Deploys the App
- Installs Git and Node.js
- Clones your app repo
- Runs `npm install` and starts the app

### Step 4: Public URL Displayed
After deployment, the public IP is printed in logs like this:

```
🌐 Access your app at: http://54.89.123.45
```

---

## 🛠️ How to Use This Pipeline

### 1. Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git
cd YOUR_REPO
```

### 2. Set Up GitHub Secrets

Go to your repo on GitHub → **Settings > Secrets and variables > Actions**

Add the following secrets:

```plaintext
AWS_ACCESS_KEY_ID = <your-key-here>
AWS_SECRET_ACCESS_KEY = <your-secret-here>
SSH_PRIVATE_KEY = <your-private-key>
KEY_NAME = mykey
AWS_DEFAULT_REGION = us-east-1
```

> Make sure your private key starts with `-----BEGIN RSA PRIVATE KEY-----`  
> And ends with `-----END RSA PRIVATE KEY-----`

### 3. Push to `main` Branch

Make any small change or run:

```bash
git add .
git commit -m "Trigger GitHub Action"
git push origin main
```

### 4. Watch the Workflow Run

Go to the **Actions** tab in GitHub. You'll see the workflow running.

After success, look for the output:

```
🌐 Access your app at: http://<INSTANCE_IP>
```

Paste the IP into your browser and see your app live!

---

## 💡 Tips for Success

- ✅ Always test locally before pushing to GitHub
- 🧪 Use `terraform destroy` to clean up AWS resources when done
- 📦 Extend with PM2 or systemd for production-ready apps
- 🔄 Reuse this pipeline for other services or environments

---

## 🧩 Optional Enhancements

| Feature | Why Add It |
|--------|------------|
| Auto-cleanup (`terraform destroy`) | Save costs by cleaning up test servers |
| Nginx reverse proxy | Better HTTP handling and routing |
| PM2 process manager | Keep Node.js app running |
| Custom Domain | Replace IP with a real domain |
| Health Check | Ensure app responds after deploy |
| Slack Alerts | Get notified on deployment status |


## 👥 Contributing

Feel free to contribute or extend this pipeline:
- Add support for GCP/Azure
- Improve logging and debugging
- Add rollback logic
- Support multiple environments

Just open a PR! 😊
