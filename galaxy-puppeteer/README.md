# meteor/galaxy-puppeteer

`meteor/galaxy-puppeteer` is a galaxy-app image with changes for supporting running puppeteer.

- [DockerHub](https://hub.docker.com/r/meteor/galaxy-puppeteer/tags) - Galaxy Puppeteer repository on Docker Hub
- Stable version of the Docker image: ```meteor/galaxy-puppeteer:202308171810``` with [Extended Support Maintenance for Node.js](https://guide.meteor.com/using-node-v14.21.4)



As puppeteer runs with superuser privileges, you need to pass the flag '--no-sandbox'. (This is not a security flaw, as we are running with docker)
Ex:

```js
    const browser = await puppeteer.launch({
        args: [
        '--no-sandbox',
        '--disable-setuid-sandbox',
        '--disable-dev-shm-usage'
        ]
    });
    const page = await browser.newPage();
    await page.goto("https://www.google.com");
```

It's also bundled with the latest meteor node version.
