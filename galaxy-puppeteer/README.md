# meteor/galaxy-puppeteer

`meteor/galaxy-puppeteer` is a galaxy-app image with changes for supporting running puppeteer.

As puppeteer run with superuser priveleges, you need to pass the flag '--no-sandbox'.
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