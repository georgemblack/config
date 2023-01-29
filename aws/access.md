# AWS CLI Access

```
aws configure sso
```

Fill the prompt with:

```
SSO session name (Recommended): macbook-air
SSO start URL [None]: https://georgeblack.awsapps.com/start
SSO region [None]: us-east-1
SSO registration scopes [sso:account:access]:
```

After this, you will be prompted to configure a profile. Then, when you need credentials, you can use:

```
aws sso login --profile my-profile
```