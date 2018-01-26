# meteor/galaxy-app

`meteor/galaxy-app` is the default and official Galaxy container base image for Meteor applications designed to work with `meteor deploy` command.

### Build
In build stage, `setup.sh`
1. downloads the same version of Node.JS that was used to deploy the Meteor application, which is recorded in `.node_version.txt` inside the code bundle.
2. installs NPM dependencies.
3. runs additional code in `setup.sh` inside the code bundle.

### Run
By default, the run command is `node main.js` in `/app/bundle`. Alternatively, users can overwrite the run command by providing `run.sh` in the code bundle, though the Meteor tool doesn't provide an easy way to do this.
