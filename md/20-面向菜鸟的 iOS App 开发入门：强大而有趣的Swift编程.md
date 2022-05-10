Swift 是苹果公司于2014年发布的编程语言，它强大而直观，适用于 macOS、iOS、watchOS 和 Apple tvOS 等平台软件的开发。Swift 语法简洁、表现力强，由于它非常的年轻，因此融合了很多现代语言的优点。

> Swift 的进化堪称恐怖，每年都以肉眼可见的速度衍生出新功能、新特性。没办法，爹有钱啊。

本文将以入门者的角度，开发一款简单的待办清单 App， 你一定可以从中感受到 Swift 开发 iOS App 的乐趣和强大。

> 写给完全没接触过、又对 iOS App 开发感兴趣的你的。没有 Mac 电脑也没关系，不纠结具体语法，走马观花了解 Swift 写 App 的魔力就足够了，然后再决定你要不要学这门新鲜的语言。

## 准备工作

Xcode 是进行 iOS App 开发的集成开发工具。在 App Store 下载完成后，点击打开就进入了它的欢迎界面：

![swift-todo-1](https://blog.dusaiphoto.com/img/swift-todo-1.jpg)

点击`Create a new Xcode project`，创建新的项目。

进入到新的界面：

![swift-todo-2](https://blog.dusaiphoto.com/img/swift-todo-2.jpg)

选择要开发的软件类型，这里我们肯定选择 iOS APP 开发了。

点击下一步后进入项目详情界面：

![swift-todo-3](https://blog.dusaiphoto.com/img/swift-todo-3.jpg)

- `Product Name`：项目名称。
- `Team`： 开发团队。如果没有的话可能这里会提示你申请一个，通常用苹果账号就可以了。（就是你 iPhone 手机的那个账号）
- `Organization Identifier`： 机构识别码，通常是你的网站的反写。如果没有，随便写一个也Ok。
- `Interface` 和 `Language` 规定了开发所使用的语言和框架。选择 `SwiftUI` 和 `Swift` 。

其他条目按照图片中填写就行了，然后点击下一步，进入下一个界面：

![swift-todo-4](https://blog.dusaiphoto.com/img/swift-todo-4.jpg)

在此界面中选择项目需要保存的位置，点击创建按钮，项目就生成了。

![swift-todo-5](https://blog.dusaiphoto.com/img/swift-todo-5.jpg)

Xcode 的界面这里就不赘述了，读者可以自己摸索摸索。

提醒一下，记得将图片中序号1的渲染机型修改为 iPhone 13 Pro 或者你熟悉的手机机型。

## Hello World

让我们仔细观察 `ContentView.swift` 文件，此文件大体上分为三块：

- `import SwiftUI` 导入了 Swift 的核心框架，暂时先不管它。
- 尾部的结构体 `ContentView_Previews` 定义了模拟器中需要渲染的内容，也不管它。
- 中间的结构体 `ContentView` ，定义了手机页面的外观，它就是核心了。

观察 `ContentView` ，现在我们不用去关心什么是 `var body` 、 什么是 `some View` ，只需要知道 `var body` 后面花括号里的东西，直接代表了手机上界面的样子，就足够了。

所以那花括号里有什么？来看看：

```swift
Text("Hello, world!")
  .padding()
```

就算你完全没学过编程，看单词也能猜到个大概的意思：

- `Text("Hello, world!")`：页面中有一行文字，内容是 Hello, world! 。
- `.padding()`：文字周围用空白进行了某个宽度的填充。

是这样的吗？点击上图中模拟器面板的 `Resume` 按钮，渲染效果试试看：

![swift-todo-6](https://blog.dusaiphoto.com/img/swift-todo-6.jpg)

其实这里就能看出 SwiftUI 框架有意思的地方了：它描述了“UI 应该是什么样子”，而不是用一句句代码指导“应该怎样去构建 UI”。

举个例子，如果用传统的**命令式开发模式**，我们在代码中需要创建文本类、设置它的文字内容、将其添加到 UI 上、并且进行布局：

```swift
// 页面启动完成的生命周期函数
func viewDidLoad() {
  super.viewDidLoad()
  // 创建文本对象
  let label = UILabel()
  // 给文本赋值
  label.text = "Hello, World!"
  // 将文本对象添加到主 UI 中
  view.addSubview(label)
  // 下面省略了大一串布局代码
  // ...
}
```

相对的，用本文中聊到的**声明式开发模式**，你只要告诉程序“我需要一行文本”就可以了：

```swift
var body: some View {
  Text("Hello, world!")
}
```

是不是清爽多了？

## 状态和列表

欣赏完项目自动生成的代码后，接下来就要改动 `ContentView` 里的内容，让其变成一个可以展示待办清单列表的迷你项目了：

```swift
// struct 表示结构体，如果以前没接触过，你暂时把它理解成 class 类就好了
// (实际上结构体和类有本质区别，这里不展开讲)
struct ContentView: View {
  // @State 修饰的变量表示本地状态
  // todoList 的任何改变，都会自动触发 UI 的重新渲染
  @State private var todoList = ["Apple", "Pear", "Tomato"]
  
  var body: some View {
    // 列表控件
    List {
      // 循环渲染元素
      ForEach(todoList, id: \.self) { item in
        Text(item)
      }
    }
  }
}
```

被 `@State` 修饰的变量，代表了它是被管理起来的本地状态，用于 UI 中数据的双向绑定。

再看看 `var body` 中的改动：

- `List` 表示这里有一个列表。
- `ForEach` 表示列表的内容将依靠本地状态 `todoList` 动态生成。里面的 `id: \.self` 暂时不用去深究它，你只需要知道它用于识别列表中每个元素的身份就可以了。
- `item` 是列表的每个元素，用 `Text(item)` 展示了其文本内容。

> 如果你学习过 Vue ，那么理解起来就更加容易了：`@State` 就类似于 Vue 中的 `data` ； `ForEach(..., id: ...)` 和 Vue 中的 `v-for` 语法类似，需要一个 `id` 值作为列表元素的识别凭证。
>
> 再一次提醒，作为新手了解向的文章，你真的不需要逐句去斟酌每个对象、关键字、变量的具体含义，只需要知道它们大概的作用就足够了。

代码就这么多了，来看看渲染效果：

![swift-todo-7](https://blog.dusaiphoto.com/img/swift-todo-7.jpg)

用有限的几行代码，就创造出了一个简单而美观的列表，并且具有了良好的布局效果。

> 试试在模拟器中，将手机横向放置的布局效果，同样做到了很好的自适应，尽管你没写哪怕一行跟布局有关的代码。

## 自定义状态

上面的代码中，我们用了一个字符串数组 `todoList` ，定义了一个本地状态。但是如此简单的数据结构，对一个待办清单来说显然差了点意思。最起码的，如何表现此条项目完成与否？

这时候就需要复杂一点的数据结构了，比如将自定义对象作为本地状态的列表元素。

首先定义一个结构体 `ToDoItem` ：

```swift
struct ToDoItem: Identifiable {
  let id    = UUID()
  var isOn  = true
  let name: String
}
```

- 它满足 `Identifiable` 协议，因此后面代码的 `ForEach` 中就不用写难看的 `id: \.self` 了，程序会根据协议自动将 `ToDoItem` 里的 `let id = UUID()` 作为身份识别符。
- `isOn` 是一个**可更改**（`var`）的布尔值，表征了此对象是否已完成。
- `name` 是一个**不可更改**（`let`）的字符串，表征了对象的具体文本内容。

很好，接下来将 `ContentView` 修改成下面这样：

```swift
struct ContentView: View {
  // 装饰器 @State 表示 todoList 是一个受监控的本地状态
  @State private var todoList = [
    ToDoItem(name: "Apple"),
    ToDoItem(name: "Pear"),
    ToDoItem(name: "Tomato")
  ]
  
  var body: some View {
    // 列表元素
    List {
      // 动态遍历渲染
      ForEach(todoList) { item in
        Text(item.name)
      }
    }
  }
}
```

- 将本地状态的列表元素替换为了 `ToDoItem` 结构体。
- 注意观察 `ForEach` 中的变化。

渲染界面如下：

![swift-todo-8](https://blog.dusaiphoto.com/img/swift-todo-8.jpg)

表面上和前一小节没有变化，但是内部的数据结构变为了自定义结构体，后续就可以愉快地持续扩展结构体里的属性了。

## 输入框和按钮

对待办清单 App 来说，光有列表还不够，最起码得能输入新条目。所以得添加以下两个控件：

- 文本输入框 `TextField` ，用于输入新条目的文本。
- 按钮 `Button` ，用于提交输入的文本。

新增以下代码：

```swift
struct ContentView: View {
  @State private var todoList = [
    // 省略已有代码 ...
  ]
    
  // 新增本地状态 newName
  // 用于接收用户输入的文本
  @State private var newName: String = ""

  var body: some View {
    // 新增代码
    // VStack: 垂直方向布局
    VStack {
      // HStack: 水平方向布局
      HStack {
        // 文本控件
        TextField("输入新事项", text: $newName)
        // 按钮控件
        Button("确认") {
          // 点击按钮后执行的操作
          let newItem = ToDoItem(name: newName)
          todoList.append(newItem)
          newName = ""
        }
      }
      .padding()
      
      // 省略已有代码
      List {
        // ...
      }
    }
  }
}
```

有点轻车熟路了对吧，在 Swift 的世界里，尽量不让你指挥它“这个控件要如何执行初始化、那个界面要如何添加对象”，你只要告诉它“这里有什么”就行。

稍微研究下新写的代码：

- 新增了一个状态 `newName` ，用来放置用户在输入框里键入的文本。
- `VStack` 和 `HStack` 分别代表垂直方向布局和水平方向布局。所以后面你可以看到，输入控件整体和列表是垂直布局的，而输入框和按钮是水平布局的。
- `TextField` 是输入框控件，注意它第二个参数 `text: $newName` 里的美元符号 `$` ，这种特殊写法表示传入的 `newName` 是双向绑定的状态，而不是简单的传入了 `newName` 变量里面的值。双向绑定的意思是不管你在代码里改变 `newName` 的值，还是在输入框控件里修改，它两是完全同步变化的，并且这个变化会立刻反应到 UI 中。
- `Button` 是按钮控件，点击后会创建一个新的列表元素，把它添加到 `todoList` 中，并且将输入框控制的文本清除。

重新渲染模拟器，看看效果：

![swift-todo-9](https://blog.dusaiphoto.com/img/swift-todo-9.jpg)

由于输入效果是动态的，所以你需要点一下上图箭头指的那个按钮，让渲染从静态切换为动态。

然后随便输入点东西，并点击确认按钮：

![swift-todo-10](https://blog.dusaiphoto.com/img/swift-todo-10.jpg)

顺利的话，新条目就添加到列表里了：

![swift-todo-11](https://blog.dusaiphoto.com/img/swift-todo-11.jpg)

怎么样，是不是有点意思？

## 让我们更进一步

经过上面的折腾，虽然我们已经把列表数据转化为自定义结构体 `ToDoItem()` 了，但数据和界面还可以进一步解耦。随着项目逐渐扩展，程序架构需要更明确的分层和细化。

如果把 UI 界面描述为**视图（View）**，数据描述为**模型（Model）**，那么我们还需要一个桥梁，帮助视图和模型进行多对多的通信和数据流的双向绑定。

这个桥梁在上面的代码中是没有的，因此先来写它。

> 实际写项目时应该把视图、模型和“桥梁”都作为单独的文件。本文为了方便就没这么做了。

新增一个 `ToDoViewModel` 类如下：

```swift
class ToDoViewModel: ObservableObject {
  // @Published 装饰需要进行绑定的数据
  @Published private(set) var todoList: [ToDoItem]
    
  // 初始化
  init() {
    self.todoList = [
      ToDoItem(name: "Apple"),
      ToDoItem(name: "Pear"),
      ToDoItem(name: "Tomato")
    ]
  }
  
  // 新增数据条目
  func append(_ item: ToDoItem) {
    todoList.append(item)
  }
  
  // 改变条目是否完成的状态
  func toggle(_ item: ToDoItem) {
    // 这一行代码将 item 的 id 赋值给 index 变量
    // 语法原理暂时不要去深究
    if let index = todoList.firstIndex(where: {$0.id == item.id}) {
      // toggle() 函数将布尔值反转
      todoList[index].isOn.toggle()
    }
  }
}
```

这个类的关键就在于用 `@Published` 装饰的 `todoList` ，它就是需要和视图进行绑定的数据模型。视图不应该直接修改模型，所以你看到有关键字 `private(set)` 限制了类外部的指令只能读取不能修改。对模型的修改要通过 `ToDoViewModel` 内置的方法。“桥梁类”里可以有多个 `@Published` 装饰的模型，也可以提供给多个视图使用。

接下来的模型没有变化，还是之前的那个结构体：

```swift
struct ToDoItem: Identifiable {
  let id    = UUID()
  var isOn  = true
  let name: String
}
```

最后是视图，稍微有点长：

```swift
struct ContentView: View {
  // @StateObject 用于自定义的“桥梁类”，作用和前面的 @State 差不多
  @StateObject private var viewModel = ToDoViewModel()
  // newName 状态无改动
  @State private var newName: String = ""
  
  var body: some View {
    VStack {
      // 之前的 TextField 和 Button
      // 无改动
      HStack {
        // ...
      }
      .padding()
      
      List {
        ForEach(viewModel.todoList) { item in
          HStack {
            // .foregroundColor 根据 isOn 的状态改变文本的颜色
            // (a ? b : c) 被称为三元操作符
            Text(item.name)
              .foregroundColor(item.isOn ? .primary : .gray)
            
            // 在两个元素间填充占位的空白
            Spacer()
            
            // Group 里模拟了单选框
            // Group 是和 VStack 类似的布局对象
            // 注意它里面是可以写 if 这种控制流语句的
            // 根据 isOn 的值，改变单选框的外观
            Group {
              if item.isOn {
                // Image 调用了内置的图片
                // "circle" 是个中空的圈
                Image(systemName: "circle")
              }
              else {
                // 中间带勾的圈
                Image(systemName: "checkmark.circle.fill")
              }
            }
            // 将单选框渲染为蓝色
            .foregroundColor(.blue)
            // 定义了单选框的点击事件
            // 点击后触发了“桥梁”类的 toggle() 方法
            .onTapGesture {
              viewModel.toggle(item)
            }
          }
        }
      }
    }
  }
}
```

看起来改了很多，但其实真的挺简单的：

- 自定义的“桥梁类”要用 `@StateObject` 装饰。
- UI 里 `Group` 那一坨模拟了单选框，单选框的外观会根据 `item.isOn` 布尔值来调整。

来看看效果。刷新模拟器：

![swift-todo-12](https://blog.dusaiphoto.com/img/swift-todo-12.jpg)

列表的每个元素多了个单选框。

点击单选框，就变成下面这样了：

![swift-todo-13](https://blog.dusaiphoto.com/img/swift-todo-13.jpg)

文字变灰色，单选框外观也变成了带勾的完成状态。大功告成了。

没错，折腾完上面这个简单的例子，你已经摸到现在愈发主流和火热的架构模式：MVVM 了！（Model-View-ViewModel）

在 MVVM 架构中 View 和 Model 不能直接通信，必须通过 ViewModel。ViewModel 是 MVVM 的核心，它通常是一个观察者，当 Model 数据发生变化时 ViewModel 能够监听并通知到对应的 View 做 UI 更新，反之当用户操作 View 时 ViewModel 也能获取到数据的变化并通知 Model 数据做出对应的更新操作。这就是 MVVM 中数据的**双向绑定**。而上面一直在说的“桥梁”，其实就是这个 ViewModel （视图模型）了。

还挺酷的吧？

## 什么，暗黑模式已经搞定了？

主流的 App 都具有两种色彩模式，白天是明亮模式；夜间自动切换到暗黑模式，保护大半夜葛优瘫的你，和你那迷人的小眼睛。

那该如何实现两种色彩模式呢？小节标题已经剧透了：你在不知不觉中已经搞定暗黑模式了。

不信将模拟器切换到夜间看看：

![swift-todo-14](https://blog.dusaiphoto.com/img/swift-todo-14.jpg)

Swift 尽可能的帮助你脱离命令式的代码，让你将注意力集中在业务真正需要的地方。

## 总结

你能看到文章的这个位置，相信也不需要我做什么总结了。Swift 本身是一门功能强大、类型安全、吸收了各种现代语言优点的非常年轻的语言。用 Swift 写 App 能感受到它简洁又强大的能力。

下一步，你可以从这些资料开始 Swift 之旅：

- [Swift 编程语言](https://www.cnswift.org/) - 可能是最用心的基础语法翻译。
- 斯坦福大学 SwiftUI 开发 CS193p - 每年都是那个熟悉的爷爷 Paul Hegarty 讲课，尽量看新的，因为 Swift 进化速度非常之快。
- [HackingWithSwift](https://www.hackingwithswift.com/) - Swift 的超级宝藏网站，从小知识到教程，你能想到的它都有。

走你，让我们在 App Store 相见！

---

> 如果本文对你有帮助，欢迎各种渠道和我交流，我决定要不要继续写安利向的续作，哈哈。
>
> 作者杜赛，喜欢写辣鸡 App，博客有很多[Python搭建Web程序](https://www.dusaiphoto.com/topic/)的教程，欢迎来围观。
