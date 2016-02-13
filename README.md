# atom-dynamic-macro

* [Dynamic Macro](https://github.com/masui/DynamicMacro)の[Atom](https://atom.io/)実装
* 同じキー操作を2度繰り返した後でCtrl-tを押すと繰り返された操作が再実行されます
 * ```abab```と入力した後でCtrl-tを押すと```ababab```になる
 * もう一度Ctrl-tを押すと```abababab```になる
 
   ![](https://gyazo.com/04b3f820957f08a821ecc8dd220fdc61.gif)
    
### インストール

* ```apm install atom-dynamic-macro```

### 実装

* JunSuzuki氏の[キーボードマクロパッケージ](http://qiita.com/JunSuzukiJapan/items/692dc5390ec545178e7d)を参考にした
* Atomのテンプレート生成器は```package.json```内に以下のような記述を生成し、
キーが押されたときはじめてパッケージがアクティベートされるようになっているが、
Atom起動時に```activate```が呼ばれるようにするために
これを```package.json```から削除している

    ```
    "activationCommands": {
      "atom-workspace": "atom-dynamic-macro:execute"
    },
    ```

### Issues

* 単純な入力/編集コマンドだけ利用可能
* Ctrl-tに固定されている
