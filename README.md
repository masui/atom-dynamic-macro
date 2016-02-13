# atom-dynamic-macro

* [Dynamic Macro](https://github.com/masui/DynamicMacro)の[Atom](https://atom.io/)実装
* 同じキー操作を2度繰り返した後でCtrl-tを押すと繰り返された操作が再実行されます
 * ```abab```と入力した後でCtrl-tを押すと```ababab```になる
 * もう一度Ctrl-tを押すと```abababab```になる
 
   ![](https://gyazo.com/04b3f820957f08a821ecc8dd220fdc61.gif)
    
### インストール

* ```apm install atom-dynamic-macro```

### 参考資料

* JunSuzuki氏の[キーボードマクロパッケージ](http://qiita.com/JunSuzukiJapan/items/692dc5390ec545178e7d)

### Issues

* 単純な入力/編集コマンドだけ利用可能
* Ctrl-tに固定されている
