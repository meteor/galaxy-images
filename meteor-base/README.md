# meteor/meteor-base
This repository provides a minimal Ubuntu distribution with meteor pre-installed. You can use it in your CI and extend it as you please.

## Example Usage

```dockerfile
FROM meteor/meteor-base:20211013T200759Z_489f5fe

USER mt
WORKDIR /home/mt


COPY --chown=mt app/ cloned-repo-inside-host-pc/

RUN	cd app && meteor deploy
```

## Last released version

meteor/meteor-base:20211013T200759Z_489f5fe
