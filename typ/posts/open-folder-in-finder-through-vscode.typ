#import "@preview/shiroa:0.1.0": *
#import "@preview/typst-apollo:0.1.0": pages
#import pages: *
#import "@preview/shiroa:0.1.0": get-page-width, target, is-web-target, is-pdf-target, plain-text

#import "@preview/unequivocal-ams:0.1.0": theorem, proof

#show: project.with(
  title: "在 Finder 中使用 VSCode 打开文件夹",
  authors: (
    (
      name: "purofle",
      email: "purofle@gmail.com",
    ),
  ),
)

效果如下：
#image("images/finder.png")

== 步骤
1. 打开 Automator 选择创建 Quick Action
2. 设置 receives 为 files or folders in Finder
3. 在左侧搜索框中输入 Open Finder Items，拖拽到右侧工作流中，设置为 Open with VSCode

设置完成后如下：
#image("images/automator.png")

之后重命名后保存文件即可在 Finder 中使用。