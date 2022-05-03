// Here's how you set this up:
//
// 1. Replace YOUR_LAMBDA_ARTIFACTS_BUCKET_NAME with the name of the bucket you created in step 3
//    of the dev setup.
// 2. Replace 'CUSTOM_PREFIX' in the properties that have it with your name, your org name, or some
//    other unique identifier. For the S3 buckets and the Cognito user pool domain prefix, they
//    must be globally unique. For the CloudFormation stack name, it need only be unique to all
//    stacks deployed to your account.
// 3. Set any other optional parameters as desired. For the DynamoDB tables, their names must be
//    unique to all DynamoDB tables within your account.
// 4. Save the file.
//
// Note: these configuration parameters are *not* the same as the SAM template parameters - the names differ and the behavior in many areas also differ. Furthermore, some SAM template parameters like `StaticAssetsRebuildToken` are handled automatically internally and cannot be configured.
//
// See the "Deployer configuration" section of `BUILDING.md` for documentation on each of the parameters.
"use strict";

const n = 0

module.exports = {
  region: process.env.AWS_REGION,
  buildAssetsBucket: process.env.BUILD_ASSETS_BUCKET,
  stackName: process.env.STACK_NAME,
  siteAssetsBucket: process.env.SITE_ASSETS_BUCKET,
  apiAssetsBucket: process.env.API_ASSETS_BUCKET,
  cognitoDomainName: process.env.DEVELOPER_PORTAL_COGNITO,
  customersTableName: process.env.CUSTOMERS_TABLE_NAME,
  preLoginAccountsTableName: process.env.PRELOGIN_ACCOUNTS_TABLE_NAME,
  feedbackTableName: process.env.FEEDBACK_TABLE_NAME,
  // Optional, but highly recommended for easier identification.
  cognitoIdentityPoolName: process.env.COGNITO_IDENTITY_POOL_NAME,

  accountRegistrationMode: 'invite', // invite or open
  // Optional, but highly recommended so you can keep the site in sync with what's in the repo.
  staticAssetRebuildMode: 'overwrite-content',

  // Set development mode for local use.
  developmentMode: false,

  // New value with every deployment - possibly commit id?
  staticAssetRebuildToken: process.env.STATIC_ASSET_REBUILD_TOKEN,

  awsShortRegion: process.env.AWS_SHORT_REGION,
  stage: process.env.STAGE,
  brand: process.env.BRAND,
};
