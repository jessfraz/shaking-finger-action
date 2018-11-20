# Shaking Finger Action

A GitHub action that displays a gif of Stephen Colbert shaking his finger to a pull request on fail.

It will also automatically clean up the comment when the build passes :)


```
workflow "shaking finger action" {
  on = "pull_request"
  resolves = ["post gif on fail"]
}

action "post gif on fail" {
  uses = "jessfraz/shaking-finger-action@master"
  secrets = ["GITHUB_TOKEN"]
}
```

![demo](demo.png)
