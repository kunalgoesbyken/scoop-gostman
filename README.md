# scoop-gostman

Scoop bucket for [Gostman](https://github.com/kunalgoesbyken/gostman).

```powershell
scoop bucket add gostman https://github.com/kunalgoesbyken/scoop-gostman
scoop install gostman       # desktop app (portable)
scoop install gostman-cli   # command line
```

The manifests follow Gostman releases on their own: a scheduled workflow runs `update.sh` every three hours and commits the new version and checksums from the release's `SHA256SUMS`.
