# Notes on project creation

## Initialize NPM

```bash
npm init -y
```

## Install basic Express app toolset

```bash
npm i express dotenv cors helmet swagger-autogen and swagger-ui-express
```

## Add Typescript support

``bash
npm i -D typescript
npm i -D @types/node @types/express @types/dotenv @types/cors @types/helmet
npm i -D ts-node-dev
```

# Initialize TypeScript

```bash
npx tsc --init
```

## Create .env file

```bash
touch .env
```

Add content:

```
PORT=7000
```

## Ignore files we don't want in the repo.

```bash
touch .gitignore
```

Update .gitignore file

```
# SECURE the .env file DO NOT COMMIT
.env
# Dependency directories
node_modules/
```

## Update package.tson scripts

Add

```json
  "scripts": {
    "start": "node index.ts",
    "swagger-autogen": "node swagger.ts"
    "dev": "ts-node-dev --respawn --pretty --transpile-only src/index.ts"
  },
```

## Create a swagegr.ts file

```bash
touch swagger.ts
```

Add content:

```
const swaggerAutogen = require('swagger-autogen')()

const outputFile = './swagger_output.tson'
const endpointsFiles = ['./routers/memberRouter.ts']

swaggerAutogen(outputFile, endpointsFiles)
```

## Create the API src code dir

```bash
mkdir src
```

## Create the index file

```bash
touch src/index.ts
```

## Create directories for each object managed by the API

```bash
mkdir src/account
mkdir src/contact
mkdir src/flow
mkdir src/identity
mkdir src/nugget
mkdir src/flow_nugget
mkdir src/tenant
mkdir src/role
```

## Create TypeScript definitions

```bash
touch src/account/account.interface.ts
touch src/account/accounts.interface.ts
touch src/contact/contact.interface.ts
touch src/contact/contacts.interface.ts
touch src/flow/flow.interface.ts
touch src/flow/flows.interface.ts
touch src/identity/identity.interface.ts
touch src/identity/identities.interface.ts
touch src/nugget/nugget.interface.ts
touch src/nugget/nuggets.interface.ts
touch src/flow_nugget/flow_nugget.interface.ts
touch src/flow_nugget/flow_nuggets.interface.ts
touch src/tenant/tenant.interface.ts
touch src/tenant/tenants.interface.ts
touch src/role/role.interface.ts
touch src/role/roles.interface.ts
```

## Create Node service files

```bash
touch src/account/accounts.service.ts
touch src/contact/contacts.service.ts
touch src/flow/flows.service.ts
touch src/identity/identities.service.ts
touch src/nugget/nuggets.service.ts
touch src/flow_nugget/flow_nugget.service.ts
touch src/tenant/tenants.service.ts
touch src/role/roles.service.ts
```

## Create Express Routers / Controllers

```bash
touch src/account/account.router.ts
touch src/contact/contact.router.ts
touch src/flow/flow.router.ts
touch src/identity/identity.router.ts
touch src/nugget/nugget.router.ts
touch src/flow_nugget/flow_nugget.router.ts
touch src/tenant/tenant.router.ts
touch src/role/roles.router.ts
```

