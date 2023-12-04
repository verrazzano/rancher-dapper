## Build Instructions

The upstream tag this release is branched from is `v0.6.0`

### Build Dapper 

Create dapper binary in `/bin` folder of repo.
```
make go-build
```

Install dapper in $GOPATH/bin
```
make install
```

### Tag Dapper

```
git tag v0.6.0-v8o-2
git push origin v0.6.0-v8o-2
```