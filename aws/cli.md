# AWS CLI

## Configuration & Credentials

```
aws configure sso
```

Fill the prompt with:

```
SSO session name (Recommended): macbook-air
SSO start URL [None]: https://georgeb.awsapps.com/start
SSO region [None]: us-east-2
SSO registration scopes [sso:account:access]:
```

After this, you will be prompted to configure a profile. Then, when you need credentials, you can use:

```
aws sso login --profile my-profile
```

## SSM Session Manager

To connect on an EC2 instance (without SSH), we use SSM Session Manger.

First, [install the plugin](https://docs.aws.amazon.com/systems-manager/latest/userguide/install-plugin-macos-overview.html).

Then, start a session:

```
aws ssm start-session --target instance-id
```
