# Shaking Finger Action

A GitHub action that displays a gif of Stephen Colbert shaking his finger to a pull request on fail.


```
workflow "shaking finger action" {
  on = "check_suite"
  resolves = ["post gif on fail"]
}

action "post gif on fail" {
  uses = "jessfraz/shaking-finger-action@master"
  secrets = ["GITHUB_TOKEN"]
}
```
